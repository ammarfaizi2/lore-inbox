Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVBHQhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVBHQhL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 11:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVBHQhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 11:37:10 -0500
Received: from gprs215-103.eurotel.cz ([160.218.215.103]:61571 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261572AbVBHQhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 11:37:04 -0500
Date: Tue, 8 Feb 2005 17:36:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Merging the Suspend2 freezer implementation.
Message-ID: <20050208163644.GG1622@elf.ucw.cz>
References: <1107822206.2756.18.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107822206.2756.18.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm keen to see if we can merge Suspend2's freezer implementation after
> 2.6.11. Does that conflict with any of your intended changes? If it
> doesn't, I'll submit a patch for review/merge as quickly as I can.

Freezer is very independend, and no, I do not plan any changes in that area.

> The main change involves the introduction of a new SYNCTHREAD flag. We
> use this to avoid deadlocking over processes that are running sys_sync
> and siblings. Processes that enter those routines get the flag added,
> and it's removed when they exit the sync routine. We then freeze in four
> stages: 

Is SYNCTHREAD neccessary for me, too, or is it needed for suspend2, only?

> 1) Freeze user space threads without SYNCTHREAD set;
> 2) Freeze user space threads with SYNCTHREAD set;
> 3) Run our own sys_sync in case no one else was syncing
> 4) Freeze kernel space threads without NOFREEZE set.
> 
> I'd also like to look at your SMP support and see if we can improve
> compatibility there at the same time.

Why not... But parts of smp support really need to be in assembly, and
they are not, neither in swsusp nor in suspend2...

> Finally I'd like to merge the support for freezer flags on workqueues.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
