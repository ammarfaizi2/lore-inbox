Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316746AbSGLTfp>; Fri, 12 Jul 2002 15:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316795AbSGLTfo>; Fri, 12 Jul 2002 15:35:44 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:24291 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S316746AbSGLTfn>; Fri, 12 Jul 2002 15:35:43 -0400
Date: Fri, 12 Jul 2002 21:37:01 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207121937.g6CJb1aq018419@burner.fokus.gmd.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Alan Cox wrote:

>> Please consider deprecating or removing ide-floppy/ide-tape/ide-cdrom
>> and treat all ATAPI devices as what they really are -- SCSI over IDE.

>They aren't.

Please don't start again to tell onprooven statements....
We had a similar discussion in January 2001 and you did not give a proove
for this statement.


>o       Not all ide cdrom devices are ATAPI capable

Name one drive made after 1993, one drive made after 1995 and one drive made 
after 2000 to verify your statement.

>o       Many ide floppy devices can do ATAPI but get it horribly wrong

Describe the problems.

>o       ide-tape is -totally- weird and unrelated to st

Describe problems and name drives that will not work via ATAPI.

>Andre did the framework ready to move to a situation where you could open
>either the ide-scsi or the ide-cdrom name without module reloading mess.
>You'd need to ask our new 2.5 IDE maintainer to finish that work off.

This is a really bad idea!

The result of such bad hacks is that nobody really tests whether the new
code works.

Let me give an example:

If you try to put ide-scsi on top of PCATA (the interface that is used
in notebooks to connect external disks and CD-writers).

Depending on the kernel version, this either causes a system panic or
just does not work at all. As all ATAPI CD-writers and CD-rom drives
have a fallback to ATA commands, nobody who does not like to use a writer
will ever notice the problem. They simply access the CD-ROM as read only
ATA disk. If ide-cd would have been banned this bug would have been fixed years 
ago.

>For disk it gets much easier. Linus has already said he wants a single
>'disk' device, which once we get 32bit dev_t will be nice. With that we
>can finally turn aacraid, megaraid and other 'fake scsi' devices back to
>raw block devices without breaking compatibility assumptions, and get more
>throughput.


Sorry, this has nothing to do with dev_t

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
