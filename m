Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263345AbUAIRSm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 12:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbUAIRRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 12:17:24 -0500
Received: from 204.Red-213-96-224.pooles.rima-tde.net ([213.96.224.204]:60946
	"EHLO betawl.net") by vger.kernel.org with ESMTP id S263221AbUAIRRS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 12:17:18 -0500
Date: Fri, 9 Jan 2004 18:17:15 +0100
From: Santiago Garcia Mantinan <manty@manty.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ALSA in 2.6 failing to find the OPL chip of the sb cards
Message-ID: <20040109171715.GA933@man.manty.net>
References: <20040107212916.GA978@man.manty.net> <s5hy8sixsor.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hy8sixsor.wl@alsa2.suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> compile with CONFIG_SND_DEBUG and CONFIG_SND_VERBOSE_PRINTK.
> if it's in snd_opl3_detect(), "OPL2/3 chip not detected at ..."
> message should appear (together with other message in
> snd_opl3_detect()).

I have tested now with 2.6.1 with vanilla driver (0.9.7) and also with 1.0.1
using the patch that Jaroslav posted yesterday available at
ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2004-01-08.patch.gz
and got the same result as before, these are the messages for 1.0.1:

pnp: Device 00:01.00 activated.
ALSA sound/isa/sb/sb16.c:313: pnp SB16: port=0x220, mpu port=0x330, fm port=0x388
ALSA sound/isa/sb/sb16.c:315: pnp SB16: dma1=1, dma2=5, irq=10
ALSA sound/isa/sb/sb_common.c:133: SB [0x220]: DSP chip found, version = 4.13
ALSA sound/drivers/opl3/opl3_lib.c:133: OPL3: stat1 = 0xff
ALSA sound/drivers/opl3/opl3_lib.c:444: OPL2/3 chip not detected at 0x388/0x38a
ALSA sound/isa/sb/sb16.c:489: sb16: no OPL device at 0x388-0x38a

Hope it helps.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
