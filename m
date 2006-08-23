Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWHWFuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWHWFuE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 01:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWHWFuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 01:50:04 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:52635
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751407AbWHWFuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 01:50:02 -0400
Date: Tue, 22 Aug 2006 22:50:00 -0700 (PDT)
Message-Id: <20060822.225000.92584438.davem@davemloft.net>
To: ebrower@gmail.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: sym53c8xx PCI card broken in 2.6.18
From: David Miller <davem@davemloft.net>
In-Reply-To: <ec7cefb0608222235p155b7ab0ld8a23d2db1fbe56d@mail.gmail.com>
References: <ec7cefb0608222059g48c36384keefedf8e19771cb7@mail.gmail.com>
	<20060822.210136.59470258.davem@davemloft.net>
	<ec7cefb0608222235p155b7ab0ld8a23d2db1fbe56d@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Eric Brower" <ebrower@gmail.com>
Date: Tue, 22 Aug 2006 22:35:14 -0700

> Would you consider assigning -1 to lenp (if provided) in
> of_find_property() when no matching device is found?

I think checking for NULL should be the first thing a caller of these
interfaces should do.  So from that perspective, I don't think putting
anything in *lenp makes sense.  It's value is undefined.

In fact since we'll leave *lenp alone if the property doesn't exist,
you can initialize it to -1 if you want to simplify your checks.
