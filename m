Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131643AbRCXLC3>; Sat, 24 Mar 2001 06:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131647AbRCXLCT>; Sat, 24 Mar 2001 06:02:19 -0500
Received: from monsoon.mail.pipex.net ([158.43.128.69]:55436 "HELO
	monsoon.mail.pipex.net") by vger.kernel.org with SMTP
	id <S131643AbRCXLCB>; Sat, 24 Mar 2001 06:02:01 -0500
Message-ID: <3ABC7E56.2040003@bigfoot.com>
Date: Sat, 24 Mar 2001 11:00:38 +0000
From: Nick Clark <Nick.Clark@bigfoot.com>
Reply-To: Nick.Clark@bigfoot.com
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE drive status error 0x058 under load 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey. Using Kernel 2.2.18 + E-IDE patches Rev 6.30 + Raid patches

Putting together a fileserver setup with two mirrored FSs over four 
disks & two IDE controllers (ie each disk on controller 1 is mirrored to 
a second on Controller 2, using raid 1).

No problems accessing disks separately, can create FS on each Ok with 
out errors. Can build each raid pair separately with no errors.

But when attempting to build raid devices on all four disks at the same 
time get many of these

Mar 22 15:41:11 uther kernel: hdk: status error: status=0x58 { 
DriveReady SeekComplete DataRequest }
Mar 22 15:41:11 uther kernel: hdk: drive not ready for command

.. from all four disks. Also get these when attempting mke2fs on all 
disks at the same time (no raid).

Im guessing (probably incorrectly) that this is a warning message only & 
that I can ignore them; can anyone confirm / deny that for me? Got a bit 
out of my depth with this..

Hardware is
ABit VP6 M/B, 2x1Ghz PIII, 512MB
2x Promise ultra100 PCI IDE controllers with 4x IBM-DTLA-307075 73Gb Drives
3Com 3C980 NIC
5th IBM-DTLA-307075 as root disk (no mirror), on M/B IDE controller. 
Onboard 'raid' controler disabled in bios.

Software is
RedHat 7.01 distribution
Kernel 2.2.18 + E-IDE patches Rev 6.30 + Raid patches
(also tried with 2.4.2 + E-IDE patches Rev 6.31, same problem)

... let me know if there is any other info I can give you. Thanx,

Nick.

-- 
Nick Clark is now --> Nick.Clark@Bigfoot.com <-- Thanking you.

