Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277057AbRJHSKk>; Mon, 8 Oct 2001 14:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277054AbRJHSKa>; Mon, 8 Oct 2001 14:10:30 -0400
Received: from pD9530E68.dip.t-dialin.net ([217.83.14.104]:14720 "HELO
	pc1.geisel.info") by vger.kernel.org with SMTP id <S277057AbRJHSKR>;
	Mon, 8 Oct 2001 14:10:17 -0400
Date: Mon, 8 Oct 2001 20:10:40 +0200
From: Dominik Geisel <dominik@geisel.info>
To: linux-kernel@vger.kernel.org
Subject: Problem with ACPI on Abit KT7,HPT370
Message-ID: <20011008201040.A1893@geisel.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

with all 2.4 kernels (latest I tried were 2.4.10 + 2.4.10-ac9), my Abit KT7-RAID
with onboard HPT370 IDE RAID controller, BIOS version 4A, locks up when ACPI
is enabled in the kernel. APM works fine. I enable

CONFIG_PM=Y
CONFIG_ACPI=Y
CONFIG_ACPI_BUSMGR=Y
CONFIG_ACPI_SYS=Y
CONFIG_ACPI_CPU=Y

The following messages could be useful:

this is the bootup messages when ACPI is disabled:
------------------------------------------------------------------------
Oct  8 19:50:31 pc1 kernel: HPT370: IDE controller on PCI bus 00 dev 98
Oct  8 19:50:31 pc1 kernel: PCI: Found IRQ 11 for device 00:13.0
Oct  8 19:50:31 pc1 kernel: HPT370: chipset revision 3
Oct  8 19:50:31 pc1 kernel: HPT370: not 100%% native mode: will probe irqs
later
Oct  8 19:50:31 pc1 kernel:     ide2: BM-DMA at 0xec00-0xec07,
BIOS settings: hde:DMA, hdf:pio
Oct  8 19:50:31 pc1 kernel:     ide3: BM-DMA at 0xec08-0xec0f, BIOS settings:
hdg:pio, hdh:pio
Oct  8 19:50:31 pc1 kernel: hda: IBM-DTTA-351010, ATA DISK drive
Oct  8 19:50:31 pc1 kernel: hdc: SONY CD-RW CRX140E, ATAPI CD/DVD-ROM drive
Oct  8 19:50:31 pc1 kernel: hde: IC35L040AVER07-0, ATA DISK drive
------------------------------------------------------------------------

When ACPI is enabled, it locks up after it detected "hdc: SONY CD-RW",
the HDD access LED stays on and the system hangs until I do a hard reboot.

Contact me if you need further logs or reports.
Dominik Geisel

-- 
Women want mediocre men. And men are working hard to become as medicore
as possible.
GPG public key @ http://www.geisel.info/key.asc
B216 156D 04EE AE0C 4C03  80C2 CE4B DBB3 801B 3CC2
