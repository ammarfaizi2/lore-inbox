Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318344AbSHEIy5>; Mon, 5 Aug 2002 04:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318345AbSHEIy5>; Mon, 5 Aug 2002 04:54:57 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:21740 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318344AbSHEIy4>; Mon, 5 Aug 2002 04:54:56 -0400
Message-Id: <5.1.0.14.2.20020805095452.0469cc40@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 05 Aug 2002 09:58:53 +0100
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
> > At 18:57 31/07/02, Nico Schottelius wrote:
> > >Just wanted to report of the following problems:
> > >
> > >Other bugs:
> > >- ntfs sometimes crashes the system: working on a loopback file caused
> > >  ntfs to report corruptions in the file system and this hangs system
> > >  completly.

I don't think the hangs had anything to do with ntfs. The io errors, I was 
able to reproduce on 2.4.19+ntfs but only when accessing compressed files. 
I have fixed this in the latest ntfs, at least the errors I saw are gone.

Could you give it a try and let me know if it solves your problem, too?

You can download by pulling from bk://linux-ntfs.bkbits.net/ntfs-tng-2.5 or 
by applying the patch I sent to LKML last night. I can forward it to you if 
you need it...

btw. I think it was compiler problem, so out of interest, which compiler 
are you using? I was using gcc-2.96-RH7.3-latest...

Thanks,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

