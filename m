Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132013AbRAQK5g>; Wed, 17 Jan 2001 05:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132886AbRAQK50>; Wed, 17 Jan 2001 05:57:26 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:37392 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S132013AbRAQK5L>;
	Wed, 17 Jan 2001 05:57:11 -0500
Date: Wed, 17 Jan 2001 11:56:53 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Linux not adhering to BIOS Drive boot order?
To: "Matthew D. Pitts" <mpitts@suite224.net>
Cc: linux-kernel@vger.kernel.org
Message-id: <3A657A75.A7345720@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew D. Pitts (mpitts@suite224.net) wrote :

> Guys,    
>             
> > And this is a problem that has plagues all PC operating systems, but has never    
> > been a problem on the Macintosh. Why? Because the Mac was designed to handle        
> > this problem, but the PC never was. 
>                       
> Quite true on this point.

Amiga handles it too.
             
> > The Mac never enumerates its devices like the PC does (no C: D: etc, no 
> > /dev/sda, /dev/sdb, or anything like that). It also remembers the boot device           
> > in its EEPROM (the Startup Disk Control Panel handles this). 
>    
> For ATA drives the bios handles this.

No it doesn't. Put your root-fs on hda6 ( not unusual in dual boot
setups ),
delete hda5, watch your linux fail to boot.
( the kernel will be loaded , but it won't find the root-fs , because it
looks
in hda6 , but the partition has "migrated" to hda5 )

>    
> > The only way to solve this problem is the DESIGN IT INTO THE OS! Someone needs  
> > to stand up and say, "This is a problem, and I'm going to fix it." There needs
-------------------------^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Amen to that !

> > to be a "device mount order database" or some kind, and all the disk drivers
> > need to access that database to determine where to put the devices it finds.                   
>           
> NO! What needs to happen is:
> 1) the person who installs a second scsi card should read the manual BEFORE
> installing it so they know how to disable the boot features if they aren't
> needed,

This won't fix the "kernel doesn't find root-fs" problem.

>      
> or
>      
> 2) install only one bootable scsi card, period.

Same ( or similar ) problem as before ...
      
>  Anything else is a useless kludge that will come back and bite us in the
>  ass.

Kludges are bad, unfortunately that is all we have currently :-(

>             
> > The only problem is BIOS boot. That information is, I believe, stored in the
> > ESCD, but I don't know if it's reliable enough and complete enough to be usable
> > by Linux.   
>    
> It seems to work well enough.

For the "load the kernel" part.
Most of the times.

>    
> Matthew D. Pitts
> mpitts@suite224.net
>    

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
