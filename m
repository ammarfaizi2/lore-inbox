Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286374AbRLJUP1>; Mon, 10 Dec 2001 15:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286368AbRLJUPQ>; Mon, 10 Dec 2001 15:15:16 -0500
Received: from mail.ccur.com ([208.248.32.212]:19 "EHLO mail.ccur.com")
	by vger.kernel.org with ESMTP id <S286371AbRLJUO7>;
	Mon, 10 Dec 2001 15:14:59 -0500
Subject: [RFC] Multiprocessor Control Interfaces
From: Jason Baietto <jason.baietto@ccur.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 10 Dec 2001 15:14:47 -0500
Message-Id: <1008015291.15138.0.camel@soybean>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I'm currently working on adding multiprocessor control interfaces
to Linux.  My current efforts can be found here:

   http://www.ccur.com/realtime/oss

These are clean-room implementations of similar tools that have
been available in our proprietary *nix for quite some time, and
so the interfaces have a fair amount of mileage under their belts.
Note that the scope is somewhat wider than just MP.

There has been some discussion of "chaff" and other interfaces
recently on this list, so in an effort to hopefully move towards
a standard more quickly I've gotten permission from my employer
to GPL the code I've written.  I'm very interested in comments
and feedback on any or all of this work.

Here's the README file from the package:


This package contains:

   run(1)
      A multiprocessor control command line tool.

   mpadvise(3)
      A multiprocessor control library interface.

These services rely upon Robert Love's CPU Affinity patch
(version 2.4.16-1 was used for testing) which is available here:

   http://www.kernel.org/pub/linux/kernel/people/rml/cpu-affinity/v2.4/

To build the code, simply unpack it and type "make".  The code has
been tested on Red Hat 7.1 and 7.2 systems, though it is still
fairly new and almost certainly contains bugs.

An attempt was made to abstract the "cpuset" representation of
the current system in order to have binaries that in theory
could work on systems with more than 32 cpus.  For this to work,
the run(1) command would need to be linked against a shared
mpadvise(3) library (currently only a static library is made).

This code is being released in the hopes that it will become
the basis for the Linux multiprocessor control standard interfaces.
I am very interested in getting feedback on this package,
so please contact me via email or LKML if you have any.

This source code is licensed under the GNU GPL Version 2.
Copyright (C) 2001  Concurrent Computer Corporation

--
Jason Baietto
jason.baiett@ccur.com
http://www.ccur.com/realtime/oss


