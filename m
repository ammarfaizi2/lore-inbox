Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289815AbSAWMR3>; Wed, 23 Jan 2002 07:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289825AbSAWMRT>; Wed, 23 Jan 2002 07:17:19 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:40199 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S289815AbSAWMRG>; Wed, 23 Jan 2002 07:17:06 -0500
Message-ID: <3C4EA9AC.4D61831D@aitel.hist.no>
Date: Wed, 23 Jan 2002 13:16:44 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.2-dj2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5 oopses when dealing with bad blocks on scsi disk
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of my scsi disks has got some bad blocks.  
Accessing them (via ext2 on top of raid-0) usually results
in a wait and a io error. 

badblocks and e2fsck -l 
runs fine, but e2fsck -c causes oopses and
sometimes ends up shutting the disk down.  I've been unable
to capture any oops so far due to the several pages 
of output that follows.

This happens with 2.5.2dj2 (with ALSA).  Other
2.5 kernels I have also struggle with this.
Accessing the bad blocks through ext2 does not
update the bad block inode, I thought it should.

I plan on moving data to another disk and
replace the faulty one later.  I can run experiments
on the bad one if the fs/driver people here
wants more information.

The disks are 2 quantum atlas IV, connected to
a tekram adapter using the SYM53C8XX v. 2 driver.
Both disks have several partitions, some used
in raid-0.  

Helge Hafting
