Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263857AbTETSP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 14:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbTETSP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 14:15:29 -0400
Received: from alpham.uni-mb.si ([164.8.1.101]:39678 "EHLO alpham.uni-mb.si")
	by vger.kernel.org with ESMTP id S263857AbTETSP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 14:15:27 -0400
Date: Tue, 20 May 2003 20:27:55 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Wrong clock initialization
To: george anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3ECA73AB.FBC470DB@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=iso-8859-2
Content-transfer-encoding: 7BIT
X-Accept-Language: en
References: <3ECA673F.7B3FB388@uni-mb.si> <3ECA6F83.5090706@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> David Balazic wrote:
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
> During shut down my system "says" it is setting the CMOS clock from
> the kernel clock.  I would expect this to correct the problem.  Is
> this a distro thing?

The time is properly converted first to be localtime, if your CMOS
is localtime. So this does not fix anything.

> 
> In any case, this would seem to make the problem go away after the
> first shutdown (if you don't dual boot with something other than Linux :).


-- 
David Balazic
--------------
"Be excellent to each other." - Bill S. Preston, Esq., & "Ted" Theodore
Logan
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- - -
