Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbSKKGFK>; Mon, 11 Nov 2002 01:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265581AbSKKGFK>; Mon, 11 Nov 2002 01:05:10 -0500
Received: from episec.com ([198.78.65.141]:16391 "HELO episec.com")
	by vger.kernel.org with SMTP id <S265578AbSKKGFJ>;
	Mon, 11 Nov 2002 01:05:09 -0500
Date: Mon, 11 Nov 2002 01:11:19 -0500
From: ari <edelkind-kernel@episec.com>
To: linux-kernel@vger.kernel.org
Subject: penalty-imposing resource limits
Message-ID: <20021111061119.GF79406@episec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This post is three years too late.

Once upon a time, when kernel 2.2.13 was the bleeding-edge of the stable
tree, my processor was experiencing heat-related problems.  I dealt with
this as any proactively lazy person would, in that instead of buying a
new heat sink, i modified my kernel to deal with the issue, and wrote a
small command-line program as an interface.

This modification added a new resource limit to the kernel, RLIMIT_TCPU,
allowing the user to impose time penalties (in jiffies) on a process
that reaches a set amount of cpu time (in 1/100 of a cpu second).  It
was a simple algorithm, but it functioned satisfactorily, and it
remained incredibly useful to me for some time.  Eventually, i bought a
new heat sink and high silver content thermal compound, and felt no need
to port this modification to future kernel releases.

The topic of heat-related issues came up in conversation recently, and a
comment about my modification followed suit (this comment came from me,
of course, reminiscently).  The person to whom i spoke iterated how
useful such a thing could be, further requesting that i send the patch
on to the linux kernel mailing list.  The rest can be inferred.

'Twas a quick hack, and rather dirty.  It wasn't designed for
multiprocessor systems, but it will likely handle them... acceptably.
It should also function (and compile) only on i386-based processors, as
i did not modify resource.h in other processor-specific include
directories (this should be terribly easy to change, as the actual
modifications are not processor-specific).  Regardless, it served me
well, and perhaps in some form it may live to serve another.

The patch and the program are now available at:
	http://www.episec.com/people/edelkind/patches/kernel/

Usage is given there as well.

ari

