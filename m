Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265700AbSKKPeN>; Mon, 11 Nov 2002 10:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265697AbSKKPeN>; Mon, 11 Nov 2002 10:34:13 -0500
Received: from ma-northadams1b-126.bur.adelphia.net ([24.52.166.126]:1152 "EHLO
	ma-northadams1b-126.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S265700AbSKKPeL>; Mon, 11 Nov 2002 10:34:11 -0500
Date: Mon, 11 Nov 2002 10:41:53 -0500
From: Eric Buddington <eric@ma-northadams1b-126.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.47 hangs while checking hda on PII laptop
Message-ID: <20021111104153.A8017@ma-northadams1b-126.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 2.5.47, compiled for a PII laptop (Omnibook 4100) with
gcc-3.2. I fixed an earlier boot panic by disabling IDE-TCQ, but now
it hangs in the hda check (shown below) I waited at least 2 minutes
for it to unhang.

Below is as much of the boot messages as I could capture; I don't know
if the hdc error is significant (the drive had no media), but pulling
the CD-ROM did not prevent the hda hang in a subsequent boot.

-Eric

------------------------------------------

ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: (supports S0 S1 S2 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs *10)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Embedded Controller [EC0] (gpe 9)
AnCPI: Power Reso [PIDE] (on)
ACPI: Power Resource [PIDE] (on)
pci_bind-0191 [17] acpi_pci_bind         : Device 00:00:11.00 not present in PCI
 namespace
pci_bind-0191 [18] acpi_pci_bind         : Device 00:00:12.00 not present in PCI
 namespace
ACPI: Power Resource [PFAN] (off)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off
'
NET4: Frame Diverter 0.46
Total HugeTLB memory allocated, 0
slab: reap timer started for cpu 0
Starting kswapd
aio_setup: sizeof(struct page) = 40
[c11ac040] eventpoll: driver installed.
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x1
Capability LSM initialized
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ytts/0 at I/O 0x3f8 (irq = 4) is a 16550A
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdc: _NEC CDR-2800B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
hda: 3909MB, CHS=993/128/63
 hda:
