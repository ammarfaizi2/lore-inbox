Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbSKSOGF>; Tue, 19 Nov 2002 09:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265506AbSKSOGF>; Tue, 19 Nov 2002 09:06:05 -0500
Received: from gate.perex.cz ([194.212.165.105]:9231 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S265470AbSKSOGC>;
	Tue, 19 Nov 2002 09:06:02 -0500
Date: Tue, 19 Nov 2002 15:10:41 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: CaT <cat@zip.com.au>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.48 and ALSA
In-Reply-To: <20021119133959.GA818@zip.com.au>
Message-ID: <Pine.LNX.4.33.0211191509540.503-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2002, CaT wrote:

> Is it supposed to work when compiled into the kernel? I have it compiled
> with OSS emulation and it worked as modules with 2.5.47 but not compiled
> in to 2.5.48 (trying to avoid the whole modules changes here :)
> 
> I get the sound device recognised but I hear no output and aumix is only
> reporting Vol, Synth, Line, Mic and CD. No PCM. :/
> 
> This is the relevant part of dmesg. I can't give it in full because the
> buffer overflows on bootup. :/
> 
> Advanced Linux Sound Architecture Driver Version 0.9.0rc5 (Sun Nov 10 19:48:18 2002 UTC).
> request_module[snd-card-0]: not ready
> request_module[snd-card-1]: not ready
> request_module[snd-card-2]: not ready
> request_module[snd-card-3]: not ready
> request_module[snd-card-4]: not ready
> request_module[snd-card-5]: not ready
> request_module[snd-card-6]: not ready
> request_module[snd-card-7]: not ready
> driver pci:Maestro3: registering
> kobject Maestro3: registering
> bus pci: add driver Maestro3
> PCI: Enabling device 00:0c.0 (0000 -> 0003)
> Yenta IRQ list 00b8, PCI irq10
> Socket status: 30000820
> Yenta IRQ list 00b8, PCI irq10
> Socket status: 30000006
> bound device '00:0c.0' to driver 'Maestro3'
> ALSA device list:
>   #0: Dummy 1
>   #1: ESS Maestro3 PCI at 0x1000, irq 11
> 
> And my .config:
> 
> #
> # Advanced Linux Sound Architecture
> #
> CONFIG_SND=y
> CONFIG_SND_SEQUENCER=y
> CONFIG_SND_SEQ_DUMMY=y
> CONFIG_SND_OSSEMUL=y
> CONFIG_SND_MIXER_OSS=y
> CONFIG_SND_PCM_OSS=y
> CONFIG_SND_SEQUENCER_OSS=y
> CONFIG_SND_RTCTIMER=y
> CONFIG_SND_VERBOSE_PRINTK=y
> # CONFIG_SND_DEBUG is not set
> 
> #
> # Generic devices
> #
> CONFIG_SND_DUMMY=y

Remove this dummy driver, it does nothing.

> CONFIG_SND_MAESTRO3=y

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

