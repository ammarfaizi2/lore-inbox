Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbTLWQUN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbTLWQUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:20:13 -0500
Received: from cibs9.sns.it ([192.167.206.29]:2575 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S261909AbTLWQSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:18:17 -0500
Date: Tue, 23 Dec 2003 17:15:16 +0100 (CET)
From: venom@sns.it
To: "Giacomo A. Catenazzi" <cate@pixelized.ch>
cc: Linus Torvalds <torvalds@osdl.org>,
       "Giacomo A. Catenazzi" <cate@debian.org>,
       Florian Weimer <fw@deneb.enyo.de>, jw schultz <jw@pegasys.ws>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: SCO's infringing files list
In-Reply-To: <3FE862E7.1@pixelized.ch>
Message-ID: <Pine.LNX.4.43.0312231712190.637-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


checked libc4 a.out and libc5, it seems it does not come from them....

Luigi


On Tue, 23 Dec 2003, Giacomo A. Catenazzi wrote:

> Date: Tue, 23 Dec 2003 16:44:39 +0100
> From: Giacomo A. Catenazzi <cate@pixelized.ch>
> To: Linus Torvalds <torvalds@osdl.org>
> Cc: Giacomo A. Catenazzi <cate@debian.org>, Florian Weimer <fw@deneb.enyo.de>,
>      jw schultz <jw@pegasys.ws>,
>      "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
>      Eric S. Raymond <esr@thyrsus.com>
> Subject: Re: SCO's infringing files list
>
>
>
> Linus Torvalds wrote:
> > On Tue, 23 Dec 2003, Giacomo A. Catenazzi wrote:
>
> >>In
> >>http://www.opensource.apple.com/darwinsource/DevToolsMay2002/gcc-937.2/libiberty/strerror.c
> >>
> >>/* Extended support for using errno values.
> >>    Written by Fred Fish.  fnf@cygnus.com
> >>    This file is in the public domain.  --Per Bothner.  */
> >>(...)
> >>#if defined (ENOTTY)
> >>   ENTRY(ENOTTY, "ENOTTY", "Not a typewriter"),
> >>#endif
> >
> >
> > Something like that may well be the source of the string. Fred Fish was
> > active long before this timeframe (if it's the same Fred Fish - he used to
> > do freeware collections for the Amiga in the '80's).
> >
> > But there were multiple libc's around (estdio, libc5, glibc..), and it
> > could be any of them.
> >
> > Trying to find the kernel list archives from that timeframe would likely
> > clarify the issue. There were several lists back then: "linux-activists"
> > mailing list, and of course the "comp.os.linux" newsgroup (this was before
> > it split into multiple newsgroups).
> >
> > I've found some archives for linux-activists, but no newsgroup archives
> > going that far back.. Anybody?
>
> I found only a mail in linux-activists: It say """
> 4. lots of stuffs added to errno.h and string/errlist.c.
> """
> It seems that the new errno.h is added in libc, but there are some
> references of kernel and the post date is in the same weeks of the new
> kernel errno.h, so possibly the linux errno.h is based uppon this library.
> Maybe someone of the "old" guys will understand something better about
> this post.
>
> ciao
> 	giacomo
>
>
>
> From: hlu@yoda.eecs.wsu.edu (H.J. Lu)
> Subject: Re: gcc-2.2.2 patches for linux?
> Date: 19 Jul 92 15:42:48 GMT
>
> In article <54473@mentor.cc.purdue.edu> wilker@hopf.math.purdue.edu
> (Clarence Wilkers
> on) writes:
>  >I'd like to do cross compilation for linux on a sparc. Has anyone set this
>  >up?
>  >--
>
>
> Please read all the previous release notes and docs. This release note
> only covers the new stuffs.
>
> This is gcc 2.2.2 for Linux. It is on banjo.concert.net under
> /pub/Linux/GCC. Gcc 2.3 will support Linux, according to RMS. The FSF
> has all the files Linux needs.
>
> Please get the new binutils.tar.Z, which fixed some bugs in as and a
> gprof with some patches from Rick Sladkey at jrs@world.std.com, if
> you haven't got it.
>
> I added some jumptable stubs to gcc. But I don't have the time to
> implement it. In the future, you can use jump table with -jump in
> CFLAGS.
>
> Libg++.a is 2.2 beta.
>
> This gcc will produce binaries only run safely under 0.96a patch level
> 4 or above.
>
> The list of known bugs.
>
> 1. one 'cmp' in dbz test fails. Per is not planning on doing anything
>     about it. your contribution is welcome.
>
> The following bugs in libc.a are fixed.
>
> 1. hard and soft math libs are fixed. some of functions are totally
>     rewritten.
> 2. acosh, asinh and atanh are added to libsoft.a and math.h.
> 3. open a file for read and write, then do fseek followed by fwrite
>     works now.
> 4. now random () and srandom () are renamed to __random () and
>     __srandom (), respectively.
> 5. the header files taken from glibc.a are fixed.
> 6. the sys call mount now takes 4 args.
> 7. getpagesize and getdtablesize work now.
> 8. netdb.h, resolv.h, sys/uio.h, netinet.h, arpa/inet.h and
>     arpa/nameser.h are changed.
> 9. Some function declarations are added to sys/socket.h in
>     0.96bp2inc.tar.Z.
>
> The following functions are added to libc.a.
>
> 1. profil.
> 2. libg.a is there.
> 3. getdtablesize.
> 4. lots of stuffs added to errno.h and string/errlist.c.
> 5. some changes in string/siglist.c.
> 6. dtoa.
> 7. there is a new strtod, please check it out.
> 8. drem.
> 9. the inet library functions are in libinet.a. They are untested. Once
>     they are tested ok, they will be moved to libc.a. All the inet
>     library functions are there, except for res_xxxx, rcmd, rexec and
>     ruserpass, which require more kernel support, like F_SETOWN, FASYNC,
>     and a few network system calls.
>
>     There should also be a set of files in /etc for inet functions. I
>     hope Ross will provide them.
>
> In this release, there is a libc_p.a compiled with "-pg" for profiling.
>
> You should use "-g" for debugging and "-pg/-p" for profiling in CFLAGS
> when you compile the source code.
>
>
> There must be a few other bugs. Please let me know if you find any.
>
> File list:
>
> 1. 2.2.2db.tar.Z (cpp, libg.a and libc_p.a)
> 2. 2.2.2lib.tar.Z (cc1, cc1plus)
> 3. 2.2.2misc.tar.Z (header files, drivers, libs, doc, ....)
> 4. shlib-2.2.2.tar.Z (making the shared libs for gcc 2.2.2)
> 5. libc-2.2.2.tar.Z (source code for the libs)
> 6. gcc-2.2.2.tar.Z (patches for compiling gcc 2.2.2)
> 7. 0.96bp2inc.tar.Z (the kernel header files for 0.96b patch level 2)
>
> H.J.
> hlu@eecs.wsu.edu
> 06/27/92
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

