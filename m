Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317846AbSFSKri>; Wed, 19 Jun 2002 06:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317847AbSFSKrh>; Wed, 19 Jun 2002 06:47:37 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:5389 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S317846AbSFSKrg>; Wed, 19 Jun 2002 06:47:36 -0400
Message-ID: <3D10613C.CB30F5D3@aitel.hist.no>
Date: Wed, 19 Jun 2002 12:47:24 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.22nopreempt i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, davej@suse.de
Subject: preempt cause series of oopses in 2.5.22 and 2.5.22-dj1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Booting a UP kernel compiled with preempt
(2.5.22, 2.5.22-dj1 and several earlier ones)
results in a series of oopses when running boot scripts, typically
when xdm is about to start.  I can start up single-
user and run X though, I haven't figured out exactly where
it goes wrong.

The oopses scrolling by all starts with
init[454] exited with preempt-count xx
where xx increase by 3 for each oops.  
The call trace is longer each time.
The scrolling stops when this counter reach 63 or 66, 
probably running out of some resource such as kernel stack.

I haven't written down the last oops assuming it is the first
one that is interesting, but I can reproduce and write
down details if someone thinks it makes a difference.

The kernels are compiled with preempt, vesafb, devfs.
Recompiling without preempt gives me a kernel
that works fine.

This preempt problem seems to have existed at least
since 2.5.12-dj1, it took some time before I figured
out it was a preempt problem.

Helge Hafting
