Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbUATPTR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 10:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265553AbUATPTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 10:19:17 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7047 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265531AbUATPTL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 10:19:11 -0500
Date: Tue, 20 Jan 2004 10:20:53 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Bart Samwel <bart@samwel.tk>
cc: Ashish sddf <buff_boulder@yahoo.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ kernel module + Makefile
In-Reply-To: <400C4B17.3000003@samwel.tk>
Message-ID: <Pine.LNX.4.53.0401201000490.11497@chaos>
References: <20040116210924.61545.qmail@web12008.mail.yahoo.com>
 <Pine.LNX.4.53.0401161659470.31455@chaos> <200401171359.20381.bart@samwel.tk>
 <Pine.LNX.4.53.0401190839310.6496@chaos> <400C1682.2090207@samwel.tk>
 <Pine.LNX.4.53.0401191311250.8046@chaos> <400C37E3.5020802@samwel.tk>
 <Pine.LNX.4.53.0401191521400.8389@chaos> <400C4B17.3000003@samwel.tk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-817269274-1074612053=:11497"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1678434306-817269274-1074612053=:11497
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 19 Jan 2004, Bart Samwel wrote:

> Richard B. Johnson wrote:
[SNIPPED...]

> into it and do useful work. If somebody has decided that it would be
> worth it for his project to use C++ (without exceptions, rtti and the
> whole shebang) then so be it, why should you care? It's just binary code
> that hooks into the module interface, using the correct calling
> conventions. It doesn't do dirty stuff -- no exceptions, no RTTI,
> etcetera. It compiles into plain, module-interface conforming assembler,
> that can be compiled with -- you guessed it -- 'as', the AT&T syntax
> assembler. Yes, they're taking a risk. Their risk is that C++ can't
> import the kernel headers, or that C++ might someday need runtime
> support that cannot be ported into the kernel. It's *their risk*, not
> yours. Then why do you have a reason to get religious about this?
> They're not submitting this stuff for inclusion in the Linux source!
>
> > Any person, or group of persons, who is smart enough to
> > actually write some kernel code in C++, has proved that
> > they are not ignorant. Therefore, they have demonstrated
> > their arrogance.
>
> This logic is faulty. It is built upon the premise that (ignorant ||
> arrogant). Not listening to warnings of others is not a sign of
> arrogance per se, it is only a sign of the presence of a different
> opinion. It assumes that the kernel developers are always right, and
> that everybody who is smart should listen to them, on penalty of being
> arrogant. Yes, these C++-loving people may be wrong (or they may not
> be), but that does not _automatically_ make them arrogant, they may
> simply have a different opinion -- right or wrong. If they are wrong,
> they are not arrogant, but simply *stupid*. If they are right, they are
> not arrogant either -- they may be arrogant *about it*, but that's just
> a manner of behaviour, and it's up to them if they behave in this way or
> not. Kernel developers do not prescribe what people can do with the
> kernel, this is part of the essence of "free". And as a result of that,
> they do not have the right to declare people arrogant when they do not
> listen. They have the right to *call* them that, but the only result of
> that is that all discussion on matters like these are smothered in
> religious wars. And that's a pity.

It's not, as you say, a religious war.

Whether or not one can use the back-end of a
hatchet as a hammer does not qualify the hatchet
as a hammer.

Let me introduce the concept of a "learned person".
Such a person might not actually exist. However,
for my proposes, a learned person knows everything
there is to know about solving the problem at hand.
This is a definition. It is not subject to discussion.

C++ was designed as an object-oriented language.
C and assembler are procedural languages, as have
been most all previous programming languages.

The coding of operating systems is all about
procedures. In fact, one of the reasons for the
superiority of Linux is the great attention to
the details of the actual execution mechanisms
and the actual execution paths.

An object-oriented language relies upon the
compiler and libraries to work out the execution
mechanisms to be used. The programmer is shielded
from the actual mechanisms that implement the
objects being manipulated. For instance, in C, one
can code a loop counter and code the actual
mechanisms by which a procedure may terminate. In
C++, one may use iterators. Whether or not there
is some actual counter is an implementation detail
that can be hidden from the programmer.

Of course one may also write C-like code when using
C++ because there are some things that an object-
oriented mechanism can't do by itself. This allows
one to write loops with loop-counters in C++. The
fact that C++ can be used somewhat like C does not
make it a substitute for C anymore than a hatchet
is a substitute for a hammer.

Because of the object-oriented design of C++, there
is considerable overhead necessary to make it function
in an environment with many other objects. C has some
overhead of its own, too. However, it is quite minimal.
Local variable space is allocated simply by subtracting
a value from the stack-pointer, for instance. The overhead
of a particular language is often demonstrated by writing
a simple "Hello World!" program in that language and then
displaying the result as the size of the executable.
This, of course, is quite unfair. It really shows how
smart the linker is. A smart linker will link in only
the required code. Linkers are pretty dumb.

In the kernel, a linker doesn't have to be smart because
the programmers have provided only the code that should
be executed. There is no runtime library.

