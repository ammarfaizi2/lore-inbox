Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131510AbRCXJUT>; Sat, 24 Mar 2001 04:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131513AbRCXJT7>; Sat, 24 Mar 2001 04:19:59 -0500
Received: from cpe.atm0-0-0-209183.boanxx5.customer.tele.dk ([62.242.151.103]:8796
	"HELO mail.hswn.dk") by vger.kernel.org with SMTP
	id <S131510AbRCXJTq>; Sat, 24 Mar 2001 04:19:46 -0500
To: linux-kernel@vger.kernel.org
Path: news.storner.dk!not-for-mail
From: henrik@storner.dk (Henrik Størner)
Newsgroups: linux.kernel
Subject: Re: athlon+2.2+pdc20267=hang?
Date: 24 Mar 2001 10:19:02 +0100
Organization: Linux Users Inc.
Message-ID: <99hoq6$q8$1@osiris.storner.dk>
In-Reply-To: <18520000.985334866@skittlebrau.trafford.dementia.org>
X-Newsreader: NN version 6.5.6 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In <18520000.985334866@skittlebrau.trafford.dementia.org> Derrick J Brashear <shadow@dementia.org> writes:

>Earlier today I swapped an Athlon (tbird) 850 and an Epox 8KTA3 in for the 
>dual Celeron I had, moving all the cards into the new system. One of these 
>was a Promise PDC20267 with 4 40gb disks attached. The machine would not 
>boot; I assumed it was the i686-smp kernel and installed a Redhat 
>7.0-provided i386 kernel. Several hours and a dozen or so boots later, it 
>looks like when the bios on the PDC20267 is installed, the system hangs 
>while booting at the point where it would probe C/H/S from the devices 
>attached to the PDC20267 (they've already been identified by that point)

I see the same thing with an ASUS A7V133 motherboard that has a
PDC20265 installed on the motherboard. If I disable the PDC BIOS, the
system boots normally - but trying to use any UDMA mode hangs.
Ordinary mdma2 mode works fine. 

So I suspect that the real culprit is the UDMA mode which the BIOS
probably enables - when I boot the the BIOS disabled, the device shows
up as running in pio mode.

All in all, I haven't had much success with the PDC controllers - 
both cases I have tried will hang the system when enabling UDMA
(and there is no common hardware involved).
-- 
Henrik Storner      | "ATA100 is another testimony to the fact that 
<henrik@storner.dk> |  pigs can be made to fly given sufficient thrust"
                    | 
                    |          Linux kernel hacker Alan Cox, on IDE drives
