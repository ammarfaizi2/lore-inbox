Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266294AbUAHUjK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 15:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266297AbUAHUjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 15:39:10 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:21500 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266294AbUAHUi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 15:38:56 -0500
Subject: [ANNOUNCE] Linux Test Project January Release Announcement
To: ltp-announce@lists.sf.net, linux-kernel@vger.kernel.org
Cc: ltp-list@lists.sf.net
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OFB0171B6C.51DD6DFB-ON85256E15.006CF23A-86256E15.007197FF@us.ibm.com>
From: Robert Williamson <robbiew@us.ibm.com>
Date: Thu, 8 Jan 2004 14:37:59 -0600
X-MIMETrack: Serialize by Router on D01ML076/01/M/IBM(Release 6.0.2CF2 IGS_HF11|December
 1, 2003) at 01/08/2004 15:38:35
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Test Project test suite <http://www.linuxtestproject.org> has
been released. The latest version of the testsuite contains 2100+ tests
for the Linux OS. Our web site also contains other information such as:
test results, a Linux test tools matrix, technical papers and HowTos on
Linux testing, and a code coverage analysis tool.

Developers from the Linux Test Project co-authored the whitepaper,
"Putting Linux Reliability to the Test".  This article documents the
test results and analysis of the Linux kernel and other core OS
components, including everything from libraries and device drivers to
file systems and networking, all under some fairly adverse conditions,
over a period of 60 days. You can find the paper at:
http://www.ibm.com/developerworks/linux/library/l-rel

Release Highlights:

      * Code cleanups by Erik Andersen, Glen Foster, Jay Turner, and
        Ming Gao.

      * Removal of a memory leak in one of the test harness libraries
        by Randy Hron.

      * Improvements to allow tests to build and execute under more
        environments and distributions.

We encourage the community to post results to ltp-results@lists.sf.net,
and patches, new tests, or comments/questions to ltp-list@lists.sf.net.

See ChangeLog below.
-Robbie

Robert V. Williamson <robbiew@us.ibm.com>
Linux Test Project
IBM Linux Technology Center
Web: http://ltp.sourceforge.net
IRC: #ltp on freenode.irc.net
====================
"Only two things are infinite, the universe and human stupidity, and I'm
not sure about the former." -Albert Einstein

LTP-20030108
- Fixed broken -l option in runalltests.sh.     ( Paul Larson )
- Fixed netpipe typo in runalltests.sh.         ( Paul Larson )
- Fixed memory leak in parse_opts.c library.    ( Randy Hron )
- Removed personality() system call tests from  ( Robbie Williamson )
  the runalltests.sh and ltpstress.sh scripts.
- Cleaned up file_test.sh for improved          ( Glen Foster )
  execution.
- Cleaned up mail_tests.sh for improved         ( Glen Foster )
  execution.
- Fixed the direct I/O tests to correctly       ( Robbie Williamson )
  check if direct I/O is supported on the tested
  filesystem.
- Fixed a typo and correct return value in      ( Jay Turner )
  clone07.c.
- Fixed coding error in getcwd03.c.             ( Erik Andersen )
- Fixed problem of incorrect use of fclose(),   ( Erik Andersen )
  instead of pclose() in msgctl08.c and
  msgctl09.c.
- Removed usmblks test from mallopt01.c.        ( Erik Andersen )
- Updated the modify_ldt() tests to build       ( Robbie Williamson )
  according to what struct is defined in
  asm/ldt.h: user_desc or modify_ldt_ldt_s
- Updated pipe07.c to check the number of used  ( Robbie Williamson )
  file descriptors and adjust itself accordingly
  before executing.
- Updated sendfile03 to allow for situations    ( Robbie Williamson )
  where the execution environment has more than
  STDIN, STDOUT, and STDERR in use.
- Removed assumptions about the width of a uid_t( Erik Andersen )
  and gid_t in the setregid02.c, setresuid03.c,
  and setreuid06.c.
- Fixed string01.c to not expect implementation ( Erik Andersen )
  specific results.
- Updated swapon02.c to build in environments   ( Robbie Williamson )
  where MAX_SWAPFILES must be specified.
- Updated mc_cmds and tcpdump01 to handle       ( Ming Gao )
  multiple interfaces better.

