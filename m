Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270302AbTGRTwA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 15:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270352AbTGRTwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 15:52:00 -0400
Received: from mail.egps.com ([38.119.130.6]:37649 "EHLO egps.com")
	by vger.kernel.org with ESMTP id S270365AbTGRTvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 15:51:51 -0400
Date: Fri, 18 Jul 2003 16:06:43 -0400
From: Nachman Yaakov Ziskind <awacs@egps.com>
To: linux-kernel@vger.kernel.org
Subject: DVD-RAM crashing system
Message-ID: <20030718160643.A21755@egps.egps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... bought a Dell Poweredge 600 box with RH 7.3 (2.4.18-4 #1)
pre-installed, and SCSI hard disks. Added a Matsushita DVD-RAM
LF-D311 atapi dvd-ram (that, along with a cd-rom, are the only
IDE devices).

Now, when I do a full backup (as opposed to a differential; I'm
using Microlite's BackupEdge, a Super-Tar), the machine
(sometimes) hangs with the error message:

"Serverworks OSB4 in impossible state.
Disable UDMA or if you are using Seagate then try switching disk
types on this controller. Please report this event to osb4-
bug@ide.cabal.tm 
OSB4: continuing might cause disk corruption."

RH support advised me to remove "ide0=ata66 ide1=ata66" from the
kernel line in /boot/grub/grub.conf, add "ide-nodma" and reboot.
No joy. Note the following kernel messages at boot-up:

Jul 18 02:31:52 gemach kernel: Kernel command line: ro
root=/dev/sda9 hda=ide-scsi ide=nodma
Jul 18 02:31:52 gemach kernel: ide_setup: hda=ide-scsi
Jul 18 02:31:54 gemach kernel: ide0: BM-DMA at 0x08b0-0x08b7,
BIOS settings: hda:pio, hdb:pio
Jul 18 02:31:55 gemach kernel: ide1: BM-DMA at 0x08b8-0x08bf,
BIOS settings: hdc:DMA, hdd:pio
Jul 18 02:31:55 gemach kernel: hda: MATSHITADVD-RAM LF-D311,
ATAPI CD/DVD-ROM drive
Jul 18 02:31:55 gemach kernel: hdc: GCR-8481B, ATAPI CD/DVD-ROM
drive
Jul 18 02:31:35 gemach rc.sysinit: Setting hard drive parameters
for hdc: succeeded
Jul 18 02:31:59 gemach kernel: hdc: ATAPI 48X CD-ROM drive, 128kB
Cache
Jul 18 02:31:59 gemach kernel: hda: driver not present
Jul 18 02:31:59 gemach kernel: hda: DMA disabled
Jul 18 02:31:59 gemach kernel: hdc: DMA disabled
Jul 18 02:31:59 gemach kernel: hdc: DMA disabled

According to the RH technician, 

"Unfortunately this may be beyond a software resolution. On the
machine I last saw this error on (it was not a Dell) the chipset
would not accept commands that disabled DMA properly. By issuing
the normal commands to disable DMA, then checking in various
parts of the /proc filesystem, you would find parts of the
kernel that believe DMA to be disabled, and other parts that
believe DMA enabled- thus an 'impossible state'."

Anyone out there with tips on how to resolve this? Perhaps I can
force the kernel to think that DMA has been disabled?

Thanks in advance, and please cc: me at awacs@egps.com.

-- 
_________________________________________
Nachman Yaakov Ziskind, EA, LLM         awacs@egps.com
Attorney and Counselor-at-Law           http://yankel.com
Economic Group Pension Services         http://egps.com
Actuaries and Employee Benefit Consultants
