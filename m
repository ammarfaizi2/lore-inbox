Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271757AbRHURd7>; Tue, 21 Aug 2001 13:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271758AbRHURdt>; Tue, 21 Aug 2001 13:33:49 -0400
Received: from hal.astr.lu.lv ([195.13.134.67]:14340 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S271757AbRHURdp>;
	Tue, 21 Aug 2001 13:33:45 -0400
Message-Id: <200108211733.f7LHXoA00491@hal.astr.lu.lv>
Content-Type: text/plain; charset=US-ASCII
From: Andris Pavenis <pavenis@latnet.lv>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: i810 audio doesn't work with 2.4.9
Date: Tue, 21 Aug 2001 20:33:50 +0300
X-Mailer: KMail [version 1.3]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15ZC3v-0007tI-00@the-village.bc.nu>
In-Reply-To: <E15ZC3v-0007tI-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 August 2001 16:59, Alan Cox wrote:
> > i810 audio didn't work for me with kernel 2.4.9 (artsd from KDE goes into
> > infinite loop, no sound).
> >
> > Reverting to kernel 2.4.7 or replacing in 2.4.9
> > drivers/sound/ac97_codec.c, drivers/sound/i810_audio.c,
> > include/linux/ac97_codec.h from 2.4.8-ac8 fixed the problem for me
>
> Thats good to know - the 2.4.8-ac8 one is scheduled to go to Linus

Sorry, my fault:

seems that i810_audio.c  from 2.4.7 and 2.4.8 works, but both from 2.4.9 and
2.4.8-ac8 does not ("suceeded" not to copy right version of this file when
testing previous time, so had one from 2.4.7 twice)

Andris

---------- corresponding line from /proc/pci ------------------------
  Bus  0, device  31, function  5:
    Multimedia audio controller: Intel Corporation 82801AA AC'97 Audio (rev 2).
      IRQ 10.
      I/O at 0xe000 [0xe0ff].
      I/O at 0xe100 [0xe13f].

---------  corresponding lines from kernel messages
i810: Intel ICH 82801AA found at IO 0xe100 and 0xe000, IRQ 10
ac97_codec: AC97 Audio codec, id: 0x4144:0x5348 (Analog Devices AD1881A)

