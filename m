Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277124AbRJHUfs>; Mon, 8 Oct 2001 16:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277127AbRJHUfj>; Mon, 8 Oct 2001 16:35:39 -0400
Received: from maila.hrz.uni-siegen.de ([141.99.11.1]:59404 "EHLO
	maila.hrz.uni-siegen.de") by vger.kernel.org with ESMTP
	id <S277124AbRJHUfY>; Mon, 8 Oct 2001 16:35:24 -0400
Message-ID: <XFMail.20011008223542.dominik@unix-ag.org>
X-Mailer: XFMail 1.4.7p2 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20011008201040.A1893@geisel.info>
Date: Mon, 08 Oct 2001 22:35:42 +0200 (CEST)
From: Dominik Thinay <dominik@unix-ag.org>
To: Dominik Geisel <dominik@geisel.info>, linux-kernel@vger.kernel.org
Subject: RE: Problem with ACPI on Abit KT7,HPT370
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 
with kernel 2.4.11-pre3-xfs + i2c CVS-patch + lmsensors it works fine on my
system (Abit Bios KT7_49B0)


CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUSMGR=y
CONFIG_ACPI_SYS=y
CONFIG_ACPI_CPU=y
CONFIG_ACPI_BUTTON=y
But i don't use ide cdrom's 

I remember disabled sth in the bios ...but i have forget ... :(

regards dominik


Ps: "IC35L040AVER07-0" works in UDMA(44) or :( I have disabled the entry in the
        blacklist of  hpt366.c (dtla307030,dtla307060) for testing with the new
        mb bios



> Hi,
> 
> with all 2.4 kernels (latest I tried were 2.4.10 + 2.4.10-ac9), my Abit
> KT7-RAID
> with onboard HPT370 IDE RAID controller, BIOS version 4A, locks up when ACPI
> is enabled in the kernel. APM works fine. I enable
> 
> CONFIG_PM=Y
> CONFIG_ACPI=Y
> CONFIG_ACPI_BUSMGR=Y
> CONFIG_ACPI_SYS=Y
> CONFIG_ACPI_CPU=Y
> 
> The following messages could be useful:
> 
> this is the bootup messages when ACPI is disabled:
> ------------------------------------------------------------------------
> Oct  8 19:50:31 pc1 kernel: HPT370: IDE controller on PCI bus 00 dev 98
> Oct  8 19:50:31 pc1 kernel: PCI: Found IRQ 11 for device 00:13.0
> Oct  8 19:50:31 pc1 kernel: HPT370: chipset revision 3
> Oct  8 19:50:31 pc1 kernel: HPT370: not 100%% native mode: will probe irqs
> later
> Oct  8 19:50:31 pc1 kernel:     ide2: BM-DMA at 0xec00-0xec07,
> BIOS settings: hde:DMA, hdf:pio
> Oct  8 19:50:31 pc1 kernel:     ide3: BM-DMA at 0xec08-0xec0f, BIOS settings:
> hdg:pio, hdh:pio
> Oct  8 19:50:31 pc1 kernel: hda: IBM-DTTA-351010, ATA DISK drive
> Oct  8 19:50:31 pc1 kernel: hdc: SONY CD-RW CRX140E, ATAPI CD/DVD-ROM drive
> Oct  8 19:50:31 pc1 kernel: hde: IC35L040AVER07-0, ATA DISK drive
> ------------------------------------------------------------------------
> 
> When ACPI is enabled, it locks up after it detected "hdc: SONY CD-RW",
> the HDD access LED stays on and the system hangs until I do a hard reboot.
> 
> Contact me if you need further logs or reports.
> Dominik Geisel
> 
> -- 
> Women want mediocre men. And men are working hard to become as medicore
> as possible.
> GPG public key @ http://www.geisel.info/key.asc
> B216 156D 04EE AE0C 4C03  80C2 CE4B DBB3 801B 3CC2
> -

-- 
----------------------------------
E-Mail: Dominik Thinay <dominik@unix-ag.org>
Date: 08-Oct-2001

----------------------------------
