Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262616AbSI0VmW>; Fri, 27 Sep 2002 17:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262619AbSI0VmV>; Fri, 27 Sep 2002 17:42:21 -0400
Received: from waste.org ([209.173.204.2]:58341 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262616AbSI0VmV>;
	Fri, 27 Sep 2002 17:42:21 -0400
Date: Fri, 27 Sep 2002 16:47:22 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Daniel Jacobowitz <dan@debian.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: Does kernel use system stdarg.h?
Message-ID: <20020927214721.GK21969@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020927140543.GA5613@nevyn.them.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 10:05:43AM -0400, Daniel Jacobowitz wrote:
> On Fri, Sep 27, 2002 at 03:18:35PM -0200, Denis Vlasenko wrote:
> > Reading specs from /usr/lib/gcc-lib/i686-pc-linux-gnu/3.0.3/specs
> > Configured with: ../gcc-3.0.3/configure --prefix=/usr/app/gcc-3.0.3posix --exec-prefix=/usr/app/gcc-3.0.3posix --bindir=/usr/app/gcc-3.0.3posix/bin --libdir=/usr/lib --infodir=/usr/app/gcc-3.0.3posix/info --mandir=/usr/app/gcc-3.0.3posix/man --with-slibdir=/usr/lib --with-local-prefix=/usr/local --with-gxx-include-dir=/usr/include/g++-v3 --enable-threads=posix
> > Thread model: posix
> > gcc version 3.0.3
> >  /usr/lib/gcc-lib/i686-pc-linux-gnu/3.0.3/cpp0 -lang-c -nostdinc -v
> >                                                        ^^^^^^^^^
> 
> That's not the problem.
> 
> > -I/usr/src/linux-2.5.36/include
> > -iprefix /usr/sbin/../../lib/gcc-lib/i686-pc-linux-gnu/3.0.3/
> 
> That's the problem.  Where's the -iprefix coming from?   Your configure
> doesn't specify /usr/sbin anywhere.
> 
> Verdict: bad GCC install or a 3.0.3 bug.  Might have to do with your
> libdir-outside-of-prefix.

I've got the same problem with -nostdinc with my Debian gcc-3.0 that
I've been patching around. I assumed it was a problem with the
kernel's Makefile, now you're saying it's the Debian package?

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
