Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266256AbTAJSvZ>; Fri, 10 Jan 2003 13:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbTAJSuK>; Fri, 10 Jan 2003 13:50:10 -0500
Received: from [193.158.237.250] ([193.158.237.250]:905 "EHLO
	mail.intergenia.de") by vger.kernel.org with ESMTP
	id <S265885AbTAJS2a>; Fri, 10 Jan 2003 13:28:30 -0500
Date: Fri, 10 Jan 2003 19:37:03 +0100
Message-Id: <200301101837.h0AIb3V05186@mail.intergenia.de>
To: <200301100250.h0A2olE20795@devserv.devel.redhat.com>
From: Peter <peter@cogweb.net>
Subject: Re: 2.4.19 -- ac97_codec failure ALi 5451 [rescued]
CC: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >         Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, 
> > 		version 0.14.9d, 00:57:19 Jan  9 2003
> >         PCI: Enabling device 00:06.0 (0000 -> 0003)
> >         PCI: Assigned IRQ 10 for device 00:06.0
> >         trident: ALi Audio Accelerator found at IO 0x1000, IRQ 10
> >         ac97_codec: AC97 Audio codec, id: 0x4144:0x5372 (Unknown)
> 
> So far so good.
> 
> >         ali: AC97 CODEC read timed out.
> >         last message repeated 127 times
> >         ali: AC97 CODEC write timed out.
> >         ac97_codec: AC97  codec, id: 0x0000:0x0000 (Unknown)
> 
> Something lost the codec. Could be power management - was the laptop
> suspended before it went funny ?

No, this happens very reliably every time on a large number of occasions, whether 
trident is compiled in or as a module, or with ALSA's snd-ali5451. Dozens of read 
and write timeouts. In fact when the codec loads, it tends to freeze the whole 
system for a short time (from a few seconds to a minute).

That said, it's close to working. There have been times when I've been able to get 
sound -- typically by doing a manual insmod ac97_codec and trident. I had hoped the 
ALSA module would work more reliably, but it seems the problem is with the ac97 
codec.

Is the driver for the ac97 codec the same for OSS and ALSA? They appear to fail in 
very similar ways.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

