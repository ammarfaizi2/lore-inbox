Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264480AbUASXml (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 18:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbUASXml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 18:42:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:3779 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264594AbUASXmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 18:42:17 -0500
Date: Mon, 19 Jan 2004 15:38:14 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Xose Vazquez Perez <xose@wanadoo.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-bk30 and C trigraphs bugs
Message-Id: <20040119153814.5ebc3a87.rddunlap@osdl.org>
In-Reply-To: <3F84A15F.6080105@wanadoo.es>
References: <3F84A15F.6080105@wanadoo.es>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Oct 2003 01:44:31 +0200 Xose Vazquez Perez <xose@wanadoo.es> wrote:

| hi,
| 
| There are some mistakes with C trigraphs:
| 
| arch/m68k/atari/stram.c:                        PRINT_PROC( "??)\n" );
| arch/sparc/kernel/traps.c:              die_if_kernel("Penguin instruction from Penguin mode??!?!", regs);
| drivers/atm/idt77252.c:         printk("%s: PCI_COMMAND: %04x (???)\n",
| drivers/acorn/scsi/acornscsi.c:    "??-out",                    /* 1C */
| drivers/acorn/scsi/acornscsi.c:    "??-in",                     /* 1D */
| drivers/block/acsi.c:   { 0x00, "No error (??)" },
| drivers/block/acsi.c:   { 0x00, "No error (??)" },
| drivers/media/video/saa7110.c:          DEBUG(printk(KERN_INFO "unknown saa7110_command??(%d)\n",cmd));
| drivers/mtd/maps/sun_uflash.c:          name:           "SUNW,???-????",
| drivers/scsi/ppa.c:     printk("ppa: parity error (???)\n");
| drivers/scsi/ppa.c:     printk("ppa: bad interrupt (???)\n");
| drivers/scsi/imm.c:     printk("imm: parity error (???)\n");
| drivers/scsi/imm.c:     printk("imm: bad interrupt (???)\n");
| net/rose/af_rose.c:                     callsign = "??????-?";
| 
| fixes are trivial.
| 
| Is 2.6.0-pre free of them  :-?

Of course not.  I grepped over 100 of them in 2.6.1.

Are they a problem?

--
~Randy
kernel-janitors project:  http://janitor.kernelnewbies.org/
