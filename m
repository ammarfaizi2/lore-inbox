Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311548AbSCTEHr>; Tue, 19 Mar 2002 23:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311532AbSCTEF7>; Tue, 19 Mar 2002 23:05:59 -0500
Received: from 203-109-249-30.ihug.net ([203.109.249.30]:44045 "EHLO
	boags.getsystems.com") by vger.kernel.org with ESMTP
	id <S311536AbSCTEFJ>; Tue, 19 Mar 2002 23:05:09 -0500
Date: Wed, 20 Mar 2002 15:05:03 +1100
From: Zenaan Harkness <zen@getsystems.com>
To: alsa-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Playback stutters
Message-ID: <20020320150503.A31328@getsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting the same with stock 2.4.18, DELL Inspiron laptop (Maestro
3i), my test is:

copy a cd image file from one partition to another, while trying to play
an mp3 using mpg123.

The mp3 skips all over the place.

I haven't applied any alsa patches yet - just been trying to set up this
laptop since I got it at work a week ago. At first I thought it was the
loop driver - I'd been loopback mounting my cd image, but that's not the
case.

I've tried:
 - low latency patch against 2.4.18
 - preempt + lockbreak patches against 2.4.18
 - preempt patch against 2.4.19-pre3-ac3 (lockbreak doesn't apply)

all have same problem. Since I've only recently tried setting up this
laptop, I don't know whether or not an earlier kernel works or not. Does
anyone know the earliest kernel that works for them without skipping, when
copying a large file, etc?

thanks
zen


---
I am also having this problem with both my ensoniq es1371 and my
audiophile 2496 with kernel 2.4.18 and alsa 0.9beta12.  It seems
to be way worse in mplayer and also when playing tribes2 where it
just constanly shutters.    I have an es1371 at work where I installed
the same version of alsa but there it's working fine with the game,
the difference is that I'm running kernel 2.4.8 so I'm wondering if
something broke in kernel 2.4.18 that causes this?

I would really like to be able to get this running stable at home.
My machine config at work and home is almost identical in both
hardware and software except for the kernel version.

Each soundcard have their own IRQ so I'm pretty sure the hardware
I have at home is ok.  With OSS/free and OSS/commercial the sound is fine
so it's something between alsa and kernel 2.4.18.

When I was listening to music in xmms, if I move windows around or
just click buttons in netcape for example it seems to shutters everytime
I do that.

Anybody else seeing this?

> Hey,
>
> audio playback stutters on my system. All playback programms I have tested
> have this problem (with and without artsd). I use alsa driver 0.9.0beta12.
> The soundcard is a no-name ALS4000 soundcard. My system: Linux 2.4.18,
> Debian testing, Dual Athlon, Tyan S2460. I have read that often IRQ
> problems cause those kind of problems, but I already tried to disable as
> much as possible hardware to free up interrups. I also changed the order of
> the PCI cards and I tried it with and without MP Interrupts.
> The playback stutters if e.g. I drag around windows or a programm starts
> (even if the load is very low). It doesn't stutter if I do heavy
> calcualtion (like running kfract multiple times) and the load is above 4.
> What else should I try to narrow down the problem?
>
> regards,
> Roland Schulz


