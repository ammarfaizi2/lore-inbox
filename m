Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265271AbUAKQgh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 11:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265378AbUAKQgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 11:36:37 -0500
Received: from hive.scnr.net ([80.190.231.103]:22155 "HELO hive.scnr.net")
	by vger.kernel.org with SMTP id S265271AbUAKQgf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 11:36:35 -0500
Message-Id: <5.1.0.14.2.20040111161640.014ad6c0@localhost>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 11 Jan 2004 17:36:32 +0100
To: linux-kernel@vger.kernel.org
From: Hans Spath <ml-lkml@hans-spath.de>
Subject: 2.6.1: data corrupton when recieving files > 1GB over network
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When I transfer files to my linux 2.6.1 box their content changes (tested 
via md5 sums).

I transfered a 1,8 GB (mpeg) file serveral times to this machine by using 
either pure-ftpd (upload) or wget (download) on that machine. I got a 
different md5sum each time. Same problem with a 1,4 GB (zip) file, but 
*not* with a 0,7 GB (mpeg) file.

When I boot the machine with Knoppix 3.2 (Linux 2.4.21-xfs) and upload the 
1,8 GB file to it's ftpd (same target harddisk/partition/directory), the 
file is ok.

When I dupplicate the correctly recieved file with dd or cp under Linux 
2.6.1 there is no corruption, too.

I don't know what tools I should use to determine at what positions these 
corruptions start and how much is corrupted. But I think about the first 1 
GB is transfered correctly (diff needs some time before it says "Binary 
files test-2.6.mpeg and test-2.4.mpeg differ")

Kernel is built without module support.


[ Some lines from dmesg ]
Linux version 2.6.1 (stob@netbrake) (gcc version 2.95.4 20011002 (Debian 
prerelease)) #5 Sat Jan 10 01:40:00 CET 2004
CPU: Intel Pentium III (Katmai) stepping 02
agpgart: Detected VIA Apollo Pro 133 chipset
eth0: RealTek RTL8139 at 0xe3818000, 00:00:21:d5:a6:48, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139B'
hda: Maxtor 98196H8, ATA DISK drive
hda: max request size: 128KiB
hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(33)
  hda: hda1
EXT3 FS on hda1, internal journal

[ Output of scripts/ver_linux ]
Linux netbrake 2.6.1 #5 Sat Jan 10 01:40:00 CET 2004 i686 unknown
Gnu C                  2.95.4
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      implemented
e2fsprogs              1.34
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 3.1.15
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11

