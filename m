Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277806AbRJLTHw>; Fri, 12 Oct 2001 15:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277807AbRJLTHn>; Fri, 12 Oct 2001 15:07:43 -0400
Received: from zeus.kernel.org ([204.152.189.113]:39587 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S277806AbRJLTHa>;
	Fri, 12 Oct 2001 15:07:30 -0400
Date: Fri, 12 Oct 2001 20:06:41 +0200 (CEST)
From: Rui Sousa <rui.p.m.sousa@clix.pt>
X-X-Sender: <rsousa@sophia-sousar2.nice.mindspeed.com>
To: "Udo A. Steinberg" <reality@delusion.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        <emu10k1-devel@opensource.creative.com>
Subject: Re: Linux 2.4.12-ac1
In-Reply-To: <3BC6F876.9AC2C102@delusion.de>
Message-ID: <Pine.LNX.4.33.0110122000500.3012-100000@sophia-sousar2.nice.mindspeed.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2001, Udo A. Steinberg wrote:

The PCM mixer channel is now controlled by dsp microcode, but by default
this is working when you load the driver.

What probably happened is that you loaded the bass/treble patches with
and old version of the emu-dspmgr tool and this messed up the PCM mixer
channel code.

Two things to try:
1. Use the driver before loading any dsp microcode.
2. Get the latest user space tools 0.9.2 from
   <http://opensource.creative.com/dist.html>

Rui Sousa

> Alan Cox wrote:
> >
> > 2.4.12-ac1
> > 2.4.10-ac12
> > o       EMU10K driver update                            (Rui Sousa)
>
> It seems that the new EMU10K driver no longer has a PCM mixer channel.
>
> Creative EMU10K1 PCI Audio Driver, version 0.16, 15:28:05 Oct 12 2001
> PCI: Enabling device 00:0a.0 (0004 -> 0005)
> PCI: Assigned IRQ 5 for device 00:0a.0
> emu10k1: EMU10K1 rev 8 model 0x8027 found, IO at 0xa400-0xa41f, IRQ 5
> ac97_codec: AC97  codec, id: 0x5452:0x4123 (TriTech TR?????)
>
> Per default I have the following mixer channels:
> volume, speaker, line, microphone, cd, igain, line1, phonein, phoneout,
> video.
>
> Additionally I have added two mixer channels via emu-dspmgr userspace
> tools: bass, treble
>
> Does the new driver require userspace configuration for the PCM mixer
> or has it just vanished mysteriously?
>
> Regards,
> -Udo.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

