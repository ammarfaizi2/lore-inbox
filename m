Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbTBCUVm>; Mon, 3 Feb 2003 15:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265409AbTBCUVm>; Mon, 3 Feb 2003 15:21:42 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:30731 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S264936AbTBCUVk>; Mon, 3 Feb 2003 15:21:40 -0500
Date: Mon, 3 Feb 2003 20:31:12 +0000
From: John Levon <levon@movementarian.org>
To: oprofile-list@lists.sf.net, editor@lwn.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] OProfile 0.5 is released
Message-ID: <20030203203112.GA1268@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18fnFI-0007UN-00*LG.dxJm4uvs*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OProfile 0.5 has been released. OProfile is still in alpha,
but has been proven stable for many users.

Release notes
-------------

For 2.2 kernels, the module must be compiled as the same user
that owns the kernel source tree.
 
nosmp is not supported in kernels before 2.4.10 (bug #463087).

The pre-emptable kernel option is not supported in 2.4 (bug #478516).
 
Power management on laptops can be incompatible with OProfile in 2.4 (bug #554927).

The utilities op_start, op_stop, op_dump, and op_session are deprecated. They
are still available in this release, but it is recommended that the opcontrol
script is used instead, as they will be removed.

Building from CVS now requires the autotools. A minimum of autoconf 2.13 and
automake 1.5 are required.

New features
------------

Pentium IV support, including support for HyperThreading, is supported for 2.5
kernels (currently only in the -mm patchset). Timer interrupt support for PA-RISC,
ppc64, and sparc64 in 2.5 kernels is available. Userspace Alpha support has been
added. HyperThreading support for Pentium IV on 2.4 kernels is not yet available.
Note that PA-RISC and Alpha require kernel patches not yet available in a released
kernel tree.

Support for the IA-64 architecture has been added for 2.4 kernels.

OProfile's userspace now works correctly on all 64-bit platforms.

A new script, opcontrol, has been added to unify control of the OProfile daemon
and sample files. On 2.5, this allows separate daemon startup and starting/stopping
profiling.
 
Bug fixes
---------

The use of the NMI watchdog with Pentium IV, and some other problems,
caused serious hangs. This is now fixed (bug 643828)

Userspace tools mismatch between daemon and output tools gives a better error
message (bug 635759)

libpp.a is no longer installed (bug 635954)

A problem with 2.5 and op_start has been fixed (bug 637804)

Passed-in filenames are now treated correctly for post-profiling tools
(bug 637805)

--exclude-symbols is no longer ignored for op_time (bug 651165)

Multiple-counter reports no longer erroneously show the same header
for all counters (bug 651183)

Corner case with use of --separate-samples when app has no samples
has been fixed (bug 656123)
