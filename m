Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264363AbRFLMo1>; Tue, 12 Jun 2001 08:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264366AbRFLMoR>; Tue, 12 Jun 2001 08:44:17 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:42065 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S264363AbRFLMoK>; Tue, 12 Jun 2001 08:44:10 -0400
Message-ID: <001901c0f33d$1a4c8170$3303a8c0@einstein>
From: =?iso-8859-1?Q?Christian_Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: "Rachel Greenham" <rachel@linuxgrrls.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3B2606CF.10003@linuxgrrls.org>
Subject: Re: VIA KT133A crash *post* 2.4.3-ac6
Date: Tue, 12 Jun 2001 14:42:06 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With DMA (UDMA Mode 5) enabled, my machine crashes on kernel versions
> from 2.4.3-ac7 onwards up to 2.4.5 right up to 2.4.5-ac13. 2.4.3 vanilla
> and 2.4.3-ac6 are completely stable. -ac7 of course is when a load of
> VIA fixes were done. :-}

I encountered the same problem after 2.4.3-ac6.

> CPU: Athlon 1.33 GHz with 266MHz FSB
> Mobo: Asus A7V133 with 266MHz FSB, UltraDMA100 (PDC20265 according to

So you put your IBM drive on the promise, right?
Removing the hard disc from the promise controller and attaching it on the
VIA-Controller solved my problems. The system is now rock solid. If you do
so, take care that your root partition moves from hde to hda. Prepare a boot
disk and pass a parameter like root=/dev/hda to the kernel. After a
successful boot, modify fstab and lilo.conf and run lilo.

> With DMA disabled, *all* kernels are completely stable.

same for me.


> With DMA (any setting, but UDMA mode 5 preferred of course) enabled, on
> kernels 2.4.3-ac7 and onwards, random lockup on disk access within first
> few minutes of use - sometimes very quickly after boot, sometimes as
> much as ten minutes later given use. Running bonnie -s 1024 once or
> twice after boot generally excites it too. :-}. Lockup is pretty severe:
> machine goes completely unresponsive, Magic SysRq doesn't work. About
> the only thing that does still work is the flashing VGA cursor. :-)
> Please read the FAQ at  http://www.tux.org/lkml/

sounds absoluty identical to my problem with ASUS A7V133 I reported some
weeks ago.

