Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315191AbSEUQhv>; Tue, 21 May 2002 12:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315200AbSEUQhv>; Tue, 21 May 2002 12:37:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:37363 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315191AbSEUQht>; Tue, 21 May 2002 12:37:49 -0400
Subject: [ANNOUNCE] scheduler utilities
From: Robert Love <rml@mvista.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 May 2002 09:37:49 -0700
Message-Id: <1021999069.2638.36.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll only announce this once as it lives in user, not kernel, space.  It
is, however, infinitely related to the kernel and could use some eyes by
fellow kernel developers and users alike.

I ask that, in general, aside from this posting email correspondence be
kept off the list.  This is not a kernel topic in the strictest since. 
This is also an early release, so please keep that in mind when you make
comments.

Now with formalities done...

I would like to publicly announce "schedutils" - a suite of
scheduler-related tools for Linux.  They are simple GNU-style utilities
in similar fashion as the other Linux utility packages - except they
manipulate the scheduler.

They are released under the GNU GPL v2.

Version 0.0.5 can be had at:

source tarball:  http://tech9.net/rml/schedutils-0.0.5.tar.gz
i386 RPM:        http://tech9.net/rml/schedutils-0.0.5-1.i386.rpm
source RPM:      http://tech9.net/rml/schedutils-0.0.5-1.src.rpm

Currently there is no standard utilities for manipulating scheduler
parameters.  Thus this has two goals: first, to provide utilities for
such manipulation.  Second, and most importantly, to provide a
_standard_ suite of utilities for such manipulation.  Something that can
be depended on to exist in distributions, etc. etc.

Right now the package consists of four utilities and their associated
documentation:

rt(1) - get or set the real-time scheduling class and priority of an
existing pid, or launch a new task with a given class and priority.

taskset(1) - get or set the CPU affinity of a given pid, or launch a new
task with a given CPU affinity.  This requires the 2.5 kernel or a
patched 2.4 kernel (see my website for patches).

irqset(1) - get or set the CPU affinity of a given interrupt.  This is
implemented as a bash script which parses the `/proc' output.

lsrt(1) - list real-time processes on the system, their priorities, and
their scheduling class.  Right now RT information is not exported out of
`/proc' so ps(1) does not display this information.  A better solution
may be to export this information from `/proc' but for now this exists
(and is most likely much faster).

There is some basic information and complete man pages in the package. 
The RPM was built on RedHat 7.3 but should work on any 7.x release and
perhaps even any glibc 2.2.x RPM-based distribution.

Source users can do:
	./configure [options]
	make
	make install

I am open to any suggestions, bugs, patches, complaints, etc.  The idea
here is to provide standard utilities for scheduler-related stuff.

Enjoy,

	Robert Love

