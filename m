Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264143AbRFMBzw>; Tue, 12 Jun 2001 21:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264169AbRFMBzc>; Tue, 12 Jun 2001 21:55:32 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:42501 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S264143AbRFMBzW>; Tue, 12 Jun 2001 21:55:22 -0400
To: linux-kernel@vger.kernel.org
Message-Id: <20010613015519.151BF78599@mail.clouddancer.com>
Date: Tue, 12 Jun 2001 18:55:19 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colonel <klink@clouddancer.com>
To: linux-kernel@vger.kernel.org
Subject: ISA Soundblaster problem
Reply-to: klink@clouddancer.com


The Maintainers list does not contain anyone for 2.4 Soundblaster
modules, so perhaps some one on the mailing list is aware of a
solution.  My ISA Soundblaster 16waveffects worked fine in kernel 2.2
with XMMS.  But I have never been successful in a varity of 2.4
kernels, the latest being 2.4.5-ac12.  This is what I know:

[DMESG]
isapnp: Scanning for PnP cards...
isapnp: Calling quirk for 01:00
isapnp: SB audio device quirk - increasing port range
isapnp: Card 'Creative SB16 PnP'
isapnp: 1 Plug & Play card detected total

}modprobe sb  
/lib/modules/2.4.5-ac12/kernel/drivers/sound/sb.o: init_module: No such device
/lib/modules/2.4.5-ac12/kernel/drivers/sound/sb.o: Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
/lib/modules/2.4.5-ac12/kernel/drivers/sound/sb.o: insmod /lib/modules/2.4.5-ac12/kernel/drivers/sound/sb.o failed
/lib/modules/2.4.5-ac12/kernel/drivers/sound/sb.o: insmod sb failed


[/etc/modules.conf]
options sb io=0x220 irq=5 dma=1 dma16=5 mpu_io=0x330


[DMESG}
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: No ISAPnP cards found, trying standard ones...
sb: dsp reset failed.


So it seems that PnP finds the card, but the connections (or even the
forced values) to the sb module fail.  Back when this was a single
processor machine, but still running 2.4 kernel, a windoze
installation found the SB at the listed interface parameters.


Anyone have a solution?

Same problem without modules.conf settings, valid version of mod
utilities, a web search did not help,...



TIA


please CC:  klink@clouddancer.com, not currently on the mailing list.
