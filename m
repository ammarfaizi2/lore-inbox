Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261537AbSI0OA7>; Fri, 27 Sep 2002 10:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261698AbSI0OA7>; Fri, 27 Sep 2002 10:00:59 -0400
Received: from crack.them.org ([65.125.64.184]:64274 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S261537AbSI0OA6>;
	Fri, 27 Sep 2002 10:00:58 -0400
Date: Fri, 27 Sep 2002 10:05:43 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does kernel use system stdarg.h?
Message-ID: <20020927140543.GA5613@nevyn.them.org>
Mail-Followup-To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org
References: <200209270804.g8R84cp08026@Port.imtp.ilyichevsk.odessa.ua> <20020927092647.A7485@flint.arm.linux.org.uk> <200209271224.g8RCOLp09105@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209271224.g8RCOLp09105@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 03:18:35PM -0200, Denis Vlasenko wrote:
> Reading specs from /usr/lib/gcc-lib/i686-pc-linux-gnu/3.0.3/specs
> Configured with: ../gcc-3.0.3/configure --prefix=/usr/app/gcc-3.0.3posix --exec-prefix=/usr/app/gcc-3.0.3posix --bindir=/usr/app/gcc-3.0.3posix/bin --libdir=/usr/lib --infodir=/usr/app/gcc-3.0.3posix/info --mandir=/usr/app/gcc-3.0.3posix/man --with-slibdir=/usr/lib --with-local-prefix=/usr/local --with-gxx-include-dir=/usr/include/g++-v3 --enable-threads=posix
> Thread model: posix
> gcc version 3.0.3
>  /usr/lib/gcc-lib/i686-pc-linux-gnu/3.0.3/cpp0 -lang-c -nostdinc -v
>                                                        ^^^^^^^^^

That's not the problem.

> -I/usr/src/linux-2.5.36/include
> -iprefix /usr/sbin/../../lib/gcc-lib/i686-pc-linux-gnu/3.0.3/

That's the problem.  Where's the -iprefix coming from?   Your configure
doesn't specify /usr/sbin anywhere.

Verdict: bad GCC install or a 3.0.3 bug.  Might have to do with your
libdir-outside-of-prefix.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
