Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265247AbTGHS73 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 14:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267260AbTGHS73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 14:59:29 -0400
Received: from ns.suse.de ([213.95.15.193]:56850 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265247AbTGHS72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 14:59:28 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: jkenisto@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH - RFC] [1/2] 2.6 must-fix list - kernel error reporting
References: <3F0AFFE6.E85FF283@us.ibm.com.suse.lists.linux.kernel>
	<20030708105912.57015026.akpm@osdl.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 08 Jul 2003 21:14:04 +0200
In-Reply-To: <20030708105912.57015026.akpm@osdl.org.suse.lists.linux.kernel>
Message-ID: <p733chgrfur.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> The layout of `struct kern_log_entry' may be problematic.  Think of the
> situation where a 64-bit kernel constructs one of these and sends it up to
> 32-bit userspace.  Will the structure layout be the same under the 32-bit
> compiler as under the 64-bit one?

No it won't. Best is to order the fields by size (arrays ordered by their
subtype). This should always give compatible alignment.

-Andi
