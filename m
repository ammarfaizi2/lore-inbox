Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267507AbUGWC6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267507AbUGWC6g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 22:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267508AbUGWC6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 22:58:36 -0400
Received: from [216.208.38.106] ([216.208.38.106]:42741 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267507AbUGWC6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 22:58:33 -0400
Date: Fri, 23 Jul 2004 03:05:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nathan Bryant <nbryant@optonline.net>
Cc: Luben Tuikov <luben_tuikov@adaptec.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, random1@o-o.yi.org
Subject: Re: [PATCH] prelim ACPI support for aic7xxx
Message-ID: <20040723010539.GA1477@elf.ucw.cz>
References: <41006A88.9040700@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41006A88.9040700@optonline.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch (against arjanv's latest kernel, but should apply to 
> 2.6.8-rc) is still a little messy and NOT ready to go into the mainline 
> kernel... Luben hasn't seen it yet (Hi Luben!), so the usual disclaimers 
> apply. But it's time to get some more eyes on it. The good news is it 
> works, the bad news is there is no support for error recovery during 
> those few seconds when the bus is setttling and hard disk is powering up 
> after a resume. (Need suggestions on how best to attack that part, I 
> really don't know anything about SCSI...) It works, after a few 
> residuals if your filesystems are mounted read-only, however. If you are 
> mounted read-write then you will get aborted commands, ext3 will 
> complain, and remount your fs read-only until you reboot. To avoid this, 
> remount read-only, suspend/resume, then remount read-write manually 
> after everything starts working.

If ou are playing with this kind of stuff, I suggest you to use ext2
(not ext3) or at least fsck *very* often.
								Pavel
-- 
When do you have heart between your knees?
