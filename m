Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271055AbTG1UfQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271034AbTG1UfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:35:10 -0400
Received: from fc2.capaccess.org ([151.200.199.52]:1811 "EHLO
	fc2.capaccess.org") by vger.kernel.org with ESMTP id S270724AbTG1Ub7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:31:59 -0400
Message-id: <fc.0010c7b2009ecdef0010c7b2009ebbbf.9ecdfd@capaccess.org>
Date: Mon, 28 Jul 2003 16:33:58 -0400
Subject: Re: The Well-Factored 386
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-assembly@vger.kernel.org
From: "Rick A. Hohensee" <rickh@capaccess.org>
References: <fc.0010c7b2009ebbbf0010c7b2009ebbbf.9ebbc6@capaccess.org>
 <20030728070658.343ed2b0.davem@redhat.com>
In-Reply-To: <20030728070658.343ed2b0.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>davem@redhatmicrosoft.CON
>Please stop making off-topic postings.  If you continue to do
>so I will have to yank you from the lists at vger.kernel.org
>and filter you from sending emails to the lists.
>
>Thank you.
>-


Rick Hohensee   July 2003

Why, Rick? WHY?

This is /Ha3sm/blurb on my box, where this originated. Ha3sm is an OS
project written in osimplay, which is an assembler I wrote entirely in GNU
Bash. Ha3sm is hoped to eventually be a complete computer operating system
with a design emphasis on the local "console" user. Forth/AmigaDos first,
server stuff second.

I wrote osimplay for several reasons. First of all, I couldn't stop
laughing when it occured to me that I could write a 386 assembler in Bash.
So I did it. I'm still quite amused by it. There are utterly serious
reasons for such a thing, however. Interdependancies of software packages
are pernicious. Eventually you get to where you can't change anything, and
you have to have everything for anything to work. Most Linux distros are
like that now. You can't downsize Red Hat. Highly un-unix, in my opinion.
You have to start with kernel sources and work up. I did so with cLIeNUX.
Linux people think unix collapses without Perl. I don't have Perl in
$PATH, and it's not in a cLIeNUX Core package. For what, writing an
assembler?

I don't mean to single out Larry Wall. Perl is only quantitatively worse
in this regard than most other unix apps. Assume a unix, and you assume a
lot of stuff. Well, when you want to write something original, most of
that stuff is just in your way. Looking at the sh history in my devel vt,
I use Lynx for a file browser, Pico, grep, less, cat and a couple other
stone-stock doodads. An assembler in Bash is the lowest-level programming
done from the highest level. Directly. No funny libraries. No middleman.
No toolchains. Trivial portablility issues. Near-zero "install" issues.
Get about your actual business, writing machine code. Which, by the way,
is your actual business when writing, say, C. Or other arbitrary binary
data.

Perl is also a good example of what they give people to learn programming.
Java, etc. also. The problem there is you are learning abstractions. With
assembly you are learning how a computer actually works. With 386 assembly
in 2003 you are learning how several hundred million desktop machines and
laptops actually work at thier core. The 386 is ugly, but it's a fairly
generic register machine, and most of what you learn about it applies to
other register machines. Well, if you're selective. Ignore AAA, for
example.

This is what you need to know to ever do anything fundamental, and in fact
is what you need to know to use the abstractions well. Bell Labs still
uses C for Plan 9, but they wrote C. You can see in the exquisite Plan 9
code that when they write something in C they can see what it's exact
machine code ramifications are. This is mastery, and it is a bottom-up
thing. It's also really writing assembly. Ken Thompson wrote the original
UNIX kernel, and ed, which are the two programs that define unix, in my
opinion. The original ed was in PDP assembly. (So was the kernel). The PDP
had about as many different branch conditions as a 386, i.e. 4 or 5 flags
and branches on all of them plus some combinations of them. Thompson used
most if not all of those branch conditions in ed. By hand. That's the sort
of sight that can give somebody that believes Chuck Moore (Forth) is The
One True UberCoder a crisis of faith. When somebody like Thompson (a tiny
group, I admit) writes C, it just looks like they're writing C.

Even if you don't have the next Forth or UNIX in you, you need to know
assembly to master programming, be it Forth, C, ml, Lisp or whatever.
Period. High Level Languages have not lived up to the hopes for them.
Period. Things like Java are for building technology bubbles. Torvalds is
Torvalds because he wrote all the assembly Minix needed for pmode. C is
the lingua franca of the Internet because it's as low-level as it can be
and still claim to be high-level, or "portable". C produces snappy
application code. That's where it beats a public domain Forth, and
commercial Forths are, well, commercial. Like, you can't reuse the parts
like you can with a homebrew. You can write an OS in C, which was it's
original striking achievement. People didn't write OSes in high-level
languages in 1972.

Well, they still don't. Plan 9 has very little assembly in it, but that's
Bell Labs. They note that Plan 9 is an experiment. And it still has some
assembly at crucial junctures. And those guys see the assembly under (int
*)(bla()****) or what-the-hell as they are writing it. BSD has more, and
386 Linux is ludicrous for asm("") and setup.S and so on. And the
difficulty and non-portability of e.g. GNU C asm("") offsets fully all the
joys <cough> of C, for OS devel. So in realistic terms, operating systems
are written in assembly. osimplay does not attempt to pretend otherwise.
There are some stand-alone Forths out there, which you extend in Forth,
but the Forths are in assembly, if they're not on Forth hardware.

What osimplay does do is make assembly as easy as possible. The rush to
the high-level mirage has left assembly stuck in 1965. This is the
opportunity osimplay jumps on. There's enough suffering in the world
without having to pretend 386 instructions are different depending on if
you are in rmode or pmode. They are the same opcode. In osimplay they are
the same mnemonic. With a prefix, they are the same action.  And mnemonics
actually are mnemonic in osimplay. The most central piece of data in a PC
is called "A" in osimplay, not %eax/%ax/%al. Et cetera.

osimplay also deliberately violates the unix ideal of lots of small tools.
That's a good model except as pertains to your command interpreter. The
shell is not a tool; it is your hands. osimplay is a shell script of a
machete. Any competent campesino from anywhere can build Noah's Ark with
it. Also, osimplay isn't a violation of the historical unix ideal of
modularity to anything approaching the extent of the typical major
GNU/Linux distro.

Martin Richards wrote BCPL back in 1967 or so. In circa 1970 Thompson and
Ritchie bailed on a FORTRAN compiler for UNIX and settled for an
interpreted BCPL, B. Then Ritchie Pascalified BCPL into C. A little later
Richards wrote the predecessor of Amigados in BCPL, Tripos. Martin
Richards still works on a descendant of BCPL, MCPL. It has some nifty
ml-like "patterns" case-construct compiler stuff, which MCPL uses for most
of its program flow control, but it still doesn't have typed data ala C.
Richards had a better idea, which idea also found its way into the ANSI
Forth spec, cells. A machine has a cell size. That's your integer. Data
type game over. I wrote a 3-stack Forth called H3sm to have a
variable-size cell at the lowest level possible, i.e. demonstrably
feasible in hardware. In H3sm they are called pytes. In osimplay, they are
once again simply "cells", but they smooth over a lot of INTeL ugliness
about rmode/pmode, and I presume, IA64.

I'm more severely minimalist about some things than even Chuck Moore
though. Pytes reduce the overall namespace proliferation of Forth, which
is pretty bad. Also, I don't do do/while, for/next and so on in osimplay.
GOTO gets a bad rap, but it's what actually exists, and it's unambigious.
I don't believe the if/else/else issues are any worse in assembly than in
C. Or Forth.  "if" is "when" in osimplay though, just to avoid a conflict
with the shell. I do provide an execution array widget in osimplay, and
it's pretty snappy. There are reentrant procedure thingies and so on also.

The idea of structured programming is nice. Somebody noticed that a few
particlar conditional constructs are a complete set, and decided to make
some hay trying to limit the world to those few constructs. Your PC is a
big jump-table though, known as the IDT, and the OS is the program that
deals with it. osimplay provides an execution array assembler with the
osimplay words xray and yarx. It's not structured. It screams.

Assembly is considered unportable and C is considered portable. I've
already noted that the portable parts of C are the less crucial parts, and
386 assembly is only 100% portable to several hundred million machines,
But, There's More. What machine is
                                        = A to B
                                                        for? That's
osimplay for what is MOV %eax, %ebx in Gas. That can be emulated trivially
on any register machine with two or more registers. Among the machines the
386 is comparable to, the 386 constitutes a register subset that can be
mapped onto the other device easily. There are other issues and tricks to
solve them. What osimplay calls plurals, the REP thingies on the 386, can
easily be hidden, and so on. For another example of this sort of thing,
but going the other way, the Plan 9 assembler fakes COPY <memloc> to
<memloc> on the 386, so the assembler is more CISCy. Plan 9 seems to have
originated on a 68020. (The 386 only allows memory-to-memory in a few
circumstances, like where SI and DI are already set up for LODS).

I still think Chuck Moore has obsoleted register machines. I don't happen
to have a stack-machine PC yet, however. Hence Ha3sm. I like my pytes, in
H3sm. They will return to Ha3sm eventually, and Ha3sm will model the PC I
wish I had, on a clone, Lord willin and the river don't rise.

The bad news is, osimplay is of course ridiculously slow. It takes like 10
minutes to assemble a VGA font, with no high-ASCII glyphs. Converting a
binary string to a byte is not what Bash likes to do. A 1400 byte
femto-kernel takes like 30 seconds on a P166. Small price to pay for
significantly lower mental burdens while actually coding the stuff,
easily. Checkmate leaves no weaknesses. And things like fonts don't have
to be reassembled every 10 minutes when you're working on the IDT. Also,
since writing the preceding lines of this paragraph I made an array of
semi-graphic binary-like names for 0-255, and fonts assemble now about as
fast as code. 3 is $______II. The joy of scripting.

There are several defenses from the slowness of osimplay. A: In an OS
context, get onto the target machine as early as possible, with a Forth or
other machine monitor of some kind. B: The first predecessor of osimplay
was asmacs, m4 macros for gas. If you want to write a big app in osimplay
for a GNU/Linux, an asmacs won't bite you too hard. Less than installing
gcc. I'd rather deal with the slowness of sh though. C: osimplay doesn't
have a linker, but it could benefit tremendously from one that could link
to binaries that don't get reassembled on every development run, such as
fonts. There are some predecessors of a linker in the ELF stuff in
osimplay for Linux and the Cat thing at the end of Ha3sm/code/top. In
fact, it should be possible to only reassemble the parts of an osimplay
project that are currently under development, and keep those parts to
hundreds of bytes of code.

This blurb may come with several different subsets of the other things I
have in this directory, or I may just do the Ha3sm/osimplay funpack. In
that case you should get a target-systems-only osimplay, a Linux-apps
osimplay with ELF and syscalls, a couple demo utils for Linux, a couple
VGA fonts, a couple boot demos including a Forreal Mode demo and maybe a
Squeal Mode demo, html manpage-like osimplay docs, and my re-edit of
386INTEL.TXT, converted about halfway to my programming style, and
converted all the way to 80 columns or less, 7-bit ASCII only.


