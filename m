Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbUAIUO2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 15:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUAIUO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 15:14:28 -0500
Received: from 204.Red-213-96-224.pooles.rima-tde.net ([213.96.224.204]:17670
	"EHLO betawl.net") by vger.kernel.org with ESMTP id S264233AbUAIUO0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 15:14:26 -0500
Date: Fri, 9 Jan 2004 21:14:23 +0100
From: Santiago Garcia Mantinan <manty@manty.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ALSA in 2.6 failing to find the OPL chip of the sb cards
Message-ID: <20040109201423.GA1677@man.manty.net>
References: <20040107212916.GA978@man.manty.net> <s5hy8sixsor.wl@alsa2.suse.de> <20040109171715.GA933@man.manty.net> <s5hn08xgh06.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hn08xgh06.wl@alsa2.suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> then it fails in the reset sequence of opl chip, namely, 
> what happens if you replace the line 441
> 	opl3->command = &snd_opl2_command;
> with
> 	opl3->command = &snd_opl3_command;

Looks exactly the same thing to me:

pnp: Device 00:01.00 activated.
ALSA sound/isa/sb/sb16.c:313: pnp SB16: port=0x220, mpu port=0x330, fm port=0x388
ALSA sound/isa/sb/sb16.c:315: pnp SB16: dma1=1, dma2=5, irq=10
ALSA sound/isa/sb/sb_common.c:133: SB [0x220]: DSP chip found, version = 4.13
ALSA sound/drivers/opl3/opl3_lib.c:133: OPL3: stat1 = 0xff
ALSA sound/drivers/opl3/opl3_lib.c:444: OPL2/3 chip not detected at 0x388/0x38a
ALSA sound/isa/sb/sb16.c:484: sb16: no OPL device at 0x388-0x38a

I think I have already said that in 2.4 it works, and I have tested both
alsa in the kernel plus alsa sources downloaded from alsa-project, this last
one works in 2.4 but doesn't work in 2.6.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
