Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263862AbTETSNd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 14:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbTETSNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 14:13:33 -0400
Received: from alpham.uni-mb.si ([164.8.1.101]:34302 "EHLO alpham.uni-mb.si")
	by vger.kernel.org with ESMTP id S263862AbTETSNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 14:13:30 -0400
Date: Tue, 20 May 2003 20:26:04 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Wrong clock initialization
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Message-id: <3ECA733C.F31F1388@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=iso-8859-2
Content-transfer-encoding: 7BIT
X-Accept-Language: en
References: <3ECA673F.7B3FB388@uni-mb.si>
 <200305202018.16062.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Tuesday 20 May 2003 19:34, David Balazic wrote:
> > Hi!
> >
> > When the kernel is booted ( ia32 version at least ) , it reads
> > the time from from the hardware CMOS clock , _assumes_ it is in
> > UTC and set the system time to it.
> >
> > As almost nobody runs their clock in UTC, this means that the system
> > is running on wrong time until some userspace tool corrects it.
> >
> > This can lead to situtation when time goes backwards :
> >
> > timezone is 2hours east of UTC.
> > UTC time : 20:00
> > local time : 22:00
> >
> > System time between boot and userspace fix : 22:00UTC
> > System time after fix : 20:00UTC
> >
> > Comments ?
> 
> Why don't you simply set your CMOS clock to UTC?

Because certain other operating systems that expect localtime
would then have problems.


--------------
"Be excellent to each other." - Bill S. Preston, Esq., & "Ted" Theodore
Logan
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- - -
