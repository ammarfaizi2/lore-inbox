Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318733AbSHAMyu>; Thu, 1 Aug 2002 08:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318736AbSHAMyu>; Thu, 1 Aug 2002 08:54:50 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:51341 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318733AbSHAMyt>; Thu, 1 Aug 2002 08:54:49 -0400
Message-Id: <5.1.0.14.2.20020801134624.00aabec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 01 Aug 2002 14:02:00 +0100
To: Nico Schottelius <nico-mutt@schottelius.org>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: Bugs in 2.5.28 [scsi/framebuffer/devfs/floppy/ntfs/trident]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020801115047.GB1577@schottelius.org>
References: <5.1.0.14.2.20020730172158.02014160@pop.cus.cam.ac.uk>
 <20020731175743.GB1249@schottelius.org>
 <5.1.0.14.2.20020730172158.02014160@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:50 01/08/02, Nico Schottelius wrote:
>Anton Altaparmakov [Tue, Jul 30, 2002 at 05:28:05PM +0100]:
> > I am interested in this ntfs report. Which way round was the loopback 
> file?
> > I.e. did you mount: mount -t ntfs -o loop somefile_on_a_non_ntfs_partition
> > or did you mount: mount -t some_file_system -o loop
> > somefile_on_an_ntfs_partion?
>
>mount -t ntfs -o loop file.sav-on-ext2-or-on-xfs[when using 2.4.18] /mnt
>
> > Can you send me the errors produced? If there is an oops, please decode 
> and
> > send it, too.
>
>The test I did was the following [may I call that test ?]:
>
>cd /mnt; mkdir /ntfs_on_ext3; cp -r * /ntfs_on_ext3
>While copying, with or without debug, the system hangs, but top only reports
>7 % cpu load.
>
>Copying the files results in a input / output error.

Interesting.

>It has never been an oops and actually 2.5.29 does _not_ hangup anymore!
>Still it stops to copy the files and aborts.
>I am currently retrying with debug enabled...
>
> > Also it may be useful to have the debug output from ntfs (depending on 
> what
> > the errors/oops say - they may be sufficient to pinpoint the problem), 
> i.e.
> > enable debugging when configuring the kernel, and then as root do: echo 
> 1 >
> > /proc/sys/fs/ntfs-debug. Note this will absolutely flood you with debug
> > output so the system will run slow as hell... So it is best to only enable
> > debug messages just before the error occurs if that is possible.
>
>oops. forget that above. Oh yes, ntfs is really reporting much.
>You can find the output at ftp.schottelius.org:/pub/tmp, it's about
>600k compressed.

Where is it? It doesn't appear - I just looked...

>I am really happy that this time the cp did not hald my system!
>
>p.s.: what was the maximal file size on ext3 ? I just gunzipped a 4gb
>       file (the ntfs image the whole story is about), which could not
>       be transfered through scp/ftp in this size...

Sorry not sure. I think it is dependent on the fs block size you use...

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

