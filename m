Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWGQWmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWGQWmZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 18:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWGQWmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 18:42:25 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:17625 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751096AbWGQWmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 18:42:24 -0400
Message-ID: <44BC124D.4050607@vnet.ibm.com>
Date: Mon, 17 Jul 2006 17:42:21 -0500
From: Michael Reed <mreedltp@vnet.ibm.com>
Reply-To: mreedltp@vnet.ibm.com
User-Agent: Mozilla Thunderbird 1.0.8-1.4.1 (X11/20060420)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ltp-list@lists.sourceforge.net, ltp-announce@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [ANNOUNCE]  The Linux Test project ltp-20060717 Released
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Test Project test suite <http://www.linuxtestproject.org> has 
been released. The latest version of the testsuite contains 2900+ tests  
for the Linux   OS. Our web site also contains other information such as:
- A Linux test tools matrix
- Technical papers
- How To's on Linux testing
- Code coverage analysis tool.

Release Highlights:

* Code Cleanups by Will Newton, Jacky Malcles, Andy Echols, Amit K. 
Amora, Mike  
   Frysinger, Mitsuru Chinen, and Liang Shuang

We encourage the community to post results to ltp-results@lists.sf.net, 
and patches, new tests, or comments/questions to ltp-list@lists.sf.net

See ChangeLog Below

LTP-20060717
 - The tarball default-tests.tar.gz is a replacement for
   testcases/pounder21/default-tests.tar.gz.  This new pounder config
   enables the magic sysrq key when pounder starts.  

 - A patch submitted by Derek Wong to reduce the memory requirements of
   pounder's ramsnake test.

 - A patch submitted by Will Newton that allows for compatibility changes
   gcc 2.95.2 in th following files:

     lib.c, lib64.c, test.c, test64.c, test_func.c, test_func64.c, tools.c

 - Fixed ColdFire Makefile mistake in the syscall and syscalls/mmap 
directory

 - Added a note for uClinux users in the top level Makefile

 - A fix for failures in fcntl27 and fcntl28 for bugs 21614 and 23235.

 - A fix submitted for make_tree.c by Jacky Malcles that fixes this
   testcase by setting envp
  
 - A fix submitted to Jacky Malcles that fixes read_checkzero.c.  The lseek
   function allows the file offset to be set beyond the end of the existing
   end-of-file of the file.  If data is later written at this point,
   subsequent reads of the data is in the gap returns bytes of zeros until
   data is actually written into the gap.

 - In the testcase semget05.c the value of MAXIDS was changed for the 
specific
   machine by reading the system limit for SEMMNI - The maximum number of
   semaphore sets. This is a fix for bug 24745

 - A fix submitted by Amit K. Amora that initializes the alarm received
   code and allows the test to pass more than just once on 2.6.17-rc6
   alarm05.c,

 - A fix was submitted by Andy Echols for pan.c to fix an infinite
   loop problem that occurs  in pan if runltp tries to run a test
   that isn't present.

 - A fix was submitted to cast TEST_RETURN to gid_t to avoid implicit casts
   which tend to cause problems with the testcase  setregid03.c,

 - A patch submitted by Jacky Malcles that fixes the problem where
   i0_getevents() return value is not checked and may return 0 if
   no events are available and may generate a SIGSEGV in the testcase
   aiodio_append.c,

 - Backed out the _USC_LIB change for several Makefiles because it was
   breaking on the PowerPc platform on Fedora Core

 - Added code to ignore looking for PID_MAX on powerpc, s390, and i386 to
   fix build problems on newer kernel versions on the following files:

  sysctl05.c, setpriority04.c sysfs01.c, sysfs02.c, sysfs03.c, sysfs04.c,
  sysfs06. getdents01.c, sysctl03.c getsid02.c, sysctl01.c,wait402.c

 - TCP.c was changed to delete broken whitespace and also the call for
   accept(2) takes a socklen_t, not an int

 - Changes were added to the following files to use memset() instead of
   bzero():

   tlibio.c, write_log.c, doio.c, iogen.c, fsstress.c, fsx-linux.c,
   pthcli.c, pthserv.c, pth_str01.c, pth_str03.c, recvmsg01.c, sendmsg01.c,
   crash01.c, crash02.c, pingpong6.c, test_getname.c, fancy_timed_loop.c,
   infinite_loop.c, run.c, timed_loop.c, snake.c, rpc1.c, pipeio.c, 
mc_recv.c

 - Changes were added to the following files to use memcpy() instead of
    bcopy():
   
    serverCommunication.cpp, member.c, rpc1.c,pipeio.c,mc_recv.c

- A change submitted by Liang Shuang that fixes su01_su for the arm
  architecture

- A series of  patches created by Mitsuru Chinen that  created some 
addtional
  network stress tests.
