Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbSJWCOQ>; Tue, 22 Oct 2002 22:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262702AbSJWCOQ>; Tue, 22 Oct 2002 22:14:16 -0400
Received: from funkie.transmit.com ([204.69.232.71]:56337 "EHLO
	funkie.transmit.com") by vger.kernel.org with ESMTP
	id <S262394AbSJWCOQ>; Tue, 22 Oct 2002 22:14:16 -0400
Message-Id: <5.1.0.14.0.20021022190139.0375b698@mail.toolfoundry.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 22 Oct 2002 19:17:41 -0700
To: linux-kernel@vger.kernel.org
From: Ethan Joffe <ethan@toolfoundry.com>
Subject: 2.4.19 unresolved symbols
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a dual P3 box with 2Gigs RAM booting off onboard scsi, and I am 
unable to get the latest v2.4.19 kernel to support the hardware fully. I 
can get the kernel working if I do not have it configured for 4G support, 
in which case it only sees 900Megs or so of RAM, but everything works and 
boots properly.
When I config for 4Gig however, the system fails to boot, giving a bunch of 
errors like the following:

/lib/ext3.0: unresolved symbol highmem_start_page
/lib/ext3.0: unresolved symbol journal_blocks_per_page_Rsmp_6082191c
/lib/ext3.0: unresolved symbol kmap_high
/lib/ext3.0: unresolved symbol journal_forget_Rsmp_678417a8
...
ERROR: /bin/insmod exited abnormally

I have compiled from scratch multiple times using make menuconfig, from 
freshly untarred sources just downloaded from kernel.org .
All of the system.map and initrd type stuff is setup properly in the boot 
dir by the 2.4.19 make files.

To restate the situation... if I boot from floppy and build the kernel with 
4G support it does not work, then if I reboot from floppy and flip 4G 
support off and rebuild, everything works fine except only 900Megs seen.

I am configuring to boot from onboard scsi (module sym53c8xx) , so maybe it 
is related to that and/or smp support?

Any idea what this means and how I can go about getting this fixed?

Thanks
Ethan

