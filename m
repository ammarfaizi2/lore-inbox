Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263080AbRFMKlW>; Wed, 13 Jun 2001 06:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263092AbRFMKlM>; Wed, 13 Jun 2001 06:41:12 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:2564 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S263080AbRFMKk4>; Wed, 13 Jun 2001 06:40:56 -0400
To: kernel@Expansa.sns.it, linux-kernel@vger.kernel.org
Message-Id: <20010613104051.247C778599@mail.clouddancer.com>
Date: Wed, 13 Jun 2001 03:40:51 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colonel <klink@clouddancer.com>
To: kernel@Expansa.sns.it
CC: linux-kernel@vger.kernel.org
In-reply-to: <Pine.LNX.4.33.0106131130200.22415-100000@Expansa.sns.it>
	(message from Luigi Genoni on Wed, 13 Jun 2001 11:32:35 +0200 (CEST))
Subject: Re: your mail
Reply-to: klink@clouddancer.com
In-Reply-To:  <Pine.LNX.4.33.0106131130200.22415-100000@Expansa.sns.it>

   Date: Wed, 13 Jun 2001 11:32:35 +0200 (CEST)
   From: Luigi Genoni <kernel@Expansa.sns.it>
   Cc: <linux-kernel@vger.kernel.org>
   Content-Type: TEXT/PLAIN; charset=US-ASCII

   I have the sound blaster 16 card on one of my athlon (on PIII i have
   es1731), that has one isa slot on its MB.
   It works well, but i do not use isapnp nor any pnp support is enabled
   inside of the kernel.
   running 2.4.5/2.4.6-pre2

   Luigi


Yes, dropping any PNP support does resolve the problem.  For my
installation, I don't need PNP support, so it's OK.  The bug is in the
communication between the 2 modules.




   On Tue, 12 Jun 2001, Colonel wrote:

   > From: Colonel <klink@clouddancer.com>
   > To: linux-kernel@vger.kernel.org
   > Subject: ISA Soundblaster problem
   > Reply-to: klink@clouddancer.com
   >
   >
   > The Maintainers list does not contain anyone for 2.4 Soundblaster
   > modules, so perhaps some one on the mailing list is aware of a
   > solution.  My ISA Soundblaster 16waveffects worked fine in kernel 2.2
   > with XMMS.  But I have never been successful in a varity of 2.4
   > kernels, the latest being 2.4.5-ac12.  This is what I know:
   >
   > [DMESG]
   > isapnp: Scanning for PnP cards...
   > isapnp: Calling quirk for 01:00
   > isapnp: SB audio device quirk - increasing port range
   > isapnp: Card 'Creative SB16 PnP'
   > isapnp: 1 Plug & Play card detected total
   >
   > }modprobe sb
   > /lib/modules/2.4.5-ac12/kernel/drivers/sound/sb.o: init_module: No such device
   > /lib/modules/2.4.5-ac12/kernel/drivers/sound/sb.o: Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
   > /lib/modules/2.4.5-ac12/kernel/drivers/sound/sb.o: insmod /lib/modules/2.4.5-ac12/kernel/drivers/sound/sb.o failed
   > /lib/modules/2.4.5-ac12/kernel/drivers/sound/sb.o: insmod sb failed
   >
   >
   > [/etc/modules.conf]
   > options sb io=0x220 irq=5 dma=1 dma16=5 mpu_io=0x330
   >
   >
   > [DMESG}
   > Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
   > sb: No ISAPnP cards found, trying standard ones...
   > sb: dsp reset failed.
   >
   >
   > So it seems that PnP finds the card, but the connections (or even the
   > forced values) to the sb module fail.  Back when this was a single
   > processor machine, but still running 2.4 kernel, a windoze
   > installation found the SB at the listed interface parameters.
   >
   >
   > Anyone have a solution?
   >
   > Same problem without modules.conf settings, valid version of mod
   > utilities, a web search did not help,...
