Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUHSIi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUHSIi5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 04:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUHSIi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 04:38:56 -0400
Received: from chico.rediris.es ([130.206.1.3]:21934 "EHLO chico.rediris.es")
	by vger.kernel.org with ESMTP id S263806AbUHSIiy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 04:38:54 -0400
From: David =?iso-8859-1?q?Mart=EDnez_Moreno?= <ender@debian.org>
Organization: Debian
To: Nathan Scott <nathans@sgi.com>
Subject: Re: Crashes and lockups in XFS filesystem (2.6.8-rc4).
Date: Thu, 19 Aug 2004 10:39:26 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200408181816.57940.ender@debian.org> <20040819084410.GA14750@frodo>
In-Reply-To: <20040819084410.GA14750@frodo>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200408191039.27724.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

El Jueves, 19 de Agosto de 2004 10:44, Nathan Scott escribió:
> On Wed, Aug 18, 2004 at 06:16:57PM +0200, David Martinez Moreno wrote:
> > 	Hello, I am getting persistent lockups that could be IMHO XFS-related. I
> > created a fresh XFS filesystem in a SCSI disk, with xfsprogs version
> > 2.6.18.
> >
> > 	Mounted /dev/sda1 under /mnt, after that, I have been copying lots of
> > files from /dev/md0, then run a find blabla -exec rm \{\} \; over /mnt
> > and then voilà! the lockup:
>
> Did /mnt run out of space while doing that?  Or nearly?  There's
> a known issue with that area of the XFS code, in conjunction with
> 4K stacks at the moment - was that enabled in your .config?
>
> Looks like something stamped on parts of the xfs_mount structure
> for the filesystem mounted at /mnt, a stack overrun would explain
> that and your subsequent oopsen.

	Hello, Nathan, many thanks for the reply.

	The machine locked up last night again, so I cannot login, and I cannot 
manage to remember if I enabled 4K stacks in the code, could be possible, but 
I am not sure.

	What I am sure of is that /mnt was plenty (8-10 GB or so) of disk space. I 
had two or three concurrent accesses, IIRC, some of them writing from the 
RAID to the SCSI (both using XFS), and the last one finding and removing 
unwanted packages.

	Could this scenario give you some hints? I will return where the server is in 
5 hours, and I will send to the list the .config.

	Again, many thanks,


		Ender.
- -- 
Prepare ship for ludicrous speed! Fasten all seatbelts, seal all
 entrances and exits, close all shops in the mall, cancel the three
 ring circus, secure all animals in the zoo!
		-- Colonel Sandurz (Spaceballs).
- --
Servicios de red - Network services
RedIRIS - Spanish Academic Network for Research and Development
Red.es - Madrid (Spain)
Tlf (+34) 91.212.76.25
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBJGc/Ws/EhA1iABsRAqYVAKDPWUIi6m5pBH3nwbgHttV9ko436ACfYDbp
F+SsCIE95BvW9m7YMbg/yc8=
=MHxU
-----END PGP SIGNATURE-----
