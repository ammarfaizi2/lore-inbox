Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287627AbSAERZD>; Sat, 5 Jan 2002 12:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288894AbSAERYx>; Sat, 5 Jan 2002 12:24:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9229 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288891AbSAERYg>; Sat, 5 Jan 2002 12:24:36 -0500
Subject: Re: Patch: linux-2.5.2-pre6/drivers/message/i2o/i2o_block.c compilation fixes
To: adam@yggdrasil.com (Adam J. Richter)
Date: Sat, 5 Jan 2002 17:35:16 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020105014634.A22037@baldur.yggdrasil.com> from "Adam J. Richter" at Jan 05, 2002 01:46:34 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Muiy-0000RJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	The following patch fixes various compilation errors in
> linux-2.5.2-pre8/drivers/message/i2o/i2o_block.c, related to
> kdev_t and the new spinlock parameter to blk_init_queue.
> It might be a good idea for someone to look at the spinlocks
> that I created for blk_init_queue in this patch and tell me if
> I botched it.

Unless you have i2o hardware  please leave that code alone. It just creates
more maintenance nightmares. I2O on 2.5.x is broken anyway and will oops
when loaded with or without you changes. I know about this. I will look at
it once the block layer changes are stable.

There are 32/64bit bugs, endian assumptions, and the complete absence of the
use of the PCI dma API to deal with too.
