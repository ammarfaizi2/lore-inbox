Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSGPKqj>; Tue, 16 Jul 2002 06:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSGPKqi>; Tue, 16 Jul 2002 06:46:38 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:49349 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S314078AbSGPKqi>; Tue, 16 Jul 2002 06:46:38 -0400
Date: Tue, 16 Jul 2002 12:47:56 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207161047.g6GAluni021252@burner.fokus.gmd.de>
To: Richard.Zidlicky@stud.informatik.uni-erlangen.de, schilling@fokus.gmd.de
Cc: andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From rdzidlic@faui02.informatik.uni-erlangen.de Tue Jul 16 12:37:56 2002

>> >The potential for breakage is huge, people run automounters on CD's,
>> >file managers may try to mount the CD without asking the user.
>> 
>> The bad news is that it seems that the automounters are part of the GUIs and 
>> not well enough documented. There should be:
>> 
>> -	Something like the Solaris volume manager that is part of the base OS 
>> 	and kernel folks should forbid GUI folks to add such tasks to the GUI

>Solaris vold? Thanks no, floppy access was so easy in SunOS before the 
>days of the volume manager.

.... and it is even simpler since vold is present. Call volcheck to tell vold
that the media changed or use a SCSI floppy which supports to tell the kernel
that a media change did happen.

>> -	The volume manager should have a documented interface that allows 
>> 	programs like e.g. cdrecord to gain exclusive access to a CD drive.

>much simpler, cdrom driver needs an ioctl to claim exclusive use of
>the device and cdrecord than needs to use that ioctl.

This will not work. What should happen when the drive is mounted?


Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
