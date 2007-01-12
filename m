Return-Path: <linux-kernel-owner+w=401wt.eu-S964812AbXALSfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbXALSfU (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 13:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbXALSfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 13:35:20 -0500
Received: from cthulhu.lanfear.net ([206.124.137.179]:47811 "EHLO
	cthulhu.lanfear.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964812AbXALSfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 13:35:18 -0500
Date: Fri, 12 Jan 2007 10:35:15 -0800
From: Mark Wagner <mark@lanfear.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: sata_sil24 lockups under heavy i/o
Message-ID: <20070112183514.GA30434@freddy.lanfear.net>
Reply-To: Mark Wagner <mark@lanfear.net>
References: <20070103173024.GB17650@freddy.lanfear.net> <20070104181601.GD17650@freddy.lanfear.net> <45A092B7.4070301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A092B7.4070301@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 03:27:03PM +0900, Tejun Heo wrote:

> Mark Wagner wrote:
> [--snip--]
> >NETDEV WATCHDOG: eth0: transmit timed out
> >eth0: transmit timed out, tx_status 00 status e000.
> [--snip--]
> >hda: DMA timeout error
> >hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
> >ide: failed opcode was: unknown
> >hda: status timeout: status=0xd0 { Busy }
> >ide: failed opcode was: unknown
> >hdb: DMA disabled
> >hda: no DRQ after issuing MULTWRITE_EXT
> >ata3.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
> >ata3.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
> >ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
> >ata4.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
> >ata4: hard resetting port
> >ata2.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
> >ata2.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
> >ata2: hard resetting port
> >ata1.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 frozen
> >ata1.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
> >ata1.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
> [--snip--]
> >i2c_adapter i2c-0: Transaction error!
> >i2c_adapter i2c-0: Transaction error!
> >i2c_adapter i2c-0: Transaction error!
> 
> It seems like your system is falling apart.  Timeouts are occurring 
> everywhere.  Either IRQ routing went wrong or your powersupply is not 
> providing enough power.  Adding two more disks to sil24 doesn't change 
> anything about IRQ routing.  If the system functioned okay w/ two disks 
> attached to sil24, give your system a better power supply or rewire 
> power cables such that each power lane is more equally loaded.

The sil24-connected sata drives are external and connected to their own
power supply.

I've replaced the sil24-based card with a Promise SATA300 TX4 controller
card and everything seems to work now.

Thanks,

Mark

-- 
Mark Wagner mark@lanfear.net
