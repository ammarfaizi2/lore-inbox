Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262622AbTCYMfj>; Tue, 25 Mar 2003 07:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262623AbTCYMfj>; Tue, 25 Mar 2003 07:35:39 -0500
Received: from [81.80.245.157] ([81.80.245.157]:56507 "EHLO smtp.alcove-fr")
	by vger.kernel.org with ESMTP id <S262622AbTCYMfe>;
	Tue, 25 Mar 2003 07:35:34 -0500
Date: Tue, 25 Mar 2003 13:47:11 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: USB MemoryStick reader and 2.5.66
Message-ID: <20030325124711.GC1242@hottah.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is the usb storage driver supposed to work in the latest kernels, or
is there somewhere a big pile of scsi / usb-storage patches waiting
to be integrated and I shouldn't bother with that until then ?

This is with an internal USB Memory Stick reader on a Sony Vaio C1VE, 
which works just fine in 2.4, but in 2.5 it doesn't even gets 
recognized (hotplug ?). If I modprobe usb-storage manually the 
module loads just fine:
  Initializing USB Mass Storage driver...
  scsi0 : SCSI emulation for USB Mass Storage devices
    Vendor: Sony      Model: MSC-U01N          Rev: 1.00
    Type:   Direct-Access                      ANSI SCSI revision: 02

But then any attempt to mount it or even 'dd if=/dev/sda' hangs 
forever, the only messages I have in kernel logs are below.

Is someone interesting in a more complete bug report or should I
test something else ?

Thanks,

Stelian.

-----------------8<---------------------------8<------------------
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: Sony      Model: MSC-U01N          Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
sda : READ CAPACITY failed.
sda : status=0, message=00, host=7, driver=00 
sda : sense not available. 
sda: test WP failed, assume Write Enabled
sda: asking for cache data failed
sda: assuming drive cache: write through
sda : READ CAPACITY failed.
sda : status=0, message=00, host=7, driver=00 
sda : sense not available. 
sda: test WP failed, assume Write Enabled
sda: asking for cache data failed
sda: assuming drive cache: write through
sda : READ CAPACITY failed.
sda : status=0, message=00, host=7, driver=00 
sda : sense not available. 
sda: test WP failed, assume Write Enabled
sda: asking for cache data failed
sda: assuming drive cache: write through
 sda:<3>Buffer I/O error on device sd(8,0), logical block 0
Buffer I/O error on device sd(8,0), logical block 0
 unable to read partition table
 sda:<3>Buffer I/O error on device sd(8,0), logical block 0
 unable to read partition table
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
sda : READ CAPACITY failed.
sda : status=0, message=00, host=7, driver=00 
sda : sense not available. 
sda: test WP failed, assume Write Enabled
sda: asking for cache data failed
sda: assuming drive cache: write through
sda : READ CAPACITY failed.
sda : status=0, message=00, host=7, driver=00 
sda : sense not available. 
sda: test WP failed, assume Write Enabled
sda: asking for cache data failed
sda: assuming drive cache: write through
 sda:<3>Buffer I/O error on device sd(8,0), logical block 0
Buffer I/O error on device sd(8,0), logical block 0
 unable to read partition table
sda : READ CAPACITY failed.
sda : status=0, message=00, host=7, driver=00 
sda : sense not available. 
sda: test WP failed, assume Write Enabled
sda: asking for cache data failed
sda: assuming drive cache: write through
sda : READ CAPACITY failed.
sda : status=0, message=00, host=7, driver=00 
sda : sense not available. 
sda: test WP failed, assume Write Enabled
sda: asking for cache data failed
sda: assuming drive cache: write through
 sda:<3>Buffer I/O error on device sd(8,0), logical block 0
Buffer I/O error on device sd(8,0), logical block 0
 unable to read partition table
sda : READ CAPACITY failed.
sda : status=0, message=00, host=7, driver=00 
sda : sense not available. 
sda: test WP failed, assume Write Enabled
sda: asking for cache data failed
sda: assuming drive cache: write through
sda : READ CAPACITY failed.
sda : status=0, message=00, host=7, driver=00 
sda : sense not available. 
sda: test WP failed, assume Write Enabled
sda: asking for cache data failed
sda: assuming drive cache: write through
 sda:<3>Buffer I/O error on device sd(8,0), logical block 0
Buffer I/O error on device sd(8,0), logical block 0
 unable to read partition table
sda : READ CAPACITY failed.
sda : status=0, message=00, host=7, driver=00 
sda : sense not available. 
sda: test WP failed, assume Write Enabled
sda: asking for cache data failed
sda: assuming drive cache: write through
sda : READ CAPACITY failed.
sda : status=0, message=00, host=7, driver=00 
sda : sense not available. 
sda: test WP failed, assume Write Enabled
sda: asking for cache data failed
sda: assuming drive cache: write through
 sda:<3>Buffer I/O error on device sd(8,0), logical block 0
Buffer I/O error on device sd(8,0), logical block 0
 unable to read partition table
sda : READ CAPACITY failed.
sda : status=0, message=00, host=7, driver=00 
sda : sense not available. 
sda: test WP failed, assume Write Enabled
sda: asking for cache data failed
sda: assuming drive cache: write through
-----------------8<---------------------------8<------------------
    
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
