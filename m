Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264545AbSIVVYX>; Sun, 22 Sep 2002 17:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264547AbSIVVYX>; Sun, 22 Sep 2002 17:24:23 -0400
Received: from igw3.watson.ibm.com ([198.81.209.18]:24533 "EHLO
	igw3.watson.ibm.com") by vger.kernel.org with ESMTP
	id <S264545AbSIVVYX>; Sun, 22 Sep 2002 17:24:23 -0400
From: bob <bob@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sun, 22 Sep 2002 17:29:21 -0400 (EDT)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, okrieg@us.ibm.com, trz@us.ibm.com,
       Ingo Molnar <mingo@elte.hu>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [ltt-dev] Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
In-Reply-To: <Pine.LNX.4.44.0209221130060.1455-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0209221830400.8911-100000@serv>
	<Pine.LNX.4.44.0209221130060.1455-100000@home.transmeta.com>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <15758.13368.993118.889319@k42.watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
 > 
 > >From what I've seen from the LTT thing, it's too heavy-weight to be good

Not true anymore.

 > I suspect we'll want to have some form of event tracing eventually, but
 > I'm personally pretty convinced that it needs to be a per-CPU thing, and 
 > the core mechanism would need to be very lightweight. It's easier to build 
 > up complexity on top of a lightweight interface than it is to make a 
 > lightweight interface out of a heavy one.

We have removed locks (code now atomically reserves space in the trace
buffer), significantly reduced the cost of taking timestamps by using the
real-time clock, and are in the process of implementing per-CPU buffers.
As per previous email, the intent is to get only the core infrastructure
into the kernel and keep trace points as patches.  Some of the work going
into LTT is modeled after the tracing infrastructure in K42, which is
extremely lightweight, lock-free, and designed for multiprocessors.


Robert Wisniewski
The K42 MP OS Project
Advanced Operating Systems
Scalable Parallel Systems
IBM T.J. Watson Research Center
914-945-3181
http://www.research.ibm.com/K42/
bob@watson.ibm.com
