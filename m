Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317849AbSGPO1f>; Tue, 16 Jul 2002 10:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317853AbSGPO1e>; Tue, 16 Jul 2002 10:27:34 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:8175 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S317849AbSGPO1d>; Tue, 16 Jul 2002 10:27:33 -0400
From: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
Date: Tue, 16 Jul 2002 16:30:24 +0200 (MEST)
Message-Id: <200207161430.QAA04409@faui02b.informatik.uni-erlangen.de>
To: schilling@fokus.gmd.de
Subject: Re: IDE/ATAPI in 2.5
Cc: andersen@codepoet.org, linux-kernel@vger.kernel.org
X-Sun-Charset: US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> >Solaris vold? Thanks no, floppy access was so easy in SunOS before the 
> >days of the volume manager.
> 
> .... and it is even simpler since vold is present. Call volcheck to tell vold
> that the media changed or use a SCSI floppy which supports to tell the kernel
> that a media change did happen.

when it is properly configured which doesn't seem the common case.
More often than not, things like accessing raw floppy images turn
out to be a problem.

> >> -	The volume manager should have a documented interface that allows 
> >> 	programs like e.g. cdrecord to gain exclusive access to a CD drive.
> 
> >much simpler, cdrom driver needs an ioctl to claim exclusive use of
> >the device and cdrecord than needs to use that ioctl.
> 
> This will not work. What should happen when the drive is mounted?

block or return -EBUSY.

Richard
