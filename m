Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268123AbTCFQjP>; Thu, 6 Mar 2003 11:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbTCFQjO>; Thu, 6 Mar 2003 11:39:14 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:55257 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268123AbTCFQjG>;
	Thu, 6 Mar 2003 11:39:06 -0500
Subject: [ANNOUNCE] LTP-20030206
To: ltp-list@lists.sourceforge.net, ltp-announce@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OF4AF5DDD6.DCAA7D63-ON85256CE1.0057F0C5-86256CE1.005CD250@pok.ibm.com>
From: "Robert Williamson" <robbiew@us.ibm.com>
Date: Thu, 6 Mar 2003 10:49:21 -0600
X-MIMETrack: Serialize by Router on D01ML076/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 03/06/2003 11:48:37 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Test Project test suite ltp-full-20030206.tgz has been released.
Visit our website (http://ltp.sourceforge.net) to download the latest
version of the testsuite that contains 1000+ tests for the Linux OS.  Our
site also contains other information such as: test results, a Linux test
tools matrix, technical papers and HowTos on Linux testing, and a code
coverage analysis tool.  A new area for keeping up with fixes for known
blocking problems in 2.5 kernel releases has been added as well, and can
be found at http://ltp.sourceforge.net/errata .

The list of test cases that are expected to fail is located at:
http://ltp.sourceforge.net/expected-errors.php

The highlights of this release are:

- All tests from the Open POSIX* Testsuite have been ported and merged in.
- New test scripts have been added for system stress and LVM testing.
- Entire suite has been updated to support non-root 'make install'
- New API added to allow test creators to easily query the kernel
  version of the test machine.
- Changes were implemented to support GCC 3.3 standards.
- All patches, fixes, and updates accepted into CVS have been included.

We encourage the community to post results, patches, or new tests on our
mailing list, and to use the CVS bug tracking facility to report problems
that you might encounter. More details available at our web-site.

- Robbie

Robert V. Williamson <robbiew@us.ibm.com>
Linux Test Project
IBM Linux Technology Center
Phone: (512) 838-9295   T/L: 678-9295
Fax: (512) 838-4603
Web: http://ltp.sourceforge.net
IRC: #ltp on freenode.irc.net
====================
"Only two things are infinite, the universe and human stupidity, and I'm
not sure about the former." -Albert Einstein

ChangeLog
---------
- Changed IDcheck.sh to only prompt for id        ( Robbie Williamson )
  creation if the user is root.
- Added LVM test execution scripts.               ( Marty Ridgeway )
- Added system stress execution script.           ( Robbie Williamson )
- Added tst_kvercmp() API to allow test           ( Paul Larson )
  creators to query the kernel version.
- Removed all external int declarations of        ( Anton Blanchard,
  "errno" and replaced with includes of errno.h     Susanne Wintenberger,
                                                    Robbie Williamson )
- Replaced usage of sigaction() with signal()     ( Nathan Straz )
  in `pan`.
- Ported and merged all tests from the Open       ( Robbie Williamson )
  POSIX* Testsuite:
    pthreads
    semaphores
    timers
    clock()
    nanosleep()
    raise()
    sigsetops
- Added flock06 test.                             ( Matthew Wilcox )
- Added ipchains and dhcpd (server) tests.        ( Manoj Iyer )
- Patched Makefiles to stop execution on errors.  ( Vasan Sundar )
- Patched Makefiles to allow non-root users to    ( Robbie Williamson )
  run 'make install'.
- Fixed 'ar' test to use CC defintion in          ( Anton Blanchard )
  Makefile.
- Corrected typos in install section of           ( Manoj Iyer )
  commands/fileutils/<test> Makefiles.
- Added tests for gzip/gunzip.                    ( Manoj Iyer )
- Added tests for unzip.                          ( Manoj Iyer )
- Applied patch to fsstress's Makefile to         ( Anton Blanchard )
  define _GNU_SOURCE to allow O_DIRECT.
- Applied changes to allow testcases to be        ( Susanne Wintenberger )
  GCC 3.3 compliant.
- Fixed semaphore initialization bug in sem02.    ( Jacky Malcles )
- Applied patch to mem/mtest07/shm_test.c to      ( Chris Dearman )
  correct character buffer variable: buff.
- Fixed hangup01 to initialize variable,          ( Robbie Williamson )
  usrstr.len, to avoid junk data storage.
- Applied patch to clone01 to allow test to       ( Andi Kleen )
  be more architecture independent.
- Added kernel checking code to module tests.     ( Paul Larson )
- Applied 31bit emulation s390x patch to          ( Susanne Wintenberger )
  delete_module02 and query_module03.
- Fixed cleanup section of ftruncate01.           ( Robbie Williamson )
- Applied patch to gettimeofday01 to not allow    ( Andi Kleen )
  execution on x86_64 architectures.
- Added x86_64 as valid architecture for ioperm() ( Andi Kleen )
  and iopl() tests.
- Applied patch to semctl() tests to correctly    ( Anton Blanchard )
  test the ipc call.
- Removed unspecified/undocumented case from      ( Anton Blanchard )
  munlock01.
- Fixed personality02 test.                       ( Paul Larson )
- Applied MIPS specific architecture patch to     ( Chris Dearman )
  profil01.
- Removed unspecified/undocumented case from      ( Robbie Williamson )
  sendmsg01.
- Applied patch to swapoff() and swapon()         ( Jacky Malcles )
  testcases to allow correct execution on IA64
- Applied patch to sysfs01 to allow execution on  ( Susanne Wintenberger )
  64bit machines.
- Added test for ustat().                         ( Aniruddha Marathe )
- Patched float_ tests to generate datafiles      ( Robbie Williamson )
  during execution.
- Added test for iproute.                         ( Manoj Iyer )
- Added test for xinetd.                          ( Manoj Iyer )
- Added test for traceroute.                      ( Manoj Iyer )




