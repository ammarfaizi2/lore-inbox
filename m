Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136587AbREAH3o>; Tue, 1 May 2001 03:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136586AbREAH3d>; Tue, 1 May 2001 03:29:33 -0400
Received: from gap.cco.caltech.edu ([131.215.139.43]:27594 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S136585AbREAH2h>; Tue, 1 May 2001 03:28:37 -0400
To: mlist-linux-kernel@nntp-server.caltech.edu
Path: aaronp
From: aaronp@regurgitate.ugcs.caltech.edu (Aaron Passey)
Newsgroups: mlist.linux.kernel
Subject: Re: Linux Kernel Debuggers, KDB or KGDB?
Date: 1 May 2001 07:13:17 GMT
Organization: California Institute of Technology, Pasadena
Message-ID: <slrn9esogd.i8g.aaronp@regurgitate.ugcs.caltech.edu>
In-Reply-To: <linux.kernel.18223.988679810@kao2.melbourne.sgi.com>
NNTP-Posting-Host: regurgitate.ugcs.caltech.edu
User-Agent: slrn/0.9.6.2 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 May 2001 11:16:50 +1000, Keith Owens <kaos@ocs.com.au> wrote:
>kgdb relies on gdb so you loose the knowledge of kernel internals (no,
>I am *not* going to teach gdb about kernel stacks, out of line lock
>code etc.).  kgdb has more of a dependency on a working kernel.  It
>provides source level debugging, although stack backtrace tends not to
>work unless you compile the kernel with frame pointers.
>
>UML is great for debugging generic kernel code such as filesystems, but
>cannot be used for most arch code or hardware drivers.
>
>My ideal debugger is one that combines the internal knowledge of kdb
>with the source level debugging of gdb.  I know how to do this over a
>serial line, finding time to write the code is the problem.

I've been thinking about this a little bit and I suspect the right thing
may be to combine a kgdb style debuging stub with the Mission Critical
Linux crash code (http://oss.missioncriticallinux.com/projects/crash/).
Crash is based around gdb and adds the ability to easily examine the
process table, memory maps, kernel logs, wait queues, timers, etc.  Crash
already is able to examine a live system by reading /dev/mem.  The only
thing you'd need to add is the ability to attach to a live system over a
serial port (probably not too hard since gdb already knows how to do that).

Aaron
