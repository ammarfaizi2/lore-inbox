Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965227AbVKBVED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965227AbVKBVED (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965229AbVKBVED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:04:03 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31900 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965227AbVKBVEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:04:01 -0500
Date: Wed, 2 Nov 2005 22:03:26 +0100
From: Pavel Machek <pavel@suse.cz>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: swsusp not able to stop tasks
Message-ID: <20051102210326.GC23943@elf.ucw.cz>
References: <4368BDA7.6060401@drzeus.cx> <20051102133825.GG30194@elf.ucw.cz> <4368DB5C.7070609@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4368DB5C.7070609@drzeus.cx>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>I'm having problem with swsusp in the recent kernels (somewhere around 
> >>the late 2.6.14 rc:s). It says it cannot suspend all tasks:

> >>[ 7223.525225] Stopping tasks: 
> >>=======================================================================================================================================
> >>[ 7229.532506]  stopping tasks failed (1 tasks remaining)
> >>[ 7229.532529] Restarting tasks...<6> Strange, kauditd not stopped
> >>    
> >
> >What is this kauditd? Try turning auditing off in kernel config, and
> >it should go away. If it does, add try_to_freeze() at place where
> >sleep is possible into kauditd...
> 
> That it did. And the machine suspends fine with audit removed. I'll have 
> a look at inserting those try_to_freeze().

Good.

> >>Some late addition (post 2.6.14) also makes my keyboard crap out after 
> >>one of these cycles. Not sure it the TSC funkiness was present
> >>before this.
> >
> >Is that reproducible?
> 
> Somewhat. My short test now seems to indicate that it happens about 50% 
> of the time.

Try asking vojtech and dmitry, keyboard problems may be reason for git
bisect. But ask vojtech/dmitry first.
								Pavel
-- 
Thanks, Sharp!
