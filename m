Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316797AbSGNORX>; Sun, 14 Jul 2002 10:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316836AbSGNORW>; Sun, 14 Jul 2002 10:17:22 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:30870 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S316797AbSGNORU>; Sun, 14 Jul 2002 10:17:20 -0400
Date: Sun, 14 Jul 2002 16:18:37 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207141418.g6EEIbJp019125@burner.fokus.gmd.de>
To: andersen@codepoet.org, schilling@fokus.gmd.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From andersen@codepoet.org Sat Jul 13 07:40:59 2002

>> If you force cdrecord to rely on CD-ROM only interfaces, you make Linux
>> unusable in general. Do you really like to create an unusable Linux just
>> to avoid creating a usable generic SCSI transport interface?

>Lets step back a moment here.  The cdrecord package is not
>responsible for making "Linux usable in general".  It is
>responsible for writing data to CD-ROMs.  It is _not_ responsible
>for driving scanners, hard drives, or enforcing policy on the
>Linux kernel.

It looks like you miss important issues. 

-	More and more people like to use CD writers in their PC.

-	There are no new "SCSI"  (which rather means SCSI with 
	1984 transport layer) drives on the market. However,
	once you have a devent SCSI transport abstraction layer
	as I have in libscg, there is no difference in the high
	level code.

-	While it has been quite simple to add a SCSI CD writer
	to a PC and it is still simple on platforms that treat
	ATAPI ad SCSI over IDE, it is a big problem for novices
	to make a ATAPI CD writer work on Linux.

-	The people who have these sort of problems are those people
	who are new to Linux and who believe that Linux is unusable
	after they get those problems.

>If you would throw away crdrecord's desire to do its own private
>SCSI bus scanning, and throw away your attachment to addressing
>devices only by host, channel, id, and lun a number of things

It looks that you miss to understand what cdrecord does!
Cdrecord in special and libscg in general definitely does not
scan the bus. This is done by the kernel.

Cdrecord only tries to find all devices that already have been
found by the kernel.

>happen.  For starters, Linux devices don't have to be forced to
>all be sitting on the SCSI bus.  You could use standard Linux
>device names (i.e. /dev/hdc or /dev/scd0).  And you could still
>send all the SCSI/ATAPI packet commands you want to the device
>that was selected  using the CDROM_SEND_PACKET ioctl.

For a starter, it is easier to understand the SCSI concept of
addressing than to understand the Linux concept. In addition,
the SCSI addressing concept can be used on different platforms
in a unique way. This helps people (and GUI writers) to use 
cdrecord on more than Linux only.

>Ever look at the CDROM_SEND_PACKET ioctl?

I did, but you obviously did not :-(

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
