Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280607AbRKBJBN>; Fri, 2 Nov 2001 04:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280610AbRKBJBE>; Fri, 2 Nov 2001 04:01:04 -0500
Received: from ns.caldera.de ([212.34.180.1]:52897 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S280611AbRKBJAu>;
	Fri, 2 Nov 2001 04:00:50 -0500
Date: Fri, 2 Nov 2001 09:59:34 +0100
Message-Id: <200111020859.fA28xY530514@ns.caldera.de>
From: hch@caldera.de (Christoph Hellwig)
To: kaboom@gatech.edu (Chris Ricker)
Cc: Danek Duvall <duvall@emufarm.org>,
        World Domination Now! <linux-kernel@vger.kernel.org>,
        Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: Code from ~2.4.4 going into Solaris 9 Alpha?
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.LNX.4.33.0111011423510.20119-100000@verdande.oobleck.net>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0111011423510.20119-100000@verdande.oobleck.net> you wrote:
> Solaris 9/ia32 includes software called lxrun (actually slip-streamed during
> Solaris 8, as Sun is so fond of doing for some brain-dead reason) which
> implements the Linux/ia32 ABI on Solaris/ia32.  It's much like the Linux
> compatibility layer all the *BSDs have these days.

Lxrun is rather different than the BSD's linux emulation layer.

Whilst the BSD's intercept linux syscalls at kernel level, lxrun gets
the int80 syscalls dispatched back to userspace.

It was originally developed by Mike Davidson at SCO (now Caldera) and
for OpenServer and UnixWare, it is distributed under a Mozilla-style
license.

Note that lxrun has a lot of problems with more advanced linux binaries
and thus has been replaced by a kernel-level emulation in OpenUnix8, the
successor to UnixWare.

So all in all Sun is reusing old technology here 8)

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
