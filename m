Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWAEWVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWAEWVF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWAEWVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:21:05 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:46729 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751126AbWAEWVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:21:03 -0500
Subject: [ANNOUNCE] January Release of LTP Available
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net,
       ltp-announce@lists.sourceforge.net
X-Mailer: Lotus Notes Release 6.5.3 September 14, 2004
Message-ID: <OFD0F941A0.DFD6FB11-ON852570ED.007AA957-862570ED.007AC061@us.ibm.com>
From: Marty Ridgeway <mridge@us.ibm.com>
Date: Thu, 5 Jan 2006 17:20:55 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.5.4FP2 HF2|November 9, 2005) at
 01/05/2006 17:20:57
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LTP-20060105
- Updates from Jennifer Monk to enable compiling w/o errors using XLC
- Applied Coldfire patch from Jody McIntyre:
 - Make the fdopen workaround blackfin-specific (not needed on Coldfire.)
 - getdents01: gcc 2.95 does not like declarations in the middle
   of functions, so move getdents to the top.
 - Add LDFLAGS to the following Makefiles:
 - Add -D_USC_LIB_ for Coldfire builds to the following Makefiles: creat,
   execve, fchdir, kill, mkdir, open, rename, rmdir, sched_setscheduler,
   vhangup, ipc/lib.  This avoids symbol conflicts reported by gcc 2.95.
 - Skip the following syscall tests on Coldfire: madvise, mlock, munlock.
   These system calls are not implemented.
 - IPC: Modify the headers and Makefiles to avoid duplicate definitions of
   msgkey on Coldfire.
 - msgctl08, msgctl09: Lower MAXNPROCS to a value that will fit in the
   Coldfire's memory.
 - mallopt01: Define __MALLOC_STANDARD__ on Coldfire.
 - Skip mmap01 on Coldfire since it requires sbrk(), which is not
available.
 - rename02: Remove private do_file_setup and use the library version to
avoid
   symbol conflicts.
 - kill07: Declare semkey as extern on Coldfire to avoid symbol conflicts.
 - kill11: Move *msg declaration since gcc 2.95 does not understand C99.
 - sigaction01: Move -lc in the Makefile after -lpthread.
- Applied changes suggest by Jacky Malcles to keep gf18 from running longer
than it needs.
- Applied a suggested solution from Jacky Malcles to allow growfiles to run
correctly in 64bits.
- Applied a memory leak fix to fsx-linux tests.
- Applied patch from Marc Unangst to resolve issues with leaking file
descriptors in inode01.c
- Update aio-stress.c tests from Chris Mason
- Applied patch from Bibo,Mao to use RT signal instead of SIGUSR1 to inform
parent process that
  the child process has finished memory allocation.
- New security tests from Michael Harlow
- Applied patch from David Marlin to close the last file descriptor created
in order to
  make one file descriptor available for loading a needed library.
- Added one line to gethostid, if 'hostid' includes fffffff, then we
ignore.
- Applied fix for Sourceforge bug ID 1332508 in getsid02
- Appliec changes from Jane Lv for uClinux.
- Applied patch from Mark Ver to allow proper execution on s390x platform.
- Updates to ASAPI tests from David Stephens for new glibc and RFC 3542
- Renamed create_file.c to nfs04_create_file.c to resolve duplicate name
problem with network stress tests.
- Updates to Makefile for acl testsuite
- Initial add of acl testsuite from Bull
- Updates from sridhar to sctp testsuite
- Comment out CFLAGS overrides in network-stress Makefile, it was causing
build breaks in 64bit compiles

Marty Ridgeway
Linux Test Project
Linux Technology Center
IBM Corporation

Internet E-Mail : mridge@us.ibm.com
IBM, 11501 Burnet Rd, Austin, TX  78758
Phone (512) 838-1356 - T/L 678-1356 - Bldg. 902/6B021
Austin, TX.

