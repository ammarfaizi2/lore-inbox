Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265528AbUA0Q1h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 11:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265549AbUA0Q1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 11:27:36 -0500
Received: from smtp11.eresmas.com ([62.81.235.111]:13805 "EHLO
	smtp11.eresmas.com") by vger.kernel.org with ESMTP id S265528AbUA0Q1b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 11:27:31 -0500
Message-ID: <40169019.5040002@wanadoo.es>
Date: Tue, 27 Jan 2004 17:21:45 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; es-ES; rv:1.4.1) Gecko/20031114
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-bk30 and C trigraphs bugs
References: <3F84A15F.6080105@wanadoo.es> <20040119153814.5ebc3a87.rddunlap@osdl.org>
In-Reply-To: <20040119153814.5ebc3a87.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

> On Thu, 09 Oct 2003 01:44:31 +0200 Xose Vazquez Perez <xose@wanadoo.es> wrote:
> 
> | hi,
> | 
> | There are some mistakes with C trigraphs:
> | 
> | arch/m68k/atari/stram.c:                        PRINT_PROC( "??)\n" );
> | arch/sparc/kernel/traps.c:              die_if_kernel("Penguin instruction from Penguin mode??!?!", regs);
> | drivers/atm/idt77252.c:         printk("%s: PCI_COMMAND: %04x (???)\n",
> | drivers/acorn/scsi/acornscsi.c:    "??-out",                    /* 1C */
> | drivers/acorn/scsi/acornscsi.c:    "??-in",                     /* 1D */
> | drivers/block/acsi.c:   { 0x00, "No error (??)" },
> | drivers/block/acsi.c:   { 0x00, "No error (??)" },
> | drivers/media/video/saa7110.c:          DEBUG(printk(KERN_INFO "unknown saa7110_command??(%d)\n",cmd));
> | drivers/mtd/maps/sun_uflash.c:          name:           "SUNW,???-????",
> | drivers/scsi/ppa.c:     printk("ppa: parity error (???)\n");
> | drivers/scsi/ppa.c:     printk("ppa: bad interrupt (???)\n");
> | drivers/scsi/imm.c:     printk("imm: parity error (???)\n");
> | drivers/scsi/imm.c:     printk("imm: bad interrupt (???)\n");
> | net/rose/af_rose.c:                     callsign = "??????-?";
> | 
> | fixes are trivial.
> | 
> | Is 2.6.0-pre free of them  :-?
> 
> Of course not.  I grepped over 100 of them in 2.6.1.
> 
> Are they a problem?

Visually yes, they hurt to the sight ;-)

But unless somebody uses -std or -ansi, by default GCC
ignores trigraphs.

-- 
Software is like sex, it's better when it's bug free.


