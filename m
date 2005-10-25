Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbVJYRcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVJYRcw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 13:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVJYRcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 13:32:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7120 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932238AbVJYRcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 13:32:51 -0400
Date: Tue, 25 Oct 2005 10:32:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Max Kellermann <max@duempel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1 and later: second ata_piix controller is
 invisible
Message-Id: <20051025103217.18d55c92.akpm@osdl.org>
In-Reply-To: <20051025095646.GA24977@roonstrasse.net>
References: <20051025095646.GA24977@roonstrasse.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Kellermann <max@duempel.org> wrote:
>
> Hi Andrew,
> 
> since 2.6.14-rc4-mm1, my second ata_piix (SATA) controller does not
> show up in dmesg, effectively hiding /dev/sdb.  2.6.14-rc2-mm2 and
> older (with the same kernel config) were ok, the same for Linus'
> kernels: 2.6.14-rc5 without -mm1 has /dev/sdb, too.
> 
> 0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150
> Storage Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
> 0000:00:1f.2 0101: 8086:24d1 (rev 02)
> 
> This PCI device (on-board on an Asus P4 mainboard) has two SATA
> connectors, showing up as ata1/sda and ata2/sdb.
> 
> dmesg from 2.6.14-rc5:
> 
> libata version 1.12 loaded.
> ata_piix version 1.04
> ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 177
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> ata1: SATA max UDMA/133 cmd 0xEFE0 ctl 0xEFAE bmdma 0xEF60 irq 177
> ata2: SATA max UDMA/133 cmd 0xEFA0 ctl 0xEFAA bmdma 0xEF68 irq 177
> ata1: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01
> 87:4003 88:207f
> ata1: dev 0 ATA, max UDMA/133, 240121728 sectors:
> ata1: dev 0 configured for UDMA/133
> 
> dmesg from 2.6.14-rc5-mm1:
> 
> libata version 1.12 loaded.
> ata_piix version 1.04
> ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 193
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> ata1: SATA max UDMA/133 cmd 0xEFE0 ctl 0xEFAE bmdma 0xEF60 irq 193
> ata1: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01
> 87:4003 88:207f
> ata1: dev 0 ATA-7, max UDMA/133, 240121728 sectors: LBA
> ata1: dev 0 configured for UDMA/133
> 
> Need more information?  I could try to disable a few patches from your
> -mm series if you name some..  it's too hard for me to guess which one
> could be responsible for the breakage.
> 

Thanks.  It'd be useful if you could test just 2.6.14-rc5+git-acpi.patch,
see if that does the same thing.

