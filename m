Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315801AbSEEBED>; Sat, 4 May 2002 21:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315804AbSEEBEC>; Sat, 4 May 2002 21:04:02 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:27338 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S315801AbSEEBEB>; Sat, 4 May 2002 21:04:01 -0400
Date: Sat, 4 May 2002 18:04:01 -0700 (PDT)
From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: IO stats in /proc/partitions
In-Reply-To: <Pine.LNX.4.33.0205041718290.4175-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.33.0205041720150.11514-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 May 2002, Mark Hahn wrote:

> perhaps you've mistaken this for a Windows mailing list.

Well, it's Sunday in many parts of the world, so I will haul out my
soapbox and put on my flame-retardant jump-suit (penguin/tuxedo style,
of course :).

OK ... since you brought up Windows ... IMHO one of the things Windows
NT does *much* better than *any* UNIX, including Linux, is the
performance monitoring tools. First, you have a registry interface that
allows fetching of any counter by name, complete with an explanation of
what the counter means. I can pick this info up in Visual Basic, Visual
C++, C#, Java and even Perl. *And*, I can access these data over the
network from another system. The level of detail on things like disk I/O
is richer than most UNIX implementations.

Second, you have an API that allows an application developer to *easily*
add application-specific performance counters to the set that's
collected. And third, you have the PerfMon tool, which lets you capture
data in binary log files, graph data in real time, export data to
comma-separated value files for off-line analysis, and issue alerts when
a variable goes into a sysadmin-defined unacceptable range. In short,
Windows NT performance monitoring was *designed* -- it didn't *evolve*.

But design takes time ... and it isn't always as much fun as evolution.
So we performance engineers on the UNIX/Linux front build our own tools
-- sar, top, procinfo, iostat, vmstat, etc. -- and some of us, myself
among them, write code to parse their output or, in the case of Linux,
sometimes parse the files in /proc themselves. And we write R code to
plot the graphs that the techies and managers need to make capacity
planning decisions and solve performance issues for our users.

Yeah ...  it's a lot more fun than designing and implementing a
performance monitoring infrastructure like Windows has. It's also
frightfully inefficent to have the kernel do a "printf" on demand to
generate ASCII data, then open and read a bunch o' files in a humongous
Perl script and collect the samples in CSV format.
-- 
M. Edward Borasky
znmeb@borasky-research.net

The COUGAR Project
http://www.borasky-research.com/Cougar.htm

If I had 40 billion dollars for every software monopoly that sells an
unwieldy and hazardously complex development environment and is run by
an arrogant college dropout with delusions of grandeur who treats his
employees like serfs while he is acclaimed as a man of compelling
vision, I'd be a wealthy man.

