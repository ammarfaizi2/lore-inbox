Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136608AbREAKzc>; Tue, 1 May 2001 06:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136612AbREAKzW>; Tue, 1 May 2001 06:55:22 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:38879 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S136608AbREAKzO>; Tue, 1 May 2001 06:55:14 -0400
Message-ID: <3AEE9705.CCA13D76@veritas.com>
Date: Tue, 01 May 2001 11:59:17 +0100
From: "Amit S. Kale" <akale@veritas.com>
Organization: Veritas Software (India)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Paul J Albrecht <pjalbrecht@home.com>, linux-kernel@vger.kernel.org,
        Jeff Dike <jdike@karaya.com>
Subject: Re: Linux Kernel Debuggers, KDB or KGDB?
In-Reply-To: <18223.988679810@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I mostly agree with Keith.

kdb and kgdb have similar capabilities. kgdb can be used
to do kdb like assembly level debugging too, though it
needs some knowledge of gdb and kgdb internals.

You can analyze any problems with either of the debuggers.
You'll need to decide which debugger to go for depending
on your requirements.

I've got many queries asking kgdb capabilities.
I guess it's time for a webpage comparing the two
debuggers. People who are new to linux kernel and
have not used any of the debuggers can hardly arrive
at a decision as to which debugger is better suited for
their work.

I always suggest for kgdb over kdb because, IMO source
level debugging makes a programmers life much easier.

UML too is a good kernel debugging tool. It offers
the advantage of source level debugging on a single
machine. IMHO it's more useful for beginners.

Keith Owens wrote:
> 
> On Mon, 30 Apr 2001 16:17:22 -0500,
> Paul J Albrecht <pjalbrecht@home.com> wrote:
> >Where can I find an analysis of the relative strengths and weaknesses of KDB
> >and KGDB for kernel debug? Has the linux community come to any consensus
> >regarding the utility one or the other?
> 
> kdb is a really low level debugger which understands the kernel
> structures.  It does its utmost to stop all kernel activity while it is
> running and to use as few kernel services as possible so it can run
> even when the kernel is dead.  It (currently) has no source level
> debugging.
> 
> kgdb relies on gdb so you loose the knowledge of kernel internals (no,
> I am *not* going to teach gdb about kernel stacks, out of line lock
> code etc.).  kgdb has more of a dependency on a working kernel.  It
> provides source level debugging, although stack backtrace tends not to
> work unless you compile the kernel with frame pointers.
> 
> UML is great for debugging generic kernel code such as filesystems, but
> cannot be used for most arch code or hardware drivers.
> 
> My ideal debugger is one that combines the internal knowledge of kdb
> with the source level debugging of gdb.  I know how to do this over a
> serial line, finding time to write the code is the problem.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Amit Kale
Veritas Software ( http://www.veritas.com )
