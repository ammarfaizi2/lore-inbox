Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbTDDV3t (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 16:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbTDDV3t (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 16:29:49 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:13533 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261300AbTDDV3q (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 16:29:46 -0500
Subject: [ANNOUNCE] The Linux Test Project ltp-20030404 released 
To: ltp-list@lists.sourceforge.net, ltp-announce@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OF607B2975.5E585DA5-ON85256CFE.0076B4F0-86256CFE.00773079@pok.ibm.com>
From: "Robert Williamson" <robbiew@us.ibm.com>
Date: Fri, 4 Apr 2003 15:41:24 -0600
X-MIMETrack: Serialize by Router on D01ML076/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 04/04/2003 04:41:01 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  The Linux Test Project test suite ltp-full-20030404.tgz has been
released.
Visit our website (http://ltp.sourceforge.net) to download the latest
version of the testsuite that contains 1000+ tests for the Linux OS.  Our
site also contains other information such as: test results, a Linux test
tools matrix, an area for keeping up with fixes for known blocking problems
in the 2.5 kernel releases, technical papers and HowTos on Linux testing,
and a code coverage analysis tool.

  Lists of test cases that are expected to fail for specific architectures
and kernels are located at: http://ltp.sourceforge.net/expected-errors.php
.
These lists also contain expected LTP compiler warnings for each
architecture and kernel.

  Highlights:

  * Stability, stability, stability! Most compiler warnings have been
resolved
    for i386, ppc32, ppc64, s390, and s390x architectures.
  * Thanks to Andreas Jaeger, Dan Kegel, and Doug Ramir for their
dedication to
    and help in increasing the stability of the LTP.

  A revised and updated LTP HowTo is in its final stages of review and
should
be available later this month.  Plus, an ncurses-type GUI is also in the
works
for inclusion into the May release.
  We encourage the community to post results, patches, or new tests on our
mailing list, and to use the CVS bug tracking facility to report problems
that you might encounter. More details available at our web-site.


CHANGELOG
---------
LTP-20030403

- Fixed CFLAGS in all makefiles to append (+=)    ( Vasan Sundar )
- Removed the outdated & poorly written           ( Robbie Williamson )
  GUI ( ltp )
- Corrected bug with -x flag in runalltests.sh    ( Robbie Williamson )
- Added additional documentation into             ( Manoj Iyer
  runalltests.sh                                    Robbie Williamson )
- MASSIVE compiler warnings cleanup.              ( Andreas Jaeger )
                                                  ( Robbie Williamson )
- Corrected library linking at build time.        ( Andreas Jaeger )
- Added descriptions to first line of all         ( Robbie Williamson )
  runtest scenarios.
- Commented out 2 cases in syslog11 test that     ( Paul Larson
  clear the dmesg buffer.                           Robbie Williamson )
- Updated fs_maim to use ext3 and reiserfs.       ( Airong Zhang )
- Removed "\n"s from testcase outputs.            ( Dan Kegel )
- Corrected direct_io tests to compile a dummy    ( Vasan Sundar )
  program if O_DIRECT is not defined & return
  TCONF.
- Changed stress_floppy to use `cp` instead of    ( Robbie Williamson )
  `ln` with its data directory.
- Applied IA64 specific patch to shmt02, shmt04,  ( Jacky Malcles )
  shmt05, shmt06, shmt07.
- Relocated the module tests to .../kernel/module ( Paul Larson )
- Removed module tests from syscalls scenario     ( Paul Larson )
  file.
- Corrected the stack management in clone tests.  ( Chris Dearman )
- Corrected the pids casting from int to pid_t    ( Jaideep Dharap )
  in fcntl17.
- Applied fix to flock03 to have the file         ( Matthew Wilcox )
  descriptor passed to the child.
- Enabled the validation section of getgroups03.  ( Robbie Williamson )
- Added code to getsid02, setpriority04, &        ( Robbie Williamson )
  wait402 to use PID_MAX_DEFAULT if PID_MAX is
  not defined.
- Fixed gettimeofday01 for gcc-3.2 quirk with     ( Andi Kleen
  x86-64.                                           Paul Larson )
- Fixed msgctl08 and msgctl09 to check for the    ( Dan Kegel )
  `ipcs` command before trying to use it.
- Added IA64 specific code to shmat01.            ( Jacky Malcles )
- Fixed problem with kill11 false failure with    ( Paul Larson )
  some compilers.
- Changed llseek tests to call lseek64.           ( Andreas Jaeger )
- Replaced calls to time() with calls to          ( Dan Kegel )
  gettimeofday() in nanosleep01 to help avoid
  race conditions.
- Removed race condtions in recv01, recvfrom01, & ( Dan Kegel )
  recvmsg01.
- Replaced setegid() call with setregid() call in ( Robbie Williamson )
  setresgid01.
- Added code to check for NR_socketcall before    ( Andi Kleen )
  executing the socketcall tests.
- Fixed swapon02 for correct execution on 2.5     ( Susanne Wintenberger )
- Fixed system specific build problem with        ( Paul Larson )
  swapon02
- Corrected the MININT section of abs01.          ( Robbie Williamson )
- Moved generate() into main.c for the float_*    ( Robbie Williamson )
  tests.
- Explicitly set the stacksize in main.c for the  ( Robbie Williamson )
  float_* tests.
- Removed optimization from building the float_*  ( Robbie Williamson )
  tests.
- Relocated netpipe-ipv6 from ipv6/tools to the   ( Robbie Williamson )
  top-level /tools directory.
- Adjusted send and receive buffers for           ( Robbie Williamson )
  sendfile01 to PATH_MAX.




