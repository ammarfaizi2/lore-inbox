Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265740AbSKAU0S>; Fri, 1 Nov 2002 15:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265741AbSKAU0R>; Fri, 1 Nov 2002 15:26:17 -0500
Received: from 24-205-160-225.riv-eres.charterpipeline.net ([24.205.160.225]:22269
	"EHLO kubus.grambling.net") by vger.kernel.org with ESMTP
	id <S265740AbSKAUZf>; Fri, 1 Nov 2002 15:25:35 -0500
Subject: IRQ/BIOS/PCMCIA hangs HP Pavillion ZE4101 (ATI/ALI chipset)
From: Jacek Pliszka <pliszka@interneo.pl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Nov 2002 12:31:49 -0800
Message-Id: <1036182709.19598.39.camel@kubus.grambling.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I wonder if somebody could help me with that.

I got HP Pavillion ZE4101 with ATI U1 / ALI 1535+ chipset
and CardBus controller O2Micro 6912 (according to book)
or 6972 (according to lspci).

The machine locks up solid durin i82365.o module insertion with message:
i82365.c 1.352 2002/06/29 06:23:09 (David Hinds)
Intel ISA/OCU/CardBus PCIC probe:
PCI: Found IRQ 11 for device 00:0a.0
IRQ routing conflict for 00:0a.0, have irq 5, want irq 11
 02Micro 0Z6912 rev 00 PCI-to_Cardbus at slot 00:0a, mem 0x80000000
   host optos [0]: [pci/way] [pci irq 5] [lat 32/32] [bus 2/5]

At line:
cb_writel(s, CB_SOCKET_FORCE, CB_SE_CSTSCHG);  # in i82365.c

I read hundreds of messages on pcmcia-cs list and I did some
experimentation described here:
http://sourceforge.net/forum/forum.php?thread_id=757551&forum_id=7049
and here:
http://forums.itrc.hp.com/cm/QuestionAnswer/1,,0xa15ec1c4ceddd61190050090279cd0f9,00.html

Finally I got reply from David Hinds telling me that this
is a BIOS issue and I should e-mail HP (what I did) and
post here.

I tried debugging but the device numbers shown by lspci are
different from ones which I printk in pci-irq.c
Also IRQs given are different than in Windows.

Could someobody help me with that?

BR,

Jacek

