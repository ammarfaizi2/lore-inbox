Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261497AbSJMLZ4>; Sun, 13 Oct 2002 07:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261498AbSJMLZ4>; Sun, 13 Oct 2002 07:25:56 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:63730 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S261497AbSJMLZx>; Sun, 13 Oct 2002 07:25:53 -0400
Message-ID: <3DA9599F.5080208@cam.ac.uk>
Date: Sun, 13 Oct 2002 12:31:43 +0100
From: Jeff Snyder <ejs50@cam.ac.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Matt Johnson <mjj29@srcf.ucam.org>
Subject: IDE Disk errors/problems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
i've been getting errors that look somewhat like this when i try to boot 
my kernel:
... many many many similar lines preceeding this...
hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=79777432, 
sector=23855105
hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=79777432, 
sector=23855105
ide0: reset: success
hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=79777432, 
sector=23855105
end_request: I/O error, dev 3:06 (hda), sector 23855104
Kernel panic: VFS: Unable to mount root fs on 3:06

i dont think the error is with the drive, as the drive's last LBA sector 
is 78124xxx, so "SectorIdNotFound" is because the sectorId dosent exist (?)

similar problems have been discussed on the lkml here: 
http://www.cs.helsinki.fi/linux/linux-kernel/2002-37/subject.html#start 
("DMA problmes w/PIIX3 IDE.2420-pre4-ac2")
here: 
http://list.cobalt.com/pipermail/cobalt-developers/2000-November/025029.html
and here: 
http://lists.insecure.org/linux-kernel/2000/Sep/index.html#1691("[patch-required!] 
Recent kernels show problems in handling VERY large HDs").

The drive in question is a  Maxtor 7200rpm 40Gb drive,  with no  other 
devices on either ide  bus, and on a motherboard with a KT133 chipset.

Please CC me directly, i'm not on  the list :-)

    - Jeff//

