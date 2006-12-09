Return-Path: <linux-kernel-owner+w=401wt.eu-S1759166AbWLISjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759166AbWLISjg (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 13:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759165AbWLISjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 13:39:36 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:31604 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759166AbWLISjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 13:39:35 -0500
Date: Sat, 9 Dec 2006 10:39:54 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 does not boot, while 2.6.19-rc4 does
Message-Id: <20061209103954.868f818a.randy.dunlap@oracle.com>
In-Reply-To: <20061209152859.GA14037@gamma.logic.tuwien.ac.at>
References: <20061209152859.GA14037@gamma.logic.tuwien.ac.at>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2006 16:28:59 +0100 Norbert Preining wrote:

> Hi all!
> 
> [Please Cc]
> 
> I copied my old config-2.6.19-rc4 to a clean linux-2.6.19 tree, called
> make oldconfig; make, installed the kernel and modules, but the kernel
> cannot find the root file system.
> 
> I diffed the two config files and the only not-comment diff is:
> -# CONFIG_SYSCTL_SYSCALL is not set
> +CONFIG_SYSCTL_SYSCALL=y
> (how did this happen?)

The default changed from n to y.

> a part of the dmesg is included here (from -rc4):
> 
> libata version 2.00 loaded.
> ata_piix 0000:00:1f.2: version 2.00ac6
> ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
> ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 20
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x18B0 irq 14
> ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x18B8 irq 15
> scsi0 : ata_piix
> PM: Adding info for No Bus:host0
> ata1.00: ATA-7, max UDMA/133, 195371568 sectors: LBA48 NCQ (depth 0/32)
> ata1.00: ata1: dev 0 multi count 16
> ata1.00: configured for UDMA/133
> scsi1 : ata_piix

That didn't help (me).

> Hardware: Acer TravelMate 3012
> 
> 
> Any suggestions what to do next?

Test 2.6.19-rc5, 2.6.19-rc6, and then use git snapshots or
git bisect to focus in on the breakage.

And post more complete boot logs.

---
~Randy
