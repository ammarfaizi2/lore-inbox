Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266384AbTATSFb>; Mon, 20 Jan 2003 13:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266425AbTATSFb>; Mon, 20 Jan 2003 13:05:31 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1165 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266384AbTATSFa> convert rfc822-to-8bit; Mon, 20 Jan 2003 13:05:30 -0500
Date: Mon, 20 Jan 2003 13:16:59 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Bernd Petrovitsch <bernd@gams.at>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: egcs (or compatible) compiler 
In-Reply-To: <4846.1043085902@frodo.gams.co.at>
Message-ID: <Pine.LNX.3.95.1030120131037.30930A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2003, Bernd Petrovitsch wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> >I tried to find the "latest and greatest" gcc compiler that
> >will compile the kernel. I can't find the source anywhere!
> 
> As another one mentioned : http://gcc.gnu.org/
> 
> >Apparently, gnu doesn't "do" the compiler anymore, it's now
> >called egcs and is supposed to be on goof.com according to
> 
> This was true 2.5 years ago (when RedHat-6.2 was new). gcc 
> development/maintenance was somewhat down so the FSF handed gcc 
> maintainance over to the pgcc people.
> 
> >the links from the GCC home page. They only have patches.
> >The last source-code I have been able to find for gcc is
> >gcc-3.0.1.tar.gz and it won't even compile under egcs-2.9.1.66
> 
> gcc-3.2.1 is there: http://gcc.gnu.org/gcc-3.2/
> 
> >(which I installed about a year ago before it became unavailable
> >and dissappeared).
> >
> >So, what gives? Any hints on how I get the source of the most
> >recommended gcc, that will actually compile on a previous version
> 
> It depends - gcc-3.2 needs/wants glibc-2.2.90 and some folks on lkml 
> use it (so I assume - at least for x86 - gcc-3.2 works).
> "Officially" recommende ist gcc-2.95.3 and 2.95.4 AFAIK.
> 
> >of gcc? I'm presently using egcs-2.9.1.66, but newer kernels won't
> >compile using it. They fail to link with "__rawmemchr" errors, i.e.,
> 
> I use gcc-2.95.4 on almost-stock RedHat-6.2 (which has a glibc-2.1.3)
> built from a src.rpm to be found on http://rpmfind.net - depends how
> you want to build/install the gcc.
> 
> 	Bernd
> -- 
> Bernd Petrovitsch                              Email : bernd@gams.at
> g.a.m.s gmbh                                  Fax : +43 1 205255-900
> Prinz-Eugen-Straße 8                    A-1040 Vienna/Austria/Europe
>                      LUGA : http://www.luga.at 

Okay. Thanks everyone. I found it. Aparently something was "down"
this morning when I was trying to get the sources off from gnu.
I just downloaded gcc-2.3

However, it has the same problem. It won't compile with the egcs-2.91.66
version installed here. 

	c-parse.o c-lang.o attribs.o c-errors.o c-lex.o c-pragma.o c-decl.o c-typeck.o c-convert.o c-aux-info.o c-common.o c-format.o c-semantics.o c-objc-common.o libcpp.a  main.o libbackend.a   ../libiberty/libiberty.a
libbackend.a(dwarf2out.o): In function `output_die':
/usr/src/gcc-3.2/gcc/dwarf2out.c:6283: undefined reference to `__rawmemchr'
libbackend.a(stmt.o): In function `resolve_operand_name_1':
/usr/src/gcc-3.2/gcc/stmt.c:2145: undefined reference to `__rawmemchr'
/usr/src/gcc-3.2/gcc/stmt.c:2180: undefined reference to `__rawmemchr'
collect2: ld returned 1 exit status
make[1]: *** [cc1] Error 1
make[1]: Leaving directory `/usr/src/gcc-3.2/gcc'
make: *** [all-gcc] Error 2


This comes from using strchr(s, 0), to find the end of a string! I can't
find anything about '__rawmemchr()' so I don't know how to make one.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


