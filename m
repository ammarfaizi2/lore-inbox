Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272204AbRIEPwQ>; Wed, 5 Sep 2001 11:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272206AbRIEPv4>; Wed, 5 Sep 2001 11:51:56 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:62291 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S272204AbRIEPvw>; Wed, 5 Sep 2001 11:51:52 -0400
Date: Wed, 5 Sep 2001 10:51:55 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200109051551.KAA48912@tomcat.admin.navo.hpc.mil>
To: Florian.Weimer@RUS.Uni-Stuttgart.DE, Michael Bacarella <mbac@nyct.net>
Subject: Re: getpeereid() for Linux
Cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
> Michael Bacarella <mbac@nyct.net> writes:
> 
> > There's no need. The equivalent functionality can already be
> > implemented in userspace.
> 
> Well, it doesn't work with TCP.  Uh-oh, I see I forgot to mention the
> following: I need this functionality for local TCP connections, not
> just UNIX domain sockets.

It doesn't work on BSD either. The manpage says:
(http://www.openbsd.org/cgi-bin/man.cgi?query=getpeereid&sektion=2&apropos=0&mnpath=OpenBSD+Current)

     getpeereid() returns the effective user ID and group ID of the peer con-
     nected to the UNIX domain socket s.

     One common use is for UNIX domain servers to determine the credentials of
     clients that have connected to it.

It is not possible to get a creditential from TCP connections yet. That
requires an extension to IPSec to even be able to carry credentials. There
is no reliable communication path (even for identd) to be able to pass
credentials.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
