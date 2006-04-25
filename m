Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWDYIaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWDYIaN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWDYIaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:30:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24015 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750756AbWDYIaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:30:11 -0400
Date: Tue, 25 Apr 2006 10:29:17 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jeff Chua <jchua@fedex.com>
Cc: Mark Lord <lkml@rtr.ca>, Jeff Chua <jeff.chua.linux@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, Chris Ball <cjb@mrao.cam.ac.uk>,
       Arkadiusz Miskiewicz <arekm@maven.pl>, Jeff Garzik <jeff@garzik.org>,
       Matt Mackall <mpm@selenic.com>, Jens Axboe <axboe@suse.de>,
       randy_d_dunlap@linux.intel.com,
       Linux Kernel <linux-kernel@vger.kernel.org>, ncunningham@linuxmail.org
Subject: Re: sata suspend resume ... (fwd)
Message-ID: <20060425082915.GA4789@elf.ucw.cz>
References: <Pine.LNX.4.64.0604232153230.2890@boston.corp.fedex.com> <444C2821.5090409@rtr.ca> <Pine.LNX.4.64.0604250810370.5533@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604250810370.5533@boston.corp.fedex.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here's the trick. Next I switched to SMP mode ... reconfigured with 
> CONFIG_SMP. CONFIG_SOFTWARE_SUSPEND disappeared. Here's the credit ... I 
> took a look at how suspend2 tried to suspend under SMP ... first switch to 
> UP and then do the suspension. Taking a look at the dependency ...
> 
> 	SOFTWARE_SUSPEND depends on SUSPEND_SMP
> 	CONFIG_SUSPEND_SMP depends on HOTPLUG_CPU
> 	CONFIG_HOTPLUG_CPU depends on !X86_PC

Just switch to X86_BIGSMP. It should work on normal PCs, too.
								Pavel
-- 
Thanks for all the (sleeping) penguins.
