Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314073AbSDZPzS>; Fri, 26 Apr 2002 11:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314074AbSDZPzR>; Fri, 26 Apr 2002 11:55:17 -0400
Received: from slarti.muc.de ([193.149.48.10]:12303 "HELO slarti.muc.de")
	by vger.kernel.org with SMTP id <S314073AbSDZPzR> convert rfc822-to-8bit;
	Fri, 26 Apr 2002 11:55:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Stephan Maciej <stephan@maciej.muc.de>
Subject: [BUG] 2.5.10 - kernel hangs after detecting CD/DVD ROM (was: Re: IDE problem:  2.5.10 compiles but hangs during boot)
Date: Thu, 25 Apr 2002 17:57:07 +0200
X-Mailer: KMail [version 1.4]
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200204251757.07947.stephan@maciej.muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 April 2002 21:53, Mark Orr wrote:
> Linux 2.5.10 compiles but doesnt complete boot due to some IDE
> errors.    Previous working kernel was 2.5.8-pre3.

On my system, the bootup hangs completely after the kernel has detected my
CD/DVD ROM. Last working version was 2.5.9. When .9 it comes up, it displays
(dmesg dump, probably non-useful stuff stripped off):

Linux version 2.5.9 (root@maciej) (gcc version 2.95.3 20010315 (SuSE)) #3 Tue
Apr 23 21:54:54 CEST 2002
[...]
Sony Vaio laptop detected.
Kernel command line: auto BOOT_IMAGE=linux-2.5.9 ro root=301
[...]
CPU: AMD Duron(tm) Processor stepping 01
[...]
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
[...]
VIA Technologies, Inc. Bus Master IDE: IDE controller on PCI slot 00:07.1
VIA Technologies, Inc. Bus Master IDE: chipset revision 6
VIA Technologies, Inc. Bus Master IDE: not 100% native mode: will probe irqs
later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0x1c40-0x1c47, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1c48-0x1c4f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23CA-20, ATA DISK drive
hdc: QSI DVD-ROM SDR-081, ATAPI CD/DVD-ROM drive

That's the last line I see from a 2.5.10 kernel booting up. 2.5.9 does go
farther:

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide: unexpected interrupt 1 15
ide1 at 0x170-0x177,0x376 on irq 15
ide: unexpected interrupt 0 14
[... and so on...]

No OOPS, no BUG, even not a blinking cursor anymore (vesafb).

Stephan
