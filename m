Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267329AbTABXrW>; Thu, 2 Jan 2003 18:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267317AbTABXrU>; Thu, 2 Jan 2003 18:47:20 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:128 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S267326AbTABXq7>; Thu, 2 Jan 2003 18:46:59 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.18: filesystem corruption on harddisk when bad sectors on floppydisk (!)
Date: Fri, 3 Jan 2003 00:55:26 +0100
Message-ID: <00a001c2b2ba$6c77ffe0$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I read from a floppy disk with badsectors and write to a file
on the harddisk, I get filesystem corruption. Filesystem on hard-
disk is ext3. I'm reading the floppy in raw mode (open("/dev/fd0"
etc.).
In dmesg I get:
floppy0: data CRC error: track 32, head 1, sector 7, size 2
floppy0: data CRC error: track 32, head 1, sector 7, size 2
end_request: I/O error, dev 02:00 (floppy), sector 1176
and suddenly the write fails with 22. The file attributes are
suddenly weird:
-rwxr-Sr-T    1 root     root       602112 Jan  3 00:50 ../test
Nothing in the logs.
Kernel version is 2.4.18.
Harddisk is on IDE:
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
hda: ST320413A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
No fiddling with hdparm or whatsoever.


Folkert van Heusden

p.s. the rather trivial program I used can be found at:
http://www.vanheusden.com/Linux/recoverdm-0.1.tgz
