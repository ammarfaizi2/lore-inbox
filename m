Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTJHXpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 19:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTJHXpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 19:45:23 -0400
Received: from smtp11.eresmas.com ([62.81.235.111]:43655 "EHLO
	smtp11.eresmas.com") by vger.kernel.org with ESMTP id S261821AbTJHXpE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 19:45:04 -0400
Message-ID: <3F84A15F.6080105@wanadoo.es>
Date: Thu, 09 Oct 2003 01:44:31 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.22-bk30 and C trigraphs bugs
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

There are some mistakes with C trigraphs:

arch/m68k/atari/stram.c:                        PRINT_PROC( "??)\n" );
arch/sparc/kernel/traps.c:              die_if_kernel("Penguin instruction from Penguin mode??!?!", regs);
drivers/atm/idt77252.c:         printk("%s: PCI_COMMAND: %04x (???)\n",
drivers/acorn/scsi/acornscsi.c:    "??-out",                    /* 1C */
drivers/acorn/scsi/acornscsi.c:    "??-in",                     /* 1D */
drivers/block/acsi.c:   { 0x00, "No error (??)" },
drivers/block/acsi.c:   { 0x00, "No error (??)" },
drivers/media/video/saa7110.c:          DEBUG(printk(KERN_INFO "unknown saa7110_command??(%d)\n",cmd));
drivers/mtd/maps/sun_uflash.c:          name:           "SUNW,???-????",
drivers/scsi/ppa.c:     printk("ppa: parity error (???)\n");
drivers/scsi/ppa.c:     printk("ppa: bad interrupt (???)\n");
drivers/scsi/imm.c:     printk("imm: parity error (???)\n");
drivers/scsi/imm.c:     printk("imm: bad interrupt (???)\n");
net/rose/af_rose.c:                     callsign = "??????-?";

fixes are trivial.

Is 2.6.0-pre free of them  :-?

-thanks-

