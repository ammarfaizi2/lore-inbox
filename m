Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265864AbSKBCiW>; Fri, 1 Nov 2002 21:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265865AbSKBCiW>; Fri, 1 Nov 2002 21:38:22 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:15942 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S265864AbSKBCiV>; Fri, 1 Nov 2002 21:38:21 -0500
Message-ID: <3DC33BF8.272FD554@cinet.co.jp>
Date: Sat, 02 Nov 2002 11:44:08 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.44-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET 22/25] add support for PC-9800 architecture (sound alsa)
References: <20021026115417.A1424@precia.cinet.co.jp>
		<s5hu1j630qh.wl@alsa2.suse.de>
		<s5hsmyp36c4.wl@alsa2.suse.de>
		<3DBEC8BA.F2043BEF@cinet.co.jp>
		<s5hhef3byq1.wl@alsa2.suse.de>
		<20021101220218.A12315@precia.cinet.co.jp> <s5h7kfxs8ue.wl@alsa2.suse.de>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> 
> At Fri, 1 Nov 2002 22:02:18 +0900,
> Osamu Tomita wrote:
> > Now, PCM OPL3 and MPU401 all works fine.
> > Would you please add option "pc98ii" into snd-mpu401?
> > This is for Box that has MPU-PC98II only, with no other sound card.
> 
> well, then i misunderstood the hardware configuration on PC98.
> 
> doesn't MPU-PC98II need any specific hardware init code like in
> pc98_mpu401_init()?
MPU-PC98II doesn't need those init codes. Apologize for not enough
explanations.
On-board sound and sound cards made by NEC need those init codes.
Perhaps, for backward compatibility, PC-9800's BIOS masks newer
 features like WSS PCM, OPL3 FM synth and MPU-401 compatible IF.
After cold booting, they works as oldest sound card of NEC (PC-
9801-26). So I added some init codes to enable those features.
Most sound cards made by third parties (MPU-98, Sound blaster16
for PC9800...etc) don't need these init codes.

> 
> if yes, then we should create another module for PC98II rather than
> including a magical init code into a generic mpu401 module.
Init code for MPU-401 detects wheter NEC or not. If MPU-401 is
 not NEC's, skip magical initialization. So I think it's beter,
 your patch and adding option to mpu401.c

Thanks,
Osamu
