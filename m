Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263119AbVG3TxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263119AbVG3TxE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 15:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbVG3TxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 15:53:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44772 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263119AbVG3Tv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 15:51:28 -0400
Date: Sat, 30 Jul 2005 21:51:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Message-ID: <20050730195116.GB9188@elf.ucw.cz>
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de> <1122678943.9381.44.camel@mindpipe> <20050730120645.77a33a34.Ballarin.Marc@gmx.de> <1122746718.14769.4.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122746718.14769.4.camel@mindpipe>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > What kind of results do you get with a more realistic setup, like
> > > running KDE or Gnome OOTB?
> > > 
> > 
> > Here are results with KDE running.
> > 
> > - no peripherals attached, i.e. truly mobile setup.
> > - all modules loaded
> > - klaptopdaemon disabled in order to eliminate competition in polling the
> >   already slow battery controller
> > - furthermore, I found that artsd prevents entering C3 and generally
> >   increases power consumption (ALSA, snd_intel8x0)
> > - voltage is 16.5V
> 
> > HZ=100:                   HZ=1000:      DIFF:
> > 
> > 1) averages:
> > 
> > backlight off, arstd off:
> > 637.17                    679.67        42.5
> 
> > backlight off, artsd on:
> > 799.46                    806.13        6.67
> 
> So it looks like artsd wastes way more power DMAing a bunch of silent
> pages to the sound card than HZ=1000.
> 
> There's nothing the ALSA layer can do about this, it's a KDE bug.
> 
> I think this is a good argument for leaving HZ at 1000 until some of
> these userspace bugs are fixed.

WTF? HZ=1000 eats energy like crazy. artsd eats energy like crazy. And
you advocate breaking kernel because artsd is broken?!
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
