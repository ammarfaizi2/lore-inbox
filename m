Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316835AbSF0NKa>; Thu, 27 Jun 2002 09:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316843AbSF0NK3>; Thu, 27 Jun 2002 09:10:29 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:16916 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S316835AbSF0NK2>; Thu, 27 Jun 2002 09:10:28 -0400
Date: Thu, 27 Jun 2002 08:10:30 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200206271310.IAA61740@tomcat.admin.navo.hpc.mil>
To: Gregoryg@ParadigmGeo.com,
       "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: Multiple profiles
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> >I wonder if somebody is familiar with the way to create 
> >multiple hardware configurations (profiles) on Linux? 
> 
> Sorry for not being clear enough. I got several replies saying that this is
> not a kernel list question, I suppose because of the example with the
> network. In reality, this problem is much broader...
> 
> One might think of external devices (tapes, scaners, disks, etc.) constanly
> being moved from machine to machine. I understand I can twist /etc/init.d/*
> to support all the configurations. However, I don't see a reason why it
> cannot be the responsibility of Linux kernel to "see" different hardware
> configurations on boot.

Now you got specific.

Most tapes/scanners/disks that are removable/detachable are using the USB.

If that is the case, then yes - they can be handled automatically.

You do have to setup the USB daemon and drivers. Once configured they should
be connected automatically. Depending on the type of disk (hard disk,
filesystem type, access authorizations) you run into additional complications.

Not everything SHOULD be automatically done. For instance - overriding
authorizations on a disk drive can allow a workstation user to violate the
security policy established for the disk drive. The same can be said for
a tape or floppy. Such policies are NOT implementable inside the kernel
(at least not portably).

This is one reason an automatic mount is not necessarily valid. That policy
cannot be supported (or even identified) by the kernel.

Scanners and printers however, are more policy neutral - they don't inherently
store data that is policy controlled. At least not in the US. These devices
are usually immediately available after connection. (Though I'm still working
on getting my HP G55 scanner/printer working - it is recognized by the USB
subsystem as soon as it is attached).

I believe in other countries scanners are required to be able to label the data
being scanned and/or printed to identify the source of the data (doesn't prevent
tampering, but it is still a policy).

> >From the replies I got, I understand that Linux kernel doesn't provide such
> functionality. That's all I wanted to know.


-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
