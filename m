Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262618AbRFGNpt>; Thu, 7 Jun 2001 09:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262626AbRFGNpj>; Thu, 7 Jun 2001 09:45:39 -0400
Received: from [209.10.41.242] ([209.10.41.242]:22179 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262615AbRFGNpW>;
	Thu, 7 Jun 2001 09:45:22 -0400
Date: Thu, 7 Jun 2001 08:40:06 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200106071340.IAA59373@tomcat.admin.navo.hpc.mil>
To: bohdan@kivc.vstu.vinnica.ua,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: isolating process..
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> On Wed, Jun 06, 2001 at 09:57:25PM +0200, Erik Mouw wrote:
> 
> >> Is it possible by any means to isolate any given process, so that
> >> it'll be unable to crash system. 
> > You just gave a nice description what an OS kernel should do :)
> * Sigh * :-)
> 
> > > Please, supply ANY suggestions.
> > > 
> > > My ideas:
> > > 
> > > create some user, and decrease his ulimits up to miminum of 1 process,
> > > 0 core size, appropriate memory/ etc.
> > That's indeed the way to do it.
> Byt how should I restrict him open socket and send some data (my IP,
> for example) somewhere ??
> 
> I thinks I'll end up writing kernel module which will restrict all
> ioctls but few {mmap, brk, geteuid, geuid, etc..} for given UID.

You might look into the Linux Security Module project. It's not finished
but the hooks may give you what you need to start. See

	http://mail.wirex.com/mailman/listinfo/linux-security-module

BTW, it is not possible to gurantee the process can't crash the system
unless there are no other processes...

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
