Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267286AbSLRSDZ>; Wed, 18 Dec 2002 13:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267287AbSLRSDZ>; Wed, 18 Dec 2002 13:03:25 -0500
Received: from mrelay1.cc.umr.edu ([131.151.1.120]:56497 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id <S267286AbSLRSCz> convert rfc822-to-8bit;
	Wed, 18 Dec 2002 13:02:55 -0500
Date: Wed, 18 Dec 2002 12:10:54 -0600
From: Nathan Neulinger <nneul@umr.edu>
To: linux-kernel@vger.kernel.org
Cc: uetrecht@umr.edu
Subject: 3ware driver in 2.4.x and 2.5.x not compatible with 6x00 series cards
Message-ID: <20021218181052.GA26465@umr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to 3Ware, the driver in the 2.4.x and (I assume) 2.5.x is no
longer compatible with the 6xxx series cards. 

I was instructed in the below conversation (3ware contact name has been
removed) that anyone using 6xxx cards would need to downgrade to the
.016 version of the driver. This means that a single kernel build can
no longer function on multiple machines, you have to have a special build
for machines using the 6xxx card, and a different build for 7/8xxxx.

At the very least, a warning should be placed in the driver source/Configure
help noting this incompatibility. 

As this is something with a significant safety impact (in our case, I believe it
may have been responsible for some filesystem corruption in addition to all of
the system hangs), the driver in the distribute kernel should probably refuse to
attach to a 6xxx card if it is known to be incompatible.

I don't know what we'll do with this situation when we move to 2.6, cause
right now, it looks like we are completely screwed. The old driver 
obviously will not compile on 2.6 since the API's have changed. 

We have around 30 machines with 7xxx cards, and another 15 or so with 6xxx cards.
I'd hate to think of how many other people have purchased 6xxx cards and will
not be able to upgrade to newer distributions or to 2.6 without buying new hardware.

-- Nathan

------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-4841
Computing Services                       Fax: (573) 341-4216





We provide the source for both 2.4.x and 2.2.x with v16 so users can
recompile 
against any kernels. 



-----Original Message-----
From: Neulinger, Nathan [mailto:nneul@umr.edu]
Sent: Wednesday, December 18, 2002 9:45 AM
Subject: RE: 3ware logs


This isn't something you intend to fix? What happens when someone with a
6xxx card wants to put in a new kernel and the old version of the driver
doesn't compile with the new kernel?

I could understand if the driver weren't included in the standard kernel
source, but it is, and from what you're saying it is incompatible with 6xxx.
That will put anyone who wants to upgrade their O/S in a very bad spot,
especially when the kernel is already built with support with the built-in
driver. 

-- Nathan

------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-4841
Computing Services                       Fax: (573) 341-4216


> -----Original Message-----
> Sent: Wednesday, December 18, 2002 11:44 AM
> To: Neulinger, Nathan
> Subject: RE: 3ware logs
> 
> 
> you need to use driver v16 for firmware release 6.9 because 
> newer drivers
> for the 
> 7xxx and 8xxx series in part of firmware changes etc....in 
> some cases, it
> may
> work but most won't 
> 
> 
> -----Original Message-----
> From: Neulinger, Nathan [mailto:nneul@umr.edu]
> Sent: Wednesday, December 18, 2002 9:39 AM
> Subject: RE: 3ware logs
> 
> 
> This appears to get rid of the symptom on this machine. Do 
> you have some
> idea of when the bug was introduced, or what is wrong with the current
> driver? I'd hate to have to build a special kernel with a 
> downgraded driver
> for any of my machines running w/ 6xxx boards. 
> 
> -- Nathan
> 
> ------------------------------------------------------------
> Nathan Neulinger                       EMail:  nneul@umr.edu
> University of Missouri - Rolla         Phone: (573) 341-4841
> Computing Services                       Fax: (573) 341-4216
> 
> 
> > -----Original Message-----
> > From: Neulinger, Nathan 
> > Sent: Wednesday, December 18, 2002 11:22 AM
> > Subject: RE: 3ware logs
> > 
> > 
> > Is that code still compile compatible with current kernels? I 
> > cannot downgrade the kernel to anything prior to 2.4.20-pre7 
> > due to other dependencies, but if it's compile compatible I 
> > can replace the 3w-xxxx.c file in the kernel and recompile. 
> > 
> > -- Nathan
> > 
> > ------------------------------------------------------------
> > Nathan Neulinger                       EMail:  nneul@umr.edu
> > University of Missouri - Rolla         Phone: (573) 341-4841
> > Computing Services                       Fax: (573) 341-4216
> > 
> > 
> > > -----Original Message-----
> > > Sent: Wednesday, December 18, 2002 11:18 AM
> > > To: Neulinger, Nathan
> > > Subject: RE: 3ware logs
> > > 
> > > 
> > > can you please downgrade the driver to v16 which was the last 
> > > release for
> > > the 6xxx
> > > series cards ? Thanks 
> > > http://www.3ware.com/support/download.asp?code=3&id=6.9&softty
> > > pe=Driver
> > > 
> > > 
> > > 
> > > -----Original Message-----
> > > From: Neulinger, Nathan [mailto:nneul@umr.edu]
> > > Sent: Wednesday, December 18, 2002 8:50 AM
> > > Subject: RE: 3ware logs
> > > 
> > > 
> > > We're just going to try replacing the card, as I can't leave 
> > > this server
> > > hanging every few minutes. Got anything else you want me 
> to look at?
> > > 
> > > -- Nathan
> > > 
> > > ------------------------------------------------------------
> > > Nathan Neulinger                       EMail:  nneul@umr.edu
> > > University of Missouri - Rolla         Phone: (573) 341-4841
> > > Computing Services                       Fax: (573) 341-4216
> > > 
> > > 
> > > > -----Original Message-----
> > > > Sent: Tuesday, December 17, 2002 5:55 PM
> > > > To: Neulinger, Nathan
> > > > Subject: RE: 3ware logs
> > > > 
> > > > 
> > > > does it go away if you update it driver v31 which the 
> > > latest driver ? 
> > > > 
> > > > 
> > > > -----Original Message-----
> > > > From: Nathan Neulinger [mailto:nneul@umr.edu]
> > > > Sent: Tuesday, December 17, 2002 3:42 PM
> > > > Subject: RE: 3ware logs
> > > > 
> > > > 
> > > > I had recently updated this card to a freshly download 
> most recent
> > > > firmware. 6.9 I think. Symptom did not change. 
> > > > 
> > > > -- Nathan
> > > > 
> > > > > which version of the driver ? output of :
> > > > > cat /proc/scsi/3w-xxxx/0
> > > > > 
> > > > > 
> > > > > 
> > > > > -----Original Message-----
> > > > > From: Nathan Neulinger [mailto:nneul@umr.edu]
> > > > > Sent: Tuesday, December 17, 2002 3:33 PM
> > > > > Subject: Re: 3ware logs
> > > > > 
> > > > > 
> > > > > > Can you please send the 3dm logs (details page, error 
> > > > log) and kernel
> > > > > > logs if they
> > > > > > are available ?  Thanks
> > > > > 
> > > > > There are no relevant events in 3dm. (Nothing related, 
> > just a few
> > > > > scattered unrelated power resets / rebuilds.)
> > > > > 
> > > > > 
> > > > > Kernel logs look basically all the same:
> > > > > 
> > > > > Dec 17 03:28:06 sysinst kernel: 3w-xxxx: Unknown ioctl 0x46.
> > > > > Dec 17 03:30:56 sysinst kernel: 3w-xxxx: Unknown ioctl 0x46.
> > > > > Dec 17 03:31:34 sysinst kernel: 3w-xxxx: scsi0: Unit 
> #0: Command
> > > > > (0xdfeb4400) timed out, resetting card.
> > > > > Dec 17 03:31:34 sysinst kernel: 3w-xxxx: Unknown ioctl 0x46.
> > > > > Dec 17 03:32:02 sysinst kernel: 3w-xxxx: Unknown ioctl 0x46.
> > > > > Dec 17 03:32:30 sysinst kernel: 3w-xxxx: Unknown ioctl 0x46.
> > > > > Dec 17 03:33:07 sysinst kernel: 3w-xxxx: scsi0: Unit 
> #0: Command
> > > > > (0xdfeb4400) timed out, resetting card.
> > > > > Dec 17 03:33:07 sysinst kernel: 3w-xxxx: Unknown ioctl 0x46.
> > > > > Dec 17 03:33:34 sysinst kernel: 3w-xxxx: Unknown ioctl 0x46.
> > > > > Dec 17 03:35:17 sysinst kernel: 3w-xxxx: scsi0: Unit 
> #0: Command
> > > > > (0xdfeb4400) timed out, resetting card.
> > > > > Dec 17 03:36:19 sysinst kernel: 3w-xxxx: Unknown ioctl 0x46.
> > > > > Dec 17 03:39:42 sysinst kernel: 3w-xxxx: scsi0: Unit 
> #0: Command
> > > > > (0xdfeb4400) timed out, resetting card.
> > > > > Dec 17 03:39:43 sysinst kernel: 3w-xxxx: Unknown ioctl 0x46.
> > > > > Dec 17 03:40:19 sysinst kernel: 3w-xxxx: Unknown ioctl 0x46.
> > > > > Dec 17 03:40:20 sysinst kernel: 3w-xxxx: scsi0: Unit 
> #0: Command
> > > > > (0xdfeb9000) timed out, resetting card.
> > > > > Dec 17 03:41:01 sysinst kernel: 3w-xxxx: scsi0: Unit 
> #0: Command
> > > > > (0xdfeb4400) timed out, resetting card.
> > > > > Dec 17 03:42:18 sysinst kernel: 3w-xxxx: Unknown ioctl 0x46.
> > > > > Dec 17 03:42:45 sysinst kernel: 3w-xxxx: Unknown ioctl 0x46.
> > > > > Dec 17 03:43:33 sysinst kernel: 3w-xxxx: scsi0: Unit 
> #0: Command
> > > > > (0xdfeb4800) timed out, resetting card.
> > > > > Dec 17 03:44:28 sysinst kernel: 3w-xxxx: Unknown ioctl 0x46.
> > > > > Dec 17 03:46:10 sysinst kernel: 3w-xxxx: scsi0: Unit 
> #0: Command
> > > > > (0xdfeb4600) timed out, resetting card.
> > > > > 
> > > > > 
> > > > > 
> > > > > I've got those going back quite a while, but the content is 
> > > > essentially
> > > > > the same, only thing that changes is the command tag.
> > > > > 
> > > > > 
> > > > > Generally, it starts to occur whenever I do much heavy disk 
> > > > activity.
> > > > > 
> > > > > On the other machines, with the 7400's, I don't see this 
> > > > behavior, I get
> > > > > a random command timed out, but I've only seen a few of 
> > > > those (under 10
> > > > > total, and never repeatedly like this one).
> > > > > 
> > > > > 
> > > > > I have not tried intentionally breaking the mirror and 
> > > seeing if the
> > > > > symptom goes away. 
> > > > > 
> > > > > 
> > > > > Controller SCSI ID: 0 
> > > > > Monitor version:
> > > > > ME6X 1.01.00.028
> > > > > Firmware version:
> > > > > FE6X 1.02.28.053
> > > > > BIOS version:
> > > > > BE6X 1.07.02.005
> > > > > PCB version:
> > > > > Rev2
> > > > > Achip version:
> > > > > V4.40
> > > > > Pchip version:
> > > > > V5.70
> > > > > Model:
> > > > > 6200
> > > > > Serial number:
> > > > > Unknown
> > > > > Unit count:
> > > > > 1
> > > > > Unit 0
> > > > > Status:
> > > > > OK
> > > > > Capacity:
> > > > > 27.22 GB (53174992 blocks)
> > > > > Write Cache:
> > > > > In Use
> > > > > Configuration:
> > > > > Mirror (RAID 1)
> > > > > Subunit count:
> > > > > 2
> > > > >  
> > > > > 
> > > > > Subunit 0
> > > > > Logical drive
> > > > > status:
> > > > > OK
> > > > > Configuration:
> > > > > RAID Disk
> > > > > Physical drive
> > > > > number:
> > > > > 0
> > > > > Logical drive
> > > > > number:
> > > > > 0
> > > > > Subunit 1
> > > > > Logical drive
> > > > > status:
> > > > > OK
> > > > > Configuration:
> > > > > RAID Disk
> > > > > Physical drive
> > > > > number:
> > > > > 1
> > > > > Logical drive
> > > > > number:
> > > > > 1
> > > > > Drive count: 2
> > > > > Port 0
> > > > > Status:
> > > > > OK
> > > > > Capacity:
> > > > > 27.22 GB (53177040
> > > > > blocks)
> > > > > Model:
> > > > > Maxtor 92720U8 
> > > > > Serial number:
> > > > > C804MYKC 
> > > > > Unit number:
> > > > > 0
> > > > > Drive Firmware:
> > > > > Ðj+b
> > > > > Port 1
> > > > > Status:
> > > > > OK
> > > > > Capacity:
> > > > > 27.22 GB (53177040
> > > > > blocks)
> > > > > Model:
> > > > > Maxtor 92720U8 
> > > > > Serial number:
> > > > > C804HKTC 
> > > > > Unit number:
> > > > > 0
> > > > > Drive Firmware:
> > > > > Ðj+b
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > -- 
> > > > 
> > > > ------------------------------------------------------------
> > > > Nathan Neulinger                       EMail:  nneul@umr.edu
> > > > University of Missouri - Rolla         Phone: (573) 341-4841
> > > > Computing Services                       Fax: (573) 341-4216
> > > > 
> > > 
> > 
> 

