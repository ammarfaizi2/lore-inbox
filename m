Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVENVnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVENVnk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 17:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVENVnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 17:43:39 -0400
Received: from mta9.adelphia.net ([68.168.78.199]:27787 "EHLO
	mta9.adelphia.net") by vger.kernel.org with ESMTP id S261479AbVENVng
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 17:43:36 -0400
Message-ID: <42867104.60307@adelphia.net>
Date: Sat, 14 May 2005 17:43:32 -0400
From: "Rinaldi J. Montessi" <rinaldij@adelphia.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8b2) Gecko/20050513
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SCSI/libata/SATA problem
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


About the time the SCSI subsystem driver is loaded the hard drive
activity light comes on and never goes out.  The drive is a Western
Digital, Vendor: ATA Model: WDC WD1200JD-00H  Rev: 08.0.

The motherboard is an ASUS P5DA2-E Deluxe (intel 925x chipset).

Western Digital and ASUS both recommended I check the jumper settings,
which I had done.  ASUS also sent me a CD containing updates for the
Windows drivers.  I don't use Windows, and presume the disk to be
irrelevant to solving the problem.

There appears to be no problems with data corruption; meaning if I copy
large files from sda1 to hda1 drives the files show no difference.

If I boot only to hda1 and not automount the SATA drive (/home, /usr)
things appear normal (no LED except when there is activity).

I saw some libata changes in the latest 31-pre2 so compiled and rebooted
with no difference in behavior.

Links to dmesg, .config, and lspci output at bottom.

Same behavior in the latest 2.6.11 kernel (same drivers back ported?)

I am not subscribed to the list but do follow it via USENET.

uname -a
Linux Senior 2.4.30 #12 Wed May 11 21:15:29 EDT 2005 i686 unknown
unknown GNU/Linux

cat /proc/cmdline
BOOT_IMAGE=2.4.30_hda1 ro root=301 hde=ide-cd hdg=ide-cd hdh=ide-cd
ata2=none ata3=none ata4=none

dmesg | grep -i scsi
SCSI subsystem driver Revision: 1.00
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
     Type:   Direct-Access                      ANSI SCSI revision: 05
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)

dmesg | grep libata
libata version 1.10 loaded.

dmesg | grep SATA
ahci(00:1f.2) AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl SATA mode
ata1: SATA max UDMA/133 cmd 0xF8800D00 ctl 0x0 bmdma 0x0 irq 19
ata2: SATA max UDMA/133 cmd 0xF8800D80 ctl 0x0 bmdma 0x0 irq 19
ata3: SATA max UDMA/133 cmd 0xF8800E00 ctl 0x0 bmdma 0x0 irq 19
ata4: SATA max UDMA/133 cmd 0xF8800E80 ctl 0x0 bmdma 0x0 irq 19

http://users.adelphia.net/~rinaldij/lspci.log
http://users.adelphia.net/~rinaldij/dmesg.log
http://users.adelphia.net/~rinaldij/kernel.cfg

Rinaldi
-- 
The day after tomorrow is the third day of the rest of your life.


