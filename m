Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288649AbSADOhF>; Fri, 4 Jan 2002 09:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288648AbSADOg4>; Fri, 4 Jan 2002 09:36:56 -0500
Received: from mail.zmailer.org ([194.252.70.162]:29824 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S288647AbSADOgs>;
	Fri, 4 Jan 2002 09:36:48 -0500
Date: Fri, 4 Jan 2002 16:36:35 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: 2.4.17 RAID-1 EXT3  reliable to hang....
Message-ID: <20020104163635.A1268@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For past few weeks I have wondered of why my web-server machine
is hanging semi-regularly.

I have:
  - Two 30+ GB SCSI Ultra2-Wide disks
  - onboard AIC7XXX controller
  - Disks with identical partition maps
  - RAID-1 bound pairwise on those partitions
    (RAIDTAB entries md3/md4/md5 - the md0/md1/md2 were on
     other older disk, which was removed latter..)
  - EXT3 filesystem at all partitions (except at 2 G swap..)
    Mounted with default options
  - machine with dual-P-III 750 MHz, and 786 MB memory (3*256MB)

When the machine is up all the way, and MD disks have finished
syncing, I execute command:

  dd if=/dev/zero bs=1024k of=test.file count=8000

which will lead to hard system hangup where the keyboard won't
react, SCSI led shines constantly, but nothig happens.
Right at the moment when the keyboard becomes unresponsibe,
the disk led will continue to flicker for a few seconds, but
then the flicker will stop, and the led stays constantly on.

Earlier guestimates of using "noapic", have no effect on
system hangups.  Same command causes it quite soon. Even
"noapic nosmp" does hang.

Large amount of RAM may contribute, but this 3*256MB
does not need e.g. PAE mode extensions.

/Matti Aarnio
