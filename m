Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbUATSnf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 13:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265692AbUATSnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 13:43:35 -0500
Received: from forrest.tmctechnologies.com ([65.163.174.229]:35855 "EHLO
	forrest.tmctechnologies.com") by vger.kernel.org with ESMTP
	id S265691AbUATSn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 13:43:29 -0500
Subject: Re: Compiling C++ kernel module + Makefile
From: Thomas Lahoda <tlahoda@tmctechnologies.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0401201306030.12044@chaos>
References: <20040116210924.61545.qmail@web12008.mail.yahoo.com> 
	<Pine.LNX.4.53.0401161659470.31455@chaos> 
	<200401171359.20381.bart@samwel.tk>
	<Pine.LNX.4.53.0401190839310.6496@chaos> <400C1682.2090207@samwel.tk> 
	<Pine.LNX.4.53.0401191311250.8046@chaos> <400C37E3.5020802@samwel.tk> 
	<Pine.LNX.4.53.0401191521400.8389@chaos> <400C4B17.3000003@samwel.tk> 
	<Pine.LNX.4.53.0401201000490.11497@chaos>
	<1074620079.22023.26.camel@localhost.localdomain> 
	<Pine.LNX.4.53.0401201306030.12044@chaos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 20 Jan 2004 13:38:10 +0000
Message-Id: <1074605893.1066.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-OriginalArrivalTime: 20 Jan 2004 18:45:13.0748 (UTC) FILETIME=[8A1FA540:01C3DF85]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not that I'm calling for the use of c++ in a kernel, but if you're going
to argue against it you should get your c++ example correct. You are
erroneously using fstream to get your cout. In c++, cout is an ostream
object. With the above correction compiled using g++ 3.3.2 I get the
following:

-rwxrwxr-x    1 tlahoda  tlahoda      3820 Jan 20 13:27 hello+
-rwxrwxr-x    1 tlahoda  tlahoda      2760 Jan 20 13:30 helloc





On Tue, 2004-01-20 at 18:10, Richard B. Johnson wrote:
> On Tue, 20 Jan 2004, Zan Lynx wrote:
> 
> > On Tue, 2004-01-20 at 08:20, Richard B. Johnson wrote:
> > > Nevertheless, I provide three programs, one written in
> > > C, the other in C++ and the third in assembly. A tar.gz
> > > file is attached for those interested.
> > >
> > > -rwxr-xr-x   1 root     root        57800 Jan 20 10:16 hello+
> > > -rwxr-xr-x   1 root     root          460 Jan 20 10:16 helloa
> > > -rwxr-xr-x   1 root     root         2948 Jan 20 10:16 helloc
> > >
> > > The code size, generated from assembly is 460 bytes.
> > > The code size, generated from C is 2,948 bytes.
> > > The code size, generated from C++ is 57,800 bytes.
> > >
> > > Clearly, C++ is not the optimum language for writing
> > > a "Hello World" program.
> >
> > I like C++ and hate to see it so unfairly maligned.  Here's a much
> > better example:
> >
> > Makefile:
> > helloc: hello.c
> >         gcc -Os -s -o helloc hello.c
> >
> > hellocpp: hello.cpp
> >         g++ -Os -fno-rtti -fno-exceptions -s -o hellocpp hello.cpp
> >
> > Both programs contain exactly the same code: one main() function using
> > puts("Hello world!").
> >
> > # ls -l
> > -rwxrwxr-x    1 jbriggs  jbriggs      2840 Jan 20 10:02 helloc
> > -rwxrwxr-x    1 jbriggs  jbriggs      2948 Jan 20 10:06 hellocpp
> >
> > 108 extra bytes is hardly the end of the world.
> > --
> > Zan Lynx <zlynx@acm.org>
> >
> 
> Well you just fell into the usual trap of using the "C-like"
> capabilities of C++ to call a 'C' function. If you are going
> to use 'C' library functions, you don't use an object-oriented
> language to call them. That is using a hatchet like a hammer.
> 
> I did not malign C++. I used it as it was designed and let
> the chips fall where they may.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
>             Note 96.31% of all statistics are fiction.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


