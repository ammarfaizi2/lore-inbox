Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262654AbSITOO1>; Fri, 20 Sep 2002 10:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262658AbSITOO1>; Fri, 20 Sep 2002 10:14:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17939 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262654AbSITOO0>;
	Fri, 20 Sep 2002 10:14:26 -0400
Message-ID: <3D8B2E51.7040108@mandrakesoft.com>
Date: Fri, 20 Sep 2002 10:18:57 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Finnie <jf1@IMERGE.co.uk>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: IDE Hard disk geometry problem in 2.4.19 / 2.4.20pre7
References: <C0D45ABB3F45D5118BBC00508BC292DB9D4208@imgserv04>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Finnie wrote:
> Hi,
> 
> I have a large number of IDE hard disks here where I work.  Since moving to
> 2.4.19 from 2.4.17, several of these disks have stopped working, resulting
> in a kernel panic after the drive has declared itself to have 0 cylinders!
> All the disks that have broken are the following:
> 
> Seagate 80GB U6 ST380020ACE with Firmware version 4.65
> 
> We have lots of these same drives, with FW v 3.34, that all work fine.  I do
> not have a single drive with the 4.65 firmware working.  
> 
> My problem is that these drives used to work fine, with 2.4.17.  They are
> not obsolete hardware, I think they are all less than 6 months old.
> 
> I have seen this on CS5530 with the standard kernel PCI IDE, and on SIS630
> with the SIS Kernel IDE driver.  
> 
> Setting ide=nodma makes no difference.
> 
> Here is an excerpt from the kernel console booting:
> 
> 
> ....
> hda: ST380020ACE, ATA DISK drive
> ....
> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04  { DriveStatusError }
> hda: setmax_ext LBA 1, native 0
> hda: 0 sectors (0 MB) w/2048KiB Cache, CHS 0/255/63, (U)DMA
> ....
> hda2: bad access: block=2, count=2
> end_request: I/O error, dev 03:02 (hda), sector 2
> EXT3-fs: unable to read superblock
> hda2: bad access: block=2, count=2
> end_request: I/O error, dev 03:02 (hda), sector 2
> EXT3-fs: unable to read superblock
> Kernel panic: VFS: Unable to mount root fs on 03:02
> 
> 
> Is this a result of all the new IDE stuff that went in in 2.4.19???


"All the new IDE stuff" hasn't really hit 2.4.x yet...

Do you have CONFIG_IDEDISK_STROKE set?  If yes, do things start working 
if you disable it?

Can you post the other IDE options you have set in your kernel config?

	Jeff



