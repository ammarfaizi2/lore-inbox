Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264381AbRFYOFe>; Mon, 25 Jun 2001 10:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264541AbRFYOFZ>; Mon, 25 Jun 2001 10:05:25 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:8499 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S264381AbRFYOFN>; Mon, 25 Jun 2001 10:05:13 -0400
Date: Mon, 25 Jun 2001 09:05:03 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200106251405.JAA44047@tomcat.admin.navo.hpc.mil>
To: humbubba@smarty.smart.net, jesse@cats-chateau.net
Subject: Re: The Joy of Forking
In-Reply-To: <200106250803.EAA20874@smarty.smart.net>
Cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Hohensee <humbubba@smarty.smart.net>:
> > On Sun, 24 Jun 2001, Rick Hohensee wrote:
> > >2.4.5 is 26 meg now. It's time to consider forking the kernel. Alan has
> > >already stuck his tippy-toe is that pool, and his toe is fine.
> > >
> > >	forget POSIX
> > >		The standards that matter are de-facto standards. Linux is the
> > >		standard. Congratulations. Take your seat in the chair for 
> > >		First Violin. 
> > 
> > NO. I port too many programs both ways. I need POSIX compliancy as much as
> > is possible. That way the programs will compile and go among Linux, UNICOS,
> > IRIX, Solaris, AIX, and sometimes HP-UX.
> 
> That's fine for things unix does well. Realtime is one counterexample. 

That depends entirely on the definition of "Realtime". UNICOS can be used
as realime (I understand it used to monitor nuclear reactors). If you need
microsecond response times, then unix of any flavor is not suitable. If you
mean "fast enough to watch DVDs" then you are into 100s of milliseconds where
Linux should be fast enough (with read-ahead caching).

> > >	rtlinux by default
> > >	no SMP
> > >		SMP doesn't scale. If this fork comes, the smart maintainer
> > >		will take the non-SMP fork.
> > 
> > Depends on platform and bus. From reports, it seems to scale just fine on
> > non-intel systems.
> 
> Big expensive systems. Non-desktop systems. Non-end-user systems. And
> clustering will eat its lunch eventually anyway.

Alpha based systems and UltraSparc systems are used for desktops. As are MIPS.
They are also used for servers and clusters.

> > >	x86 only (and similar, e.g. Crusoe)
> > 
> > Again, Linux is the only system that CAN run on anything from PDA thorough
> > supercomputer clusters.
> > 
> 
> NetBSD claims 24 platforms. Forths run on everything you've never heard of
> below a PDA.

When performance is below a PDA, fourth IS a reasonable system. It is also
reasonable for single purpose dedicated functions like sensor monitoring,
printers (without network, though it can be coerced). Fourth just isn't
that usefull (well... less so than other languages) on system that can afford
the software for compilers/linkers/multi-tasking/multi-processing
 
> > >	mimimal VM cacheing
> > >		So you can red-switch the box without journalling with
> > >		reasonable damage, which for an end-user is a file or two.
> > >		Having done a lot of very wrong things with Linux, I'm 
> > >		impressed that ext2 doesn't self-destruct under abuse.
> > 
> > Not if you want some speed out of it.
> 
> Again, throughput is a server thing. 

Refer to the DVD complaints about lack of performance. Linux does need
improving in the IO throughput. CPU throughput is a real pain if the
decryption isn't fast enough.
 
> > 
> > >	in-kernel interpreter
> > >		I have one working. It's fun.
> > 
> > VIRUSES, VIRUSES, and MORE VIRUS entry points. Assuming you mean both
> > translator and execution at the same time.
> 
> And assembler. This is called get your hands greasy. Fun. Your box. Not
> the admin's box. 

A kernel module to compile/link source code ???. The security hassels alone
arn't worth the effort. I've also seen reports of a "postscript" virus that
takes over a printer, and discards any output other than the person who
"printed" the virus; also (hazy memory) of taking over some printers to use
as a platform to launch other attacks. Don't like in-kernel interpreters.

> > >	EOL is CR&LF
> > >		The one thing Dos got right and unix got wrong. Also, in my
> > >		2-month experience in a cube on a LAN, the most annoying thing
> > >		about trying to be a Linux end-user in a Dos shop. Printers
> > >		are CRLF, fer crissakes.
> > >		This is not a difficult mod, but it's a lot of little changes
> > >		throughout a box. Things that look for EOLs are the part that
> > >		has to be fixed by hand, and can be inclusive of CRLF and LF.
> > 
> > I've used both. They are equivalent. Live with it.
> > 
> 
> We disagree, but I wont rant about the phone company breaking a perfectly
> good telegraphy protocol called ASCII.

