Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAPRFA>; Tue, 16 Jan 2001 12:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129831AbRAPREv>; Tue, 16 Jan 2001 12:04:51 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:45061 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S129383AbRAPREj>;
	Tue, 16 Jan 2001 12:04:39 -0500
Date: Tue, 16 Jan 2001 18:04:02 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Linux not adhering to BIOS Drive boot order?
To: linux-kernel@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>
Message-id: <3A647F02.CB628D13@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
Content-type: text/plain; charset=iso-8859-2
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote :
> Venkateshr@ami.com said:
> > we need some kind of signature being written in the drive, which the 
> > kernel will use for determining the boot drive and later re-order 
> > drives, if required.  
>      
> > Is someone handling this already? 
>     
> It should be possible to read the BIOS setting for this option and
> behave accordingly. Please give full details of how to read and interpret
> the information stored in the CMOS for all versions of AMI BIOS, and I'll
> take a look at this.

To mount the right partitions , refer to the by the volume label or
UUID.
( read the mount and fstab man pages for more info )

This work after the root-fs is already mounted.

Currently ( AFAIK ) the root-fs can be specified only as a major:minor
pair ( and maybe also as a "/dev/hdxx" string )

Once I wrote a patch that allows specifying the root-fs by
UUID or volume label. It is available at
http://linux-patches.rock-projects.com/v2.2-f/uuid.html

It is for 2.2.x kernel , since nobody seems to be interested in it.


As for the "device nodes are assigned to disk devices almost randomly"
problem : I complained about this years ago , but nothing happened.

If someone knows a way to reliably find a certain partition ,
regardless of the (non)existence and position of other partitions
and disks in the system , short of scanning the contents of all
available
partitions , please tell me.


Party on !
-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
