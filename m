Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318327AbSG3QVN>; Tue, 30 Jul 2002 12:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318328AbSG3QVN>; Tue, 30 Jul 2002 12:21:13 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:8425 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318327AbSG3QVM>; Tue, 30 Jul 2002 12:21:12 -0400
Message-Id: <5.1.0.14.2.20020730172158.02014160@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 30 Jul 2002 17:28:05 +0100
To: Nico Schottelius <nico-mutt@schottelius.org>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: Bugs in 2.5.28 [scsi/framebuffer/devfs/floppy/ntfs/trident]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020731175743.GB1249@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:57 31/07/02, Nico Schottelius wrote:
>Just wanted to report of the following problems:
>
>Other bugs:
>- ntfs sometimes crashes the system: working on a loopback file caused
>   ntfs to report corruptions in the file system and this hangs system
>   completly.
>
>If you need more informations, just tell me. Currently I've some time
>to debug parts of the kernel.

I am interested in this ntfs report. Which way round was the loopback file? 
I.e. did you mount: mount -t ntfs -o loop somefile_on_a_non_ntfs_partition 
or did you mount: mount -t some_file_system -o loop 
somefile_on_an_ntfs_partion?

Can you send me the errors produced? If there is an oops, please decode and 
send it, too.

Also it may be useful to have the debug output from ntfs (depending on what 
the errors/oops say - they may be sufficient to pinpoint the problem), i.e. 
enable debugging when configuring the kernel, and then as root do: echo 1 > 
/proc/sys/fs/ntfs-debug. Note this will absolutely flood you with debug 
output so the system will run slow as hell... So it is best to only enable 
debug messages just before the error occurs if that is possible.

Thanks,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

