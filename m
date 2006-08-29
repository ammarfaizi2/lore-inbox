Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWH2I5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWH2I5N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 04:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWH2I5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 04:57:13 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:14500 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750844AbWH2I5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 04:57:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YsoO/GKMlqS1LWCCL342tSxEfI/Nly27oCODMwiQGWM41onj+cVeQiHzChC1oicjv2jc4eqD/GUlGEmq6YA/WX5s2kxPuegMBq/AMRnXQxCXJPWaJ62bR15RpwTb2876Rr8qsJd9fFU8B9hu6/xvRJI2YlubXIpXv14+8IQwE1k=
Message-ID: <a44ae5cd0608290157s346e8371j1ee73baf14f7ba62@mail.gmail.com>
Date: Tue, 29 Aug 2006 01:57:11 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Takashi Iwai" <tiwai@suse.de>
Subject: Re: 2.6.18-rc4-mm3 -- intel8x0 audio busted
Cc: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <s5hlkp87ks2.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0608262355q51279259lc6480f229e520fd5@mail.gmail.com>
	 <s5hac5o7v47.wl%tiwai@suse.de> <20060828114939.90341479.akpm@osdl.org>
	 <s5hlkp87ks2.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/06, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 28 Aug 2006 11:49:39 -0700,
> Andrew Morton wrote:
> >
> > On Mon, 28 Aug 2006 17:11:52 +0200
> > Takashi Iwai <tiwai@suse.de> wrote:
> >
> > > At Sat, 26 Aug 2006 23:55:32 -0700,
> > > Miles Lane wrote:
> > > >
> > > > I haven't had working audio in 2.6.18-rc4-mm series (1,2,3).
> > > > I haven't been able to track down the cause yet.  The modules
> > > > all load, and there seems to be the expected enties in /proc,
> > > > but my sound preferences panel shows no available audio card.
> > > (snip)
> > > > Aug 26 23:16:56 localhost kernel: warning: process `alsactl' used the
> > > > obsolete sysctl system call
> > > > Aug 26 23:16:56 localhost kernel: warning: process `ls' used the
> > > > obsolete sysctl system call
> > > > Aug 26 23:16:56 localhost kernel: warning: process `alsactl' used the
> > > > obsolete sysctl system call
> > > > Aug 26 23:16:56 localhost kernel: warning: process `amixer' used the
> > > > obsolete sysctl system call
> > > > Aug 26 23:16:56 localhost kernel: warning: process `amixer' used the
> > > > obsolete sysctl system call
> > >
> > > Are these messages relavant?  Even "ls" fails there...
> > >
> >
> > No, they're just a little warning we put in there to find out how
> > removeable sys_sysctl() is.  (Answer: not very.  I'll drop that patch).
> >
> > It isn't relevant to this problem.
>
> OK.
>
> Then it must be something in the driver communication.
> Miles, do you have proper /dev/snd/* entries?

Hello,

I have no /dev/snd directory.
/dev/sndstat contains:

Sound Driver:3.8.1a-980706 (ALSA v1.0.12rc1 emulation code)
Kernel: Linux Dumbleedor 2.6.18-rc4-mm3 #2 Tue Aug 29 01:26:36 PDT 2006 i686
Config options: 0

Installed drivers:
Type 10: ALSA emulation

Card config:
Intel 82801DB-ICH4 with unknown codec at 0xe0100c00, irq 17

Audio devices:
0: Intel 82801DB-ICH4 (DUPLEX)

Synth devices: NOT ENABLED IN CONFIG

Midi devices: NOT ENABLED IN CONFIG

Timers:
7: system timer

Mixers:
0: Conexant id 30

Also, "cat /proc/asound/pcm" gives:

00-04: Intel ICH - IEC958 : Intel 82801DB-ICH4 - IEC958 : playback 1
00-03: Intel ICH - ADC2 : Intel 82801DB-ICH4 - ADC2 : capture 1
00-02: Intel ICH - MIC2 ADC : Intel 82801DB-ICH4 - MIC2 ADC : capture 1
00-01: Intel ICH - MIC ADC : Intel 82801DB-ICH4 - MIC ADC : capture 1
00-00: Intel ICH : Intel 82801DB-ICH4 : playback 1 : capture 1
