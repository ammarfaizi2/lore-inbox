Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130330AbRARQ4k>; Thu, 18 Jan 2001 11:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131202AbRARQ4a>; Thu, 18 Jan 2001 11:56:30 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:12037 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S132530AbRARQ4N>;
	Thu, 18 Jan 2001 11:56:13 -0500
Date: Thu, 18 Jan 2001 17:55:49 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Linux not adhering to BIOS Drive boot order?
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>
Message-id: <3A672015.B69F7E90@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
Content-type: text/plain; charset=iso-8859-2
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio (matti.aarnio@zmailer.org) wrote :

>   On Wed, Jan 17, 2001 at 08:22:22PM +0100, Werner Almesberger wrote:
>    > The only cases when you really need to know the name of a disk is when 
>    > - doing disk-level management, e.g. partitioning or creating file   
>    > systems (*) 
>    > - adding a swap partition (sigh) 
>    > - telling your boot loader where to put its boot sector 
>        
>      2.4.0 with devfs mounted at boot time into /dev/
> 
>      Only thing missing is that here /dev/scsi/host0/ propably should be
>      a symlink to something like /dev/bus/pci/BB/II.F ...
>      Or perhaps /dev/scsi/BUS/BB/II.F/busN/targetT/lunL/partP
>      but mixing in ISA-bus controllers is somewhat tough..
> 
>    $ mount
>    /dev/scsi/host0/bus0/target0/lun0/part3 on / type ext2 (rw)
>    /dev/scsi/host0/bus0/target2/lun0/part2 on /home type ext2 (rw)
>    /dev/scsi/host0/bus0/target0/lun0/part4 on /usr type ext2 (rw)
>    /dev/scsi/host0/bus0/target2/lun0/part1 on /usr/src type ext2 (rw)
>    /dev/scsi/host0/bus0/target0/lun0/part1 on /boot type ext2 (rw)
>     I do, of course, use mounting with LABEL=
>                             
>      This new style (which contains, hopefully, physical PCI location)
>      mount device paths will failry easily handle question about which
>      is where... And the partitions are PHYSICAL partition numbers,
>      not some logical ones. That is true with /dev/sdXP case as well
>      as with /dev/hdXP case.

What is the difference between physical and logical partitions ?
How does this solve the "I deleted hda5 and now the old hda6 became
hda5"
problem ?

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
