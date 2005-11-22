Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbVKVQRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbVKVQRY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbVKVQRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:17:24 -0500
Received: from bee.hiwaay.net ([216.180.54.11]:8912 "EHLO bee.hiwaay.net")
	by vger.kernel.org with ESMTP id S1751314AbVKVQRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:17:23 -0500
Date: Tue, 22 Nov 2005 10:17:12 -0600
From: Chris Adams <cmadams@hiwaay.net>
To: linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Message-ID: <20051122161712.GA942598@hiwaay.net>
References: <fa.d8ojg69.1p5ovbb@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122152531.GU12760@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, Jan Harkes <jaharkes@cs.cmu.edu> said:
>The only thing that tends to break are userspace archiving tools like
>tar, which assume that 2 objects with the same 32-bit st_ino value are
>identical.

That assumption is probably made because that's what POSIX and Single
Unix Specification define: "The st_ino and st_dev fields taken together
uniquely identify the file within the system."  Don't blame code that
follows standards for breaking.

>I think that by now several actually double check that theinode
>linkcount is larger than 1.

That is not a good check.  I could have two separate files that have
multiple links; if st_ino is the same, how can tar make sense of it?
-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.
