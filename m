Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317059AbSGNUMD>; Sun, 14 Jul 2002 16:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317063AbSGNUMC>; Sun, 14 Jul 2002 16:12:02 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:19956 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S317059AbSGNUMB>; Sun, 14 Jul 2002 16:12:01 -0400
Date: Sun, 14 Jul 2002 22:13:19 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207142013.g6EKDJb5019442@burner.fokus.gmd.de>
To: Richard.Zidlicky@stud.informatik.uni-erlangen.de, schilling@fokus.gmd.de
Cc: andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Richard Zidlicky <Richard.Zidlicky@stud.informatik.uni-erlangen.de>

> 
>> For a starter, it is easier to understand the SCSI concept of
>> addressing than to understand the Linux concept. In addition,
>> the SCSI addressing concept can be used on different platforms
>> in a unique way. This helps people (and GUI writers) to use 
>> cdrecord on more than Linux only.

>whether it is easier is matter of taste, however in a situation
>where the kernel and 99% of other applications refer to something
>as '/dev/scd0' I fail to see any benefit of having another scheme.
>Do you want to suggest that all other Linux apps should now use
>'-dev x,y,z' instead of normal device names?

Did I request this? No, definitely not. Hoewver, it helps a lot
if a GUI for cdrecord may use cdrecord to find potential drives
and if there is a unique addressing scheme.

BTW: did you ever look at Solaris / HP-UX, ... and the way they
name disks?

someting like: /dev/{r}dsk/c0t0d0s0

This is SCSI bus, target, lun and slice.

>There is another problem, with your scsi transport library you
>are bypassing normal Linux devices. Try
>  mount /dev/scd0 /mnt
>  cdrecord -dev 0,0,0 -blank=fast
>  ls -al /mnt

>Nice? It certainly isn't the fault of Linux if you choose to
>bypass normal device usage and it can be very annoying not
>only for beginners.

It is not a fault of cdrecord either.


Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
