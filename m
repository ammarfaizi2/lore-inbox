Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312716AbSCVPdq>; Fri, 22 Mar 2002 10:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312718AbSCVPdh>; Fri, 22 Mar 2002 10:33:37 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:12156 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S312716AbSCVPd3>; Fri, 22 Mar 2002 10:33:29 -0500
Date: Fri, 22 Mar 2002 09:33:28 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200203221533.JAA31035@tomcat.admin.navo.hpc.mil>
To: mikesw@ns1.whiterose.net, linux-kernel@vger.kernel.org
Subject: Re: USB MSDOS driver for Hard drive to boot UMSDOS?
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------
M Sweger <mikesw@ns1.whiterose.net>:
> 
> 
> Hello,
> 
> I have a Dell optiplex GX1 333mhz with MSDOS 6.22 installed in one partion
> with the rest being NT.  I also have UMSDOS in one of the hard drive
> partitions. I would like to move the UMSDOS linux from the IDE/SCSI hard
> drive to an external USB hard drive. After moving it to the external
> drive, I want to boot the UMSDOS linux from the external USB hard drive.
> However, since I don't have any USB drivers for either of the controllers
> which seem to be *.sys the system doesn't know to create and assign a disk
> drive letter to the attached external drive.
> 
> I know there is a company that makes "USB4DOS" at http://www.catc.com but
> most of these companies are geared to embedded systems. Their price is
> $1k US for this driver. I haven't been able to find any USB driver for
> MSDOS that is free. Nor a driver that is generic enough to be used with
> any USB device whether it be v1.1 and/or v2.0 USB in an intel system.
> 
> Is there any USB MSDOS drivers that I can use so that I can boot and run
> linux off my external USB hard drive?
> 
> 
> I realize a work around is to use a linux boot floppy and mount the other
> filesystems via the Linux USB driver to access my UMSDOS linux
> system. However, everytime I change the kernel it requires making another
> linux boot disk. :(

None to my knowlege - it requires the USB to be configured by the BIOS
and to be able to load from the USB by the BIOS.

Your best bet is to put a small (1-5 M) partition on an IDE disk and make
that partition bootable. Initialize it as /boot, and have the initrd image
mount the root from the USB. Mount the boot partition as /boot. That way
any kernel changes you make will be recorded in the boot partition.

You might need to use the boot floppy once to initialize the boot partition
but after that you shouldn't have any trouble.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
