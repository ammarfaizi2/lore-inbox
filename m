Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSGLTYO>; Fri, 12 Jul 2002 15:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316794AbSGLTYO>; Fri, 12 Jul 2002 15:24:14 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:38109 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S314938AbSGLTYN>; Fri, 12 Jul 2002 15:24:13 -0400
Date: Fri, 12 Jul 2002 21:25:30 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207121925.g6CJPUjW018407@burner.fokus.gmd.de>
To: linux-kernel@vger.kernel.org
Subject: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H.P. Anvin wrote:

>Please consider deprecating or removing ide-floppy/ide-tape/ide-cdrom
>and treat all ATAPI devices as what they really are -- SCSI over IDE.
>It is a source of no ending confusion that a Linux system will not
>write CDs to an IDE CD-writer out of the box, for the simple reason
>that cdrecord needs access to the generic packet interface, which is
>only available in the nonstandard ide-scsi configuration.

Thank you for this thread!

libscg now has 5 different SCSI transport interface implementations
only for Linux.

There are still problems like e.g. USB which not really usable.

>There really seems to be no decent reason to treat ATAPI devices as
>anything else.  I understand the ide-* drivers contain some
>workarounds for specific devices, but those really should be moved to
>their respective SCSI drivers anyway -- after all, manufacturers
>readily slap IDE or SCSI interfaces on the same devices anyway.

>Note that this is specific to ATAPI devices.  ATA hard drives are
>another matter entirely.

A reasonable idea would be to make the ATA driver a SCSI HBAdriver and
in case that there is a need for pure ATA (e.g. Hard disks) there should
be a second interface for a ATA driver stack.

Please keep me on the CC: I am not on the list.



Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
