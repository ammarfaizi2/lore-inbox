Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264983AbTAJNHN>; Fri, 10 Jan 2003 08:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbTAJNHN>; Fri, 10 Jan 2003 08:07:13 -0500
Received: from [216.222.206.4] ([216.222.206.4]:23196 "EHLO
	webmail.frogspace.net") by vger.kernel.org with ESMTP
	id <S264983AbTAJNHL>; Fri, 10 Jan 2003 08:07:11 -0500
Message-ID: <1042204553.3e1ec789564b6@webmail.cogweb.net>
Date: Fri, 10 Jan 2003 05:15:53 -0800
From: Peter <peter@cogweb.net>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@redhat.com>
Subject: Re: 2.4.19 -- ac97_codec failure ALi 5451
References: <200301100250.h0A2olE20795@devserv.devel.redhat.com>
In-Reply-To: <200301100250.h0A2olE20795@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 128.97.184.97
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've downloaded the latest driver and am running 2.4.20 (yea!) -- the trident.c here 
is actually more recent than 2.5.55. It now loads fast and with no protest from 
ac97_codec, which has a new ID (ADS114). However, there's still not a peep (I try 
cat test.mp3 > /dev/dsp) -- and when KDE Control Center tries to restart the arts 
sound server, it alarmingly fails on "CPU overload" or just freezes the whole 
system. Is there anything I can do to get more information about what is not 
happening?

Cheers,
Peter

Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, version 0.14.10h, 
Enabling device 00:06.0 (0000 -> 0003)
PCI: Assigned IRQ 5 for device 00:06.0
trident: ALi Audio Accelerator found at IO 0x1000, IRQ 5
ac97_codec: AC97 Audio codec, id: ADS114(Unknown)
ac97_codec: AC97 Audio codec, id: ADS114(Unknown)
PCI: Found IRQ 5 for device 00:06.0
gameport0: Acer Laboratories Inc. [ALi] M5451 PCI AC-Link Controller Audio Device at 
pci00:06.0 speed 1924 kHz

Quoting Alan Cox <alan@redhat.com>:

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
> 
> Alan
> 