The phone company wasn't the first to do that - DEC PDP-8 systems also had
a tendancy to drop CR. Their "All-in-One" office hardware dropped both CR
and LF in favor of a record length field for text files (RMS-8/10/11
products - RMS => Record Management System). It was both faster and with smaller
files that way.

> > >	Plan 9-style header files structure
> > >		Plan 9's most amazing stuff to me is the subtle refinements,
> > >		like sane header files. Sane C header files, _oh_ _my_ _God_. 
> > 
> > As long as source code portability is maintained.
> 
> Dennis Ritchie, who signs the checks for the people that wrote Plan 9,
> said an interesting thing about portability. He said "good code is
> portable code." I infer from that, and from the Plan 9 sources, and from
> the design of unix and the two-character commands in /bin/, that he
> relates good very strongly with simple. Not slavish adherance to
> standards. Plan 9 C isn't ANSI, for example. The unix portability suite is
> called "ape".

Yup - yet another software layer to achive portability. Unfortunately, code
developed for Plan 9 isn't very portable; so it has to be done twice on the
same system. There is no standard for Plan 9, other than Plan 9 itself. This
has made it very difficult to make portability claims. POSIX was from the
UNIX base, and defined in an attempt to improve portability. It could be
better (the security and RT definitions are the "weakest"). But they are
standards. Linux attempts to meed the accepted standards where reasonable
and necessary to the developers. They too have to port application level
software among different systems.

> > >	excellent localizability
> > >		e.g. kernel error strings mapped to a file, or an #include
> > >		that can be language-specific. My DSFH stuff also. 
> > 
> > This is quite reasonable. Actually, unless you are referring to Kernel internal
> > error codes, it's already done with perror.
> > 
> > >
> > >What about GUI's, and "desktops" and such? They're nice. They are
> > >secondary, however. The free unix world doesn't often enough make the
> > >point that GUI's are much more important when the underlying OS sucks,
> > >which it doesn't in Linux. 
> > 
> > If you only use a compute/disk server. Otherwise you are saying "no desktop
> > publishing, word processing, or image analysis".
> > 
> > Are you still using DOS only?
> > 
> 
> I haven't started X in about a year. I read pdf's as jpegs, I have Xaos
> running in SVGA, and so on. Not-unix != Dos . I don't dislike X
> particularly, but I live in what I ship, and for maintenance I can't keep
> up with console, considering that I'm doing a bit more than just bundling
> things up.
> 
> > >In short, an open source OS for end-users should be very serious about
> > >simplicity, and not just pay lip-service to it. There is evidence of the
> > >value of this in the marketplace. What doesn't exist is an OS where
> > >simplicity is systemic. This is why end-user issues pertain to the kernel
> > >at all. This is how open source should be. Simple, or at least clear,
> > >through and through. Linux has lost a lot of simplicity since I got into
> > >it in '96, and that is a loss.
> > 
> > For the most part, the base Linux appears simple to the user. There are no
> 
> Which distro appears simple to the user? 

For the most part, Red Hat. I use Red Hat for a general desktop base, but
prefer Slackware for the better controls over the system for things like
firewalls/Servers (also for fewer security problems caused by the additional
"auto-configuration" software that RH insists on creating).

> 
> > desktops to worry about. Desktops are an application, not part of Linux at all
> > It is becoming better for the administrator. As better desktops are developed,
> > it is becoming for "user friendly".
> 
> Thanks for replying civilly to something you clearly don't agree with.
> Basically, your reply says to me that kernel hackers can't imagine unix as
> an end-user OS. Your points are all "that will suck as a server". Of
> course. A solid true multi-user open source operating system is a solid
> base for a variety of things.

I was trying to say that mixing user-application interfaces into a kernel
results in poor everything. The kernel should do what kernels do best -
hardware resource management and security enforcement (could be shortened
to "hardware resource management" since security enforcement can be
considered part of "resource managment").

This frees the applications from also having to do hardware/security
functions (which they do poorly IMHO). It frees the user-application
interface from having to implement applications or hardware and security
enforcement.

Granted, better isolation is needed, and that is where KDE/Gnome (both a bit
bloated) and/or CORBA (even more bloated with accounting and distributed
access controls) were intented to fit. More areas of research and improvement;
but not part of the kernel.

And yes, X really really needs to be split into a device driver/module +
X display server. The current setup causes a LOT of problems that are
hard to diagnose. The recent addition of a frame buffer console goes a
long way to improvements, but isn't yet generic enough to support all
(enough? how many is enough?) graphics adapters. And fbdev doesn't yet work
for laptops well enough (at least the two I've tried with Red Hat).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
