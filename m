Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262608AbRE2EbX>; Tue, 29 May 2001 00:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262525AbRE2EbN>; Tue, 29 May 2001 00:31:13 -0400
Received: from femail2.rdc1.on.home.com ([24.2.9.89]:42915 "EHLO
	femail2.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S262518AbRE2EbE>; Tue, 29 May 2001 00:31:04 -0400
Date: Tue, 29 May 2001 00:39:15 -0500
X-Mailer: 21.4 (patch 3) "Academic Rigor" XEmacs Lucid (via feedmail 9-beta-7 I);
	VM 6.92 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15123.13827.487137.251571@gargle.gargle.HOWL>
From: "S.Salman Ahmed" <ssahmed@pathcom.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: IDE Problems with 2.4.5-ac3
Reply-To: ssahmed@pathcom.com
X-No-Archive: Yes
X-Operating-System: Linux viper 2.4.3 i686
X-Organization: Salman Ahmed Software & Consulting
X-Disclaimer: I didn't do it, little green aliens wrote this email
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(I am not subscribed to linux-kernel, so please CC: me if more info is
needed)

I decided to try out 2.4.5-ac3 on a headless firewall that has a
Realtek8139-based NIC (D-Link 530TX+). Indeed, the 8139too driver in ac3
seems to work better than in 2.4.5 and I was unable to duplicate the
crashes that I was experiencing with 2.4.5.

However, not too long (~ 20 minutes)after installing ac3 on this machine
I heard a couple of "clicks" from its hard drive and upon checking the
logs, I saw the following in kern.log (sorry for the long lines):

May 28 22:12:37 phoenix kernel: hda: drive not ready for command
May 28 22:12:37 phoenix kernel: EXT2-fs error (device ide0(3,7)): read_inode_bitmap: Cannot read inode bitmap - block_group = 17, inode_bitmap = 139266
May 28 22:12:37 phoenix kernel: ide0: reset: master: error (0x7f?)
May 28 22:12:37 phoenix kernel: hda: status error: status=0x7f { DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }
May 28 22:12:37 phoenix kernel: hda: status error: error=0x7f { DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound AddrMarkNotFound }, LBAsect=260013951, sector=540684
May 28 22:12:37 phoenix kernel: hda: drive not ready for command
May 28 22:12:37 phoenix kernel: ide0: reset: master: error (0x7f?)
May 28 22:12:37 phoenix kernel: hda: status error: status=0x7f { DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }
May 28 22:12:37 phoenix kernel: hda: status error: error=0x7f { DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound AddrMarkNotFound }, LBAsect=260013951, sector=540684
May 28 22:12:37 phoenix kernel: end_request: I/O error, dev 03:06 (hda), sector 540684
May 28 22:12:37 phoenix kernel: hda: drive not ready for command
May 28 22:12:37 phoenix kernel: IO error syncing ext2 inode [ide0(3,6):000106fd]
May 28 22:12:37 phoenix kernel: hda: status error: status=0x7f { DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }
May 28 22:12:37 phoenix kernel: hda: status error: error=0x7f { DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound AddrMarkNotFound }, LBAsect=260013951, sector=6588
May 28 22:12:37 phoenix kernel: hda: drive not ready for command
May 28 22:12:37 phoenix kernel: ide0: reset: master: error (0x7f?)
May 28 22:12:37 phoenix kernel: hda: status error: status=0x7f { DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }
May 28 22:12:37 phoenix kernel: hda: status error: error=0x7f { DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound AddrMarkNotFound }, LBAsect=260013951, sector=6588
May 28 22:12:37 phoenix kernel: hda: drive not ready for command
May 28 22:12:37 phoenix kernel: ide0: reset: master: error (0x7f?)
May 28 22:12:37 phoenix kernel: hda: status error: status=0x7f { DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }
May 28 22:12:37 phoenix kernel: hda: status error: error=0x7f { DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound AddrMarkNotFound }, LBAsect=260013951, sector=6588


I have since switchted to 2.4.3, and haven't noticed any IDE related
problems. The system is a Celeron300A based machine with a 15Gb Maxtor
UDMA66 HD on an Abit BH6. It has two NICs :

eth0: Sohoware NDC 10/100 using the tulip driver
eth1: D-Link 530TX+ 10/100 using the 8139too driver

Prior to trying out 2.4.5 a couple of days ago, this machine had been
running 2.4.2 without *any* problems at all with an uptime of 91 days.

I have not been able to check all partitions on this machine for
badblocks since it is a headless machine without a video card, but the
ones I did check didn't turn up any bad blocks. The HD is about 8 months
old.

I had 2.4.3 running on this machine last night and the machine was
completely frozen when I woke up today morning. I rebooted the machine
before I went to work, but when I came back it was frozen again. I will
go back to 2.4.2 if this machine freezes again with 2.4.3.

-- 
Salman Ahmed
ssahmed AT pathcom DOT com

