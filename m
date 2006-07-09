Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030475AbWGIMla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030475AbWGIMla (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 08:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbWGIMla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 08:41:30 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59547 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030475AbWGIMl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 08:41:29 -0400
Subject: Re: 2.6.18-rc1-mm1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, rdunlap@xenotime.net, greg@kroah.com,
       john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@muc.de>
In-Reply-To: <20060709052252.8c95202a.akpm@osdl.org>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	 <44B0E6E6.6070904@reub.net>  <20060709052252.8c95202a.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 09 Jul 2006 13:56:45 +0100
Message-Id: <1152449805.27368.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-07-09 am 05:22 -0700, ysgrifennodd Andrew Morton:
> > ata5: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x30B0 irq 14
> > scsi4 : ata_piix
> > ata5.00: ATAPI, max UDMA/66
> > ata5.00: configured for UDMA/66

More ATAPI devices getting uppity about mode setting.

> John stuff.  I suspect it's natural and normal, if the IDE error handling
> did something rude with interrupt holdoff.

The new libata should be more polite than that, although since the ATA
drive can stall the CPU indefinitely you lose anyway 8(

> > Jul  2 12:03:28 tornado kernel: hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 
> > 2000kB Cache, UDMA(66)

Can you send me the full hdparm identify stuff for this ?


The old drivers/ide code uses much longer delays than the spec for some
ATAPI commands, and it looks as if there is a good reason for doing
so ...

That or I've got a mistuning case I've missed.

Alan

