Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263754AbREYOSF>; Fri, 25 May 2001 10:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263758AbREYOR4>; Fri, 25 May 2001 10:17:56 -0400
Received: from gw-yyz.somanetworks.com ([216.126.67.39]:59853 "EHLO
	somanetworks.com") by vger.kernel.org with ESMTP id <S263754AbREYORp>;
	Fri, 25 May 2001 10:17:45 -0400
Date: Fri, 25 May 2001 10:17:44 -0400
From: Mark Frazer <mark@somanetworks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Big-ish SCSI disks
Message-ID: <20010525101744.C32217@somanetworks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0105250015550.15333-100000@godzilla.spiteful.org> <20010525062236.8CC1837530@zapff.research.canon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010525062236.8CC1837530@zapff.research.canon.com.au>; from gjohnson@research.canon.com.au on Fri, May 25, 2001 at 04:22:36PM +1000
Organization: Detectable, well, not really
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Johnson <gjohnson@research.canon.com.au> [01/05/25 08:51]:
> Have you experienced any issues like this?
> Have you successfuly built a kernel that booted on these machines?

I'm also a user of the machine Scott mentioned.  We're booting it off
of a smaller scsi disk, not the 76G disks.

The disks are partitioned as
[mjfrazer@pyle mjfrazer]$ cat /proc/partitions 
major minor  #blocks  name     rio rmerge rsect ruse wio wmerge wsect wuse running use aveq

   8     0    8969493 sda      381817 450620 6656780 2095010 544380 197071 5968764 25617960 0 3648250 27741440
   8     1      40131 sda1     68 382 900 680 58 23 164 5210 0 5780 5890
   8     2          1 sda2     1 0 2 0 0 0 0 0 0 0 0
   8     5    6835626 sda5     378536 446124 6597282 2077550 543908 194587 5945600 25601060 0 3635020 27707080
   8     6    2088418 sda6     3211 4114 58594 16790 414 2461 23000 11750 0 17190 28540
   8    16   71687369 sdb      5644131 6544183 97506292 29459090 4734971 25903242 245412336 901326350 0 38801430 931623210
   8    17   71681998 sdb1     5644130 6544183 97506290 29459520 4734971 25903242 245412336 901326750 0 38801290 931623950
   8    32   71687369 sdc      5647535 6545287 97542738 29398000 4707634 25931186 245412336 931729050 0 39181580 962005610
   8    33   71681998 sdc1     5647534 6545287 97542736 29398380 4707634 25931186 245412336 931729530 0 39181540 962005420
   9     0   71681920 md0      0 0 0 0 0 0 0 0 0 0 0
[mjfrazer@pyle mjfrazer]$ 

-mark

> Quoth Scott Murray:
> > 
> > I set up a machine at work a few months ago with two Seagate 73GB
> > Ultra160 drives (model ST173404LW) using the Adaptec AIC-7899 adapter
> > on board a ServerWorks LE chipset based motherboard.  Everything has
> > been working fine using the stock RedHat 7.0 2.2.16-22smp kernel.  I
> > also played with some 2.4.1-ac kernels to try out ReiserFS, and also
> > had no problems using the disks.