Nevertheless, I provide three programs, one written in
C, the other in C++ and the third in assembly. A tar.gz
file is attached for those interested.

-rwxr-xr-x   1 root     root        57800 Jan 20 10:16 hello+
-rwxr-xr-x   1 root     root          460 Jan 20 10:16 helloa
-rwxr-xr-x   1 root     root         2948 Jan 20 10:16 helloc

The code size, generated from assembly is 460 bytes.
The code size, generated from C is 2,948 bytes.
The code size, generated from C++ is 57,800 bytes.

Clearly, C++ is not the optimum language for writing
a "Hello World" program. Because many persons don't know
assembly language, it is probably not the best language
either, in spite of the fact that the executable file is
only 460 bytes in length. Therefore a learned person,
given the task of choosing the language in which to write
"Hello World!" would likely use 'C'. In spite of the
fact that it can be written in C++, I suggest, in fact
insist, that a learned person would never write such a
program in C++ except for the purpose of demonstrating
that it can be done.

When writing code for a project, one is not usually
presented with a bunch of languages from which one can
choose on a whim, or by throwing darts. Instead, there
are specific requirements defined by the nature of the
work to be done. There is no learned person who would
require that a data-base project be written in assembler.
It is quite likely that the optimum language would
be C++. There might be certain portions of the resulting
executable that, in fact, were written in assembler,
probably a lot of the runtime library. When writing a
data-base program, one absolutely positively must not
know what the underlying data-fetching mechanisms are
because, once known and used to define (poison) the
design, the program may run poorly on a network. This
is one of the areas where object-oriented programming
really shines.

However, when writing code that runs in an Operating
System, one is most entirely concerned, in fact consumed
with the mechanisms by which the required functionality
is obtained. Programmers spend hours, days, even weeks,
shaving microseconds off from critical execution paths.
This is because any resources used by the Operating
System directly affect every task running under that
Operating System.

A learned person would never allow the code, defined by
the designers of a compiler, to make the final decision
about the mechanisms necessary to perform the required
functions. Instead, the Operating System programmer makes
those decisions. That's why a procedural language must
be used in coding Operating Systems.

The result of such attention to details is the Linux
Operating System.

Now, if you want to trash your copy of the Operating System
with the output spewed from a C++ compiler, then I suggest
you keep it real quiet. It is similar to "touching up" a
famous painting with spray-paint, of defecating on a wedding
cake.

Again, writing a Linux kernel module in C++ demonstrates
arrogance, absolutely, positively arrogance, and is an
affront to the programmers who have dedicated major amounts
of their time optimizing code execution in the kernel.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


--1678434306-817269274-1074612053=:11497
Content-Type: APPLICATION/octet-stream; name="size.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0401201020530.11497@chaos>
Content-Description: 
Content-Disposition: attachment; filename="size.tar.gz"

H4sIAINGDUAAA+2WW2/TMBTH+2p/isMu0kbX4FzaoW4gJO7iUkSH9oI0eYnT
RrjxlLijgPju2Lm0YYx1Esq4nd9LYvt/jo/jHB/nyWdxp9MuELD9fh86YGEX
nlXDZYz5XuC7Rmgbnt+BfstxFcxzzTOATqaUvkq3bvwvJbf7PxVSKidsaw6z
nYMg+Pn+u75X7b838JlrOlzf73eAtRVQk/98/zeTNJTzSMBhrqNEOdP7NEk1
zHiS7pyrJNo9WLV34Qu1+3U21/nOxjP708CxymR0a8PI7Egm9DxLgR3Qr/R3
rwy5DkX+v+IfRJxI0dIc6/I/GHjL85/tezb/+wHD/L8JKKVv3o6eju+RogiE
UDy65YNTyqUckq2dQrNLaSkakqpiUDIJQ+gdGxX0RgH0FDTdWEGus+Ss6q3s
u0t766DbvcRBF1aKhodu5YFXHrijKJHR0ozDqrthxmszR9VTjykhPF8ZOtWL
GaA0lIKnQ0qyGfRiqFcPt41b+o+da83639YFYG39H/hV/vuMuf0i/5mL+X8T
XFL/V12xySHBZ9e6FIRqruHwEL67F7xPN/Bi8EfTyP9xW3Osy39z6a/z3w08
v7j/e5j/N4IpaE4uQp2olDiZirjmZa0cEsdW0HTyQ0YbA/PTlHV0z/Ub9los
NHUmUp1ySU7shzVN/elMVI29B/E8LbSUlj1DMlPnkmyxBQv2tgVfkE14IbJU
SPiYJVrA0mAldI3w1ArHR49G745Onjx/+fj1qBaUYcG2CK1kFMe50KBi0FMB
5YJqpetbWVR4KlcqRTrRU0rM4WZnusuIGXto7yYfipguBFFEW46AWCT6smBZ
HWwhYFf5nkrztUQaUaAED0kEQRAEQRAEQRAEQRAEQRDkl/gGmTQ7zgAoAAA=

--1678434306-817269274-1074612053=:11497--
