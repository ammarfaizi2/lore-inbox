Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317471AbSGONF6>; Mon, 15 Jul 2002 09:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317472AbSGONF5>; Mon, 15 Jul 2002 09:05:57 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:33499 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S317471AbSGONF4>; Mon, 15 Jul 2002 09:05:56 -0400
Date: Mon, 15 Jul 2002 15:07:13 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207151307.g6FD7DJ1020676@burner.fokus.gmd.de>
To: Richard.Zidlicky@stud.informatik.uni-erlangen.de, schilling@fokus.gmd.de
Cc: andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Richard Zidlicky <Richard.Zidlicky@stud.informatik.uni-erlangen.de>

>> >There is another problem, with your scsi transport library you
>> >are bypassing normal Linux devices. Try
>> >  mount /dev/scd0 /mnt
>> >  cdrecord -dev 0,0,0 -blank=fast
>> >  ls -al /mnt
>> 
>> >Nice? It certainly isn't the fault of Linux if you choose to
>> >bypass normal device usage and it can be very annoying not
>> >only for beginners.
>> 
>> It is not a fault of cdrecord either.

>A cure would be nice and I don't see what the kernel could do
>to solve this problem as long as cdrecord insists on talking
>to the SCSI bus directly.

>If nothing else, cdrecord manpage
> - should make a big fat warning about it
> - should stop claiming that it is safe to suid cdrecord

>The potential for breakage is huge, people run automounters on CD's,
>file managers may try to mount the CD without asking the user.

The bad news is that it seems that the automounters are part of the GUIs and 
not well enough documented. There should be:

-	Something like the Solaris volume manager that is part of the base OS 
	and kernel folks should forbid GUI folks to add such tasks to the GUI

-	The volume manager should have a documented interface that allows 
	programs like e.g. cdrecord to gain exclusive access to a CD drive.

Then the problem above could be solved.


Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
