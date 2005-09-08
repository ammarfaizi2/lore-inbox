Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbVIHKt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbVIHKt2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 06:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVIHKt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 06:49:28 -0400
Received: from bay106-f22.bay106.hotmail.com ([65.54.161.32]:25785 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932183AbVIHKt2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 06:49:28 -0400
Message-ID: <BAY106-F2246A8094E2C81DAA1A7ADC8990@phx.gbl>
X-Originating-IP: [151.41.133.97]
X-Originating-Email: [nchiellini@hotmail.com]
From: "Nicolo Chiellini" <nchiellini@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PROBLEM] Sata disk fail and Hang the machine
Date: Thu, 08 Sep 2005 12:49:27 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
X-OriginalArrivalTime: 08 Sep 2005 10:49:27.0714 (UTC) FILETIME=[FBF94820:01C5B462]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
i have a problem whit a machine, after some days of run i have a lot of this 
message on dmesg:

[...]
ata2: command 0x35 timeout, stat 0xd8 host_stat 0x0
ata2: status=0xd8 { Busy }
SCSI error : <1 0 0 0> return code = 0x8000002
sdb: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdb, sector 338664038
Buffer I/O error on device sdb5, logical block 42332989
lost page write due to I/O error on sdb5
ATA: abnormal status 0xD8 on port 0xC88020C7
ATA: abnormal status 0xD8 on port 0xC88020C7
ATA: abnormal status 0xD8 on port 0xC88020C7
[..]

And i have also a lot of proces whit the flag D+ and Ds , impossible to 
kill:
root     25947  0.0  0.6  2364  792 pts/3    D+   12:31   0:00 /usr/bin/ls 
--color=auto -F -b -T 0 /mnt/sata

I cant list/write on the directory where the partition is mounted and i cant 
even reboot via software, realy bad for a remote server, :
root     24886  0.0  0.4  1544  584 ?        D    12:03   0:00 shutdown -r 0 
w

I need to know if that can be a hw problem or just a sw problem and how to 
fix, i'm installing the latest 2.6.13 whaiting the manual reboot.

Thanks, N.C.


SOME INFOS:

Linux REMOTE 2.6.11.8 #2 Mon May 2 15:53:25 CEST 2005 i686 unknown unknown 
GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12a
mount                  2.12a
module-init-tools      3.0
e2fsprogs              1.35
jfsutils               1.1.6
reiserfsprogs          3.6.17
reiser4progs           line
xfsprogs               2.6.13
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.6
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   054
Modules Loaded         uhci_hcd ohci_hcd ehci_hcd sis_agp


LSPCI:

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 745 Host (rev 01)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI 
bridge (AGP)
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 (LPC 
Bridge)
00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:09.0 RAID bus controller: CMD Technology Inc Silicon Image SiI 3112 
SATARaid Controller (rev 02)
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 
04)


