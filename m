Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268108AbTAJC1U>; Thu, 9 Jan 2003 21:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268109AbTAJC1T>; Thu, 9 Jan 2003 21:27:19 -0500
Received: from greenie.frogspace.net ([64.6.248.2]:1997 "EHLO
	greenie.frogspace.net") by vger.kernel.org with ESMTP
	id <S268108AbTAJC1T>; Thu, 9 Jan 2003 21:27:19 -0500
Date: Thu, 9 Jan 2003 18:35:53 -0800 (PST)
From: Peter <cogwepeter@greenie.frogspace.net>
To: linux-kernel@vger.kernel.org
cc: Alan Cox <alan@redhat.com>
Subject: 2.4.19 -- ac97_codec failure ALi 5451
In-Reply-To: <Pine.LNX.4.44.0209111934280.11402-100000@greenie.frogspace.net>
Message-ID: <Pine.LNX.4.44.0301090206290.30969-100000@greenie.frogspace.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sound fails on 2.4.19 with ALi 5451 built-in audio:

        Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, 
		version 0.14.9d, 00:57:19 Jan  9 2003
        PCI: Enabling device 00:06.0 (0000 -> 0003)
        PCI: Assigned IRQ 10 for device 00:06.0
        trident: ALi Audio Accelerator found at IO 0x1000, IRQ 10
        ac97_codec: AC97 Audio codec, id: 0x4144:0x5372 (Unknown)
        ali: AC97 CODEC read timed out.
        last message repeated 127 times
        ali: AC97 CODEC write timed out.
        ac97_codec: AC97  codec, id: 0x0000:0x0000 (Unknown)

The trident driver was compiled in during this run. lspci --

00:06.0 Multimedia audio controller: Acer Laboratories Inc. [ALi] M5451 
PCI AC-Link Controller Audio Device (rev 02)

I've also tried Alsa, and the snd-ali5451 module loads under lengthy
protests from

alsa-kernel/pci/ali5451/ali5451.c:389 ali_codec_ready: codec not ready

The related modules also load and everything looks fine.

No sound in either case, trident or snd-ali5451. 

This is a matrix vpr 200A5 laptop running Debian's kernel 2.4.19-5.

I've seen other people have had similar problems; is this a problem with 
recent AC-97 codec revisions?

Cheers,
Peter


