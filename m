Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267685AbRGPTdk>; Mon, 16 Jul 2001 15:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267687AbRGPTdc>; Mon, 16 Jul 2001 15:33:32 -0400
Received: from altrade.nijmegen.inter.nl.net ([193.67.237.6]:42207 "EHLO
	altrade.nijmegen.inter.nl.net") by vger.kernel.org with ESMTP
	id <S267690AbRGPTdV>; Mon, 16 Jul 2001 15:33:21 -0400
From: "Bas Rijniersce" <bas@brijn.nu>
To: <linux-kernel@vger.kernel.org>
Subject: Linux 2.2.19 /  2.4.6(ac5) , Tyan Trinity KT-a, Duron 800, IBM IDE disk not usable
Date: Mon, 16 Jul 2001 21:33:14 +0200
Message-ID: <AOEPLKHIHCMMODPHFHEAAEDICBAA.bas@brijn.nu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I recently bought a Tyan Trinity KTa motherboard, a 800 Mhz AMD Duron, 128Mb
memory, IBM IC35L040AVER07-0 IDE HD and LiteON CDROM. BIOS of mobo is the
lastest available.
>From the current server a Tekram DC390 adapter with two SCSI disks was used.
After placing the SCSI disks in the system and setting the SCSI adapter as
boot device the system works fine.

With one big exeption, the IDE disk (last time the cable was plugged in
wrong, that's why it's at hdc, tried hda as well) refuses to work. The
standard kernel on the system is 2.2.19, while booting:

Jul 14 00:28:18 brijn kernel: Linux version 2.2.19 (root@brijn.nu) (gcc
version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #3 Fri Jul 13
13:44:50 CEST 2001
..
Jul 14 00:28:19 brijn kernel: CPU: L1 I Cache: 64K  L1 D Cache: 64K
Jul 14 00:28:19 brijn kernel: CPU: L2 Cache: 64K
Jul 14 00:28:19 brijn kernel: CPU: AMD Duron(tm) Processor stepping 01
..
Jul 14 00:28:19 brijn kernel: VP_IDE: IDE controller on PCI bus 00 dev 39
Jul 14 00:28:19 brijn kernel: VP_IDE: not 100%% native mode: will probe irqs
later
Jul 14 00:28:19 brijn kernel: hdb: LTN526S, ATAPI CDROM drive
Jul 14 00:28:19 brijn kernel: hdc: IC35L040AVER07-0, ATA DISK drive
Jul 14 00:28:19 brijn kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
..
Jul 14 00:28:20 brijn kernel: Partition check:
Jul 14 00:28:20 brijn kernel:  sda: sda1 sda2 sda3 sda4
Jul 14 00:28:20 brijn kernel:  sdb: sdb1 sdb2 sdb3
Jul 14 00:28:20 brijn kernel:  hdc: hdc1 hdc2 < hdc5hdc: read_intr:
status=0x59 { DriveReady SeekComplete DataRequest Error }
Jul 14 00:28:20 brijn kernel: hdc: read_intr: error=0x04
{ DriveStatusError }
Jul 14 00:28:20 brijn kernel: hdc: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Jul 14 00:28:20 brijn kernel: hdc: read_intr: error=0x04
{ DriveStatusError }
Jul 14 00:28:20 brijn kernel: hdc: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Jul 14 00:28:20 brijn kernel: hdc: read_intr: error=0x04
{ DriveStatusError }
Jul 14 00:28:20 brijn kernel: hdc: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Jul 14 00:28:20 brijn kernel: hdc: read_intr: error=0x04
{ DriveStatusError }
Jul 14 00:28:20 brijn kernel: ide1: reset: success
Jul 14 00:28:20 brijn kernel: hdc: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Jul 14 00:28:20 brijn kernel: hdc: read_intr: error=0x04
{ DriveStatusError }
Jul 14 00:28:20 brijn kernel: hdc: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Jul 14 00:28:20 brijn kernel: hdc: read_intr: error=0x04
{ DriveStatusError }
Jul 14 00:28:20 brijn kernel: hdc: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Jul 14 00:28:20 brijn kernel: hdc: read_intr: error=0x04
{ DriveStatusError }
Jul 14 00:28:20 brijn kernel: hdc: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Jul 14 00:28:20 brijn kernel: hdc: read_intr: error=0x04
{ DriveStatusError }
Jul 14 00:28:20 brijn kernel: ide1: reset: success
Jul 14 00:28:20 brijn kernel: hdc: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Jul 14 00:28:20 brijn kernel: hdc: read_intr: error=0x04
{ DriveStatusError }
Jul 14 00:28:20 brijn kernel: end_request: I/O error, dev 16:06 (hdc),
sector 0
Jul 14 00:28:20 brijn kernel:  >

Having seen a lot of problems with the Duron/VIA combination I installed
2.4.6 to make sure I have the latest updates for this:

Jul 14 00:01:19 brijn kernel: Linux version 2.4.6 (root@brijn.nu) (gcc
version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Sat Jul 14
00:11:54 CEST 2001
..
Jul 14 00:01:33 brijn kernel: Uniform Multi-Platform E-IDE driver Revision:
6.31
Jul 14 00:01:33 brijn kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Jul 14 00:01:33 brijn kernel: hdb: LTN526S, ATAPI CD/DVD-ROM drive
Jul 14 00:01:33 brijn kernel: hdc: IC35L040AVER07-0, ATA DISK drive
Jul 14 00:01:33 brijn kernel: ide0: unexpected interrupt, status=0x7f,
count=1
Jul 14 00:01:33 brijn kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul 14 00:01:33 brijn kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jul 14 00:01:33 brijn kernel: hdc: 80418240 sectors (41174 MB) w/1916KiB
Cache, CHS=79780/16/63
Jul 14 00:01:33 brijn kernel: hdb: ATAPI 52X CD-ROM drive, 120kB Cache
..
Jul 14 00:01:33 brijn kernel: Partition check:
Jul 14 00:01:33 brijn kernel:  hdc: [PTBL] [5005/255/63] hdc1 hdc2 <
hdc5hdc: read_intr: status=0x59 { DriveReady SeekComplete DataRequest
Error }
Jul 14 00:01:33 brijn kernel: hdc: read_intr: error=0x04
{ DriveStatusError }
Jul 14 00:01:33 brijn kernel: hdc: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Jul 14 00:01:33 brijn kernel: hdc: read_intr: error=0x04
{ DriveStatusError }
Jul 14 00:01:33 brijn kernel: hdc: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Jul 14 00:01:33 brijn kernel: hdc: read_intr: error=0x04
{ DriveStatusError }
Jul 14 00:01:33 brijn kernel: hdc: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Jul 14 00:01:33 brijn kernel: hdc: read_intr: error=0x04
{ DriveStatusError }
Jul 14 00:01:33 brijn kernel: ide1: reset: success
Jul 14 00:01:33 brijn kernel: hdc: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Jul 14 00:01:33 brijn kernel: hdc: read_intr: error=0x04
{ DriveStatusError }
Jul 14 00:01:33 brijn kernel: hdc: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Jul 14 00:01:33 brijn kernel: hdc: read_intr: error=0x04
{ DriveStatusError }
Jul 14 00:01:33 brijn kernel: hdc: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Jul 14 00:01:33 brijn kernel: hdc: read_intr: error=0x04
{ DriveStatusError }
Jul 14 00:01:33 brijn kernel: hdc: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Jul 14 00:01:34 brijn kernel: hdc: read_intr: error=0x04
{ DriveStatusError }
Jul 14 00:01:34 brijn kernel: ide1: reset: success
Jul 14 00:01:34 brijn kernel: hdc: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Jul 14 00:01:34 brijn kernel: hdc: read_intr: error=0x04
{ DriveStatusError }
Jul 14 00:01:34 brijn kernel: end_request: I/O error, dev 16:06 (hdc),
sector 0
Jul 14 00:01:34 brijn kernel:  >

The error is somewhat like the one that Google suggested was solved by "use
multi-mode by default". Didn't help. Saw messages about VIA problems with
IDA DMA enabled, tried those setting, didn't help. Enable the VIA specific
driver, tried the ide0/1 ata66 settings, didn't help. Tried several APIC
options, didn't help.

This is all with CPU set to 486, Duron setting makes the system Oops all
over the place (several different ones didn't write them down since someone
else was reading them to me over a phone :), but AIEE killing interrupt
handler and another one with fill_inactive pages were two. I'll be happy to
try ta catch them if there is interrest. But since this is a production
server I would like to get the disk running first :-)

Saw the ac4 CHANGELOG contained some VIA stuff, went to download it and saw
ac5 so tried that kernel as well, didn't help.

I'm unable to use this disk, Windows was installed on the system as a test,
it worked fine. The disk is tested by IBM software for testing HD's.

What goes wrong? I'm happy to run any test that is needed..

TIA,
Bas Rijniersce

----
Bas Rijniersce               T: +31 30 6993131
Laan van Vollenhove 514      M: +31 6 53356831
3706 AA  Zeist               E: bas@brijn.nu

