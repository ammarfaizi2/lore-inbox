Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbVHWM66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbVHWM66 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 08:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVHWM66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 08:58:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7348 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932160AbVHWM65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 08:58:57 -0400
Date: Tue, 23 Aug 2005 14:58:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] suspend: update warnings
Message-ID: <20050823125850.GA3735@elf.ucw.cz>
References: <20050822081528.GA4418@elf.ucw.cz> <1124753566.5093.8.camel@localhost> <20050823125017.GB3664@elf.ucw.cz> <1124801595.4602.18.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124801595.4602.18.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > + * If you have unsupported (*) devices using DMA, you may have some
> > > > + * problems. If your disk driver does not support suspend... (IDE does),
> > > > + * it may cause some problems, too. If you change kernel command line 
> > > > + * between suspend and resume, it may do something wrong. If you change 
> > > > + * your hardware while system is suspended... well, it was not good idea;
> > > > + * but it wil probably only crash.
> > > 
> > > The most common driver issues I see involve:
> > > - USB being built in or as modules that are still loaded while
> > > suspending (getting better, but not there yet)
> > > - DRI being used in X where the drivers don't properly support
> > > suspend/resume (NVidia esp)
> > > - Firewire
> > > - CPU Freq  (improving too)
> > > 
> > > It might be good to mention these areas too.
> > 
> > Well, right; but those 'only' cause system to crash during suspend. I
> > was talking about really dangerous stuff.
> > 
> > Both usb and cpufreq seems to work okay here.
> 
> It depends on what you're using. I believe one of the usb root hub
> drivers is okay, the others aren't. Similar for cpufreq. USB certainly
> accounts for a high percentage of the failures I see.

Do you remember which one is it? I have UHCI here, and it seems to
work okay. powernow-k8 and cpufreq-centrino also seems to behave ok.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
