Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130047AbRBVPhM>; Thu, 22 Feb 2001 10:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130205AbRBVPhC>; Thu, 22 Feb 2001 10:37:02 -0500
Received: from hermes.hrz.uni-giessen.de ([134.176.2.15]:8356 "EHLO
	hermes.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id <S130054AbRBVPgy>; Thu, 22 Feb 2001 10:36:54 -0500
Date: Thu, 22 Feb 2001 16:36:41 +0100 (CET)
From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
X-X-Sender: <gc1007@fb07-calculator.math.uni-giessen.de>
To: <linux-kernel@vger.kernel.org>
Subject: via82cxxx_audio playing too fast AND Re: PATCH: Via audio rate lock,for testing
In-Reply-To: <Pine.GSO.4.10.10102221610560.11223-100000@irz601.inf.tu-dresden.de>
Message-Id: <Pine.LNX.4.31.0102221616100.1169-100000@fb07-calculator.math.uni-giessen.de>
Organization: University of Giessen * Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2001, Jeff Garzik wrote:

> Can you guys test this patch, and let me know if it fixes Via audio
> problems on your kernel?
>
> It should apply against 2.4.1 or 2.4.1-acXX kernels.

high!

I tried to apply this patch to clean 2.4.1 and to 2.4.1-ac20, which has
the same via82cxxx_audio.c as 2.4.2

in both cases the patch rejected HUNKS 4 and 6 (4 is a comment anyway)
HUNK 6 I didn't find by hand also...

This didn't help on my Problem...

Here is my Problem:

The sound is playing (much) too fast.
sometimes using xmms1.2.4 locks up the whole machine.

Here is my Configuration:
Biostar M6VCG motherboard with on-board ac97
via82cxxx_audio recognizes the chip as follows:
 kernel: Via 686a audio driver 1.1.14a
 kernel: PCI: Found IRQ 10 for device 00:07.5
 kernel: PCI: The same IRQ used for device 00:0a.0
 kernel: ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
 kernel: via82cxxx: board #1 at 0xAC00, IRQ 10
 kernel: via82cxxx: Codec rate locked at 48Khz

here a part of /proc/pci (the both devices using irq10):

PCI devices found:
  Bus  0, device   7, function  5:
    Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 32).
      IRQ 10.
      I/O at 0xac00 [0xacff].
      I/O at 0xb000 [0xb003].
      I/O at 0xb400 [0xb403].
  Bus  0, device  10, function  0:
    Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 8).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xdb100000 [0xdb100fff].
      I/O at 0xc000 [0xc03f].
      Non-prefetchable 32 bit memory at 0xdb000000 [0xdb0fffff].

If you need mode information, I can send it on request.

Thanks in advance

c ya
        Sergei

--------------------------------------------------------------------
         eMail:       Sergei.Haller@math.uni-giessen.de
      WWW-page:     http://www.hrz.uni-giessen.de/~gc1007/
--------------------------------------------------------------------
Be careful of reading health books, you might die of a misprint.
                -- Mark Twain


