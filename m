Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135228AbRDRRj6>; Wed, 18 Apr 2001 13:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135229AbRDRRjr>; Wed, 18 Apr 2001 13:39:47 -0400
Received: from AGrenoble-101-1-1-84.abo.wanadoo.fr ([193.251.23.84]:21742 "EHLO
	lyon.ram.loc") by vger.kernel.org with ESMTP id <S135228AbRDRRjj>;
	Wed, 18 Apr 2001 13:39:39 -0400
To: linux-kernel@vger.kernel.org
From: ram@ram.fr.eu.org (Raphael Manfredi)
Subject: 2.4.3-ac4: Problem accessing SCSI CDROM, ok with IDE
Date: 18 Apr 2001 17:39:30 GMT
Organization: Home, Grenoble, France
Message-ID: <9bkjgi$fav$1@lyon.ram.loc>
X-Newsreader: trn 4.0-test74 (May 26, 2000)
X-Mailer: newsgate 1.0 at lyon.ram.loc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have trouble accessing a CD-ROM via my SCSI Plextor CD, connected
to a Tekram DC390 (AM53C974 driver).

When I try to mount it, I get this error:

	mount: wrong fs type, bad option, bad superblock on /dev/scd0,
		   or too many mounted file systems

and in the logs:

	VFS: Disk change detected on device sr(11,0)
	attempt to access beyond end of device
	0b:00: rw=0, want=688290, limit=203728
	isofs_read_super: bread failed, dev=0b:00, iso_blknum=344144, block=344144

When I do the SAME mount on my IDE CD, same machine, it works, and the logs
say:

	VFS: Disk change detected on device ide0(3,64)
	scanning for RockRidge behind XA attribute
	last message repeated 38 times

and I can then access the CD-ROM.

This is a picture CD-ROM burned by a shop in France (FNAC, in case there
are other french readers).

With VMWare running on the same machine, when I connect the IDE CD-ROM to
the virtual machine, I can read the CD, but partially.  Some directories
are missing.  So the CD-ROM is not "clean" -- I suspect the session is not
closed.

What troubles me is the different behaviour between the SCSI CD-ROM and the
IDE one.  Any explaination?

Raphael
