Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbULSRgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbULSRgs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 12:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbULSRgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 12:36:48 -0500
Received: from gprs215-234.eurotel.cz ([160.218.215.234]:18048 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261323AbULSRgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 12:36:37 -0500
Date: Sun, 19 Dec 2004 18:36:13 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Michael Frank <mhf@berlios.de>
Cc: softwaresuspend-devel@lists.berlios.de,
       Patrick Mochel <mochel@digitalimplant.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [SoftwareSuspend-devel] 2.6 Suspend PM issues
Message-ID: <20041219173613.GB1039@elf.ucw.cz>
References: <200412171315.50463.mhf@berlios.de> <20041218074202.GG29084@elf.ucw.cz> <20041218075003.GA3015@elf.ucw.cz> <200412191114.25930.mhf@berlios.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412191114.25930.mhf@berlios.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > ...which will not work anyway, swsusp1 or swsusp2. Have you actually
> > tried it?
> 
> I put suspend support into 2.4 serial driver and use it. It does work.
> 
> 2.6 serial driver suspend was not working a year ago, have not tried since.
> 
> > During boot, BIOS is probably going to play with RTS anyway. So no
> > matter what you do during suspend, you are probably going to screw it
> > up anyway on the boot just before resume.
> 
> Luckily not on several of my machines and the linux 2.4 driver at least 
> does not turn the lines on until resume tells it to do so...

If 2.6 serial does not turn it on boot, there's no reason it should
turn it on during resume() [and it would be a bug].

Find out what 2.6 serial does, and fix the bug...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
