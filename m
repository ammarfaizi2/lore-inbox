Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262778AbSI1KyS>; Sat, 28 Sep 2002 06:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262779AbSI1KyR>; Sat, 28 Sep 2002 06:54:17 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:23312 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S262778AbSI1KyQ>; Sat, 28 Sep 2002 06:54:16 -0400
Date: Sat, 28 Sep 2002 12:59:11 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Oliver Xymoron <oxymoron@waste.org>, Daniel Jacobowitz <dan@debian.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: Does kernel use system stdarg.h?
Message-ID: <20020928105911.GU27082@louise.pinerecords.com>
References: <20020927140543.GA5613@nevyn.them.org> <20020927214721.GK21969@waste.org> <20020928091530.B32639@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020928091530.B32639@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > -I/usr/src/linux-2.5.36/include
> > > > -iprefix /usr/sbin/../../lib/gcc-lib/i686-pc-linux-gnu/3.0.3/
> > > 
> > > That's the problem.  Where's the -iprefix coming from?   Your configure
> > > doesn't specify /usr/sbin anywhere.
> > > 
> > > Verdict: bad GCC install or a 3.0.3 bug.  Might have to do with your
> > > libdir-outside-of-prefix.
> > 
> > I've got the same problem with -nostdinc with my Debian gcc-3.0 that
> > I've been patching around. I assumed it was a problem with the
> > kernel's Makefile, now you're saying it's the Debian package?
> 
> It certainly looks like it.  gcc 3.0.3 appears to ignore
> "-iwithprefix include", where as gcc 2.95.x, 2.96, 3.1 and 3.2 all
> work as expected.

No.  Try building/installing gcc-3.2 with '--prefix=/usr/gcc-3.2'
and '--prefix=/usr'.  The former won't work with '-iwithprefix include',
the latter will.  GCC build bug?

T.
