Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266342AbUAHWmo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 17:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266349AbUAHWmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 17:42:44 -0500
Received: from 204.Red-213-96-224.pooles.rima-tde.net ([213.96.224.204]:9232
	"EHLO betawl.net") by vger.kernel.org with ESMTP id S266342AbUAHWmm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 17:42:42 -0500
Date: Thu, 8 Jan 2004 23:42:40 +0100
From: Santiago Garcia Mantinan <manty@manty.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ALSA in 2.6 failing to find the OPL chip of the sb cards
Message-ID: <20040108224239.GA775@man.manty.net>
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
> if not, it must be in snd_device_new(), and quite mysterious...

I have compiled 2.6.1rc3 this way, here is the result when loading the
kernel's alsa modules for sb16 (0.9.7):

pnp: Device 00:01.00 activated.
ALSA sound/isa/sb/sb16.c:313: pnp SB16: port=0x220, mpu port=0x330, fm port=0x388
ALSA sound/isa/sb/sb16.c:315: pnp SB16: dma1=1, dma2=5, irq=10
ALSA sound/isa/sb/sb_common.c:133: SB [0x220]: DSP chip found, version = 4.13
ALSA sound/drivers/opl3/opl3_lib.c:133: OPL3: stat1 = 0xff
ALSA sound/drivers/opl3/opl3_lib.c:444: OPL2/3 chip not detected at 0x388/0x38a
ALSA sound/isa/sb/sb16.c:484: sb16: no OPL device at 0x388-0x38a

Hope this helps a bit.

Don't hesitate to ask for anything else you may need.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
