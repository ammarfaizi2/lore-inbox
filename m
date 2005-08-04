Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262686AbVHDU7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbVHDU7V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 16:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbVHDU5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 16:57:31 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:19408 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262686AbVHDU5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 16:57:15 -0400
Subject: [ANNOUNCE]  August LTP now available
To: linux-kernel@vger.kernel.org, ltp-list@lists.sf.net,
       ltp-announce@lists.sf.net
X-Mailer: Lotus Notes Release 6.5.3 September 14, 2004
Message-ID: <OFF6BFA212.F8EA15DC-ON85257053.0072FBB8-86257053.0073148D@us.ibm.com>
From: Marty Ridgeway <mridge@us.ibm.com>
Date: Thu, 4 Aug 2005 15:57:11 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.53IBM1 HF14|April 18, 2005) at
 08/04/2005 16:57:12
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeLog:

LTP-20050804
- Applied fix from Greg Edwards for 64bit execution.
- self_exec magic required to run child functions on uClinux
- Applied patch from Mike Frysinger:trying to do a build on uClibc will
abort in lib/tlibio.c because we dont
  provide aio.h find attached a patch which updates the check to include
UCLIBC alongside
  UCLINUX
- remove call to create.sh script that checks for obscure c++ rpms
- remove all references to and creation of non-std /usr/local/bin/perl5
- fix ballista.cpp to not core dump with std c++ lib
- fix to add librt to MakefileTarget for running aio_suspend test:missing
clock_gettime on linux
- remove printf.h and stdio.h from testcases/commands/ade/ld/rd1.c.
- Change to fix the addition of 2 minutes without going over 60 for the
seconds
- patch to fix up the install target in disktest to match the install
targets of everything else
- patch to fix writetest Makefile to not always rebuild the writetest
binary
  regardless of whether you ran `make` or `make install` or whatever
- newer toolchains complain about redefining 'log' since it's a math
function
  provided by the libc find attached a simple patch to rename the 'log'
variable in
  testcases/kernel/ipc/ipc_stress/message_queue_test_04.c to 'logit'
- when running make in silent mode (make -s) the verbose mode of AR 'gets
in the
  way' attached patch drops the -v and adds -c so that ar wont display the
'ar:
  creating blah.a' message either
- the current mallocstress.c emits a warning about newsize being used
  uninitialized because gcc doesnt detect the abort(0) path
  find attached a simple patch to prevent the warning from being issued
- Running nptl01 can fail if the test lasts longer than 300 seconds, patch
to lower interations to 100000.
- Fixed clone04 to return correct failure code.

Marty Ridgeway
Linux Test Project
Linux Technology Center
IBM Corporation

Internet E-Mail : mridge@us.ibm.com
IBM, 11501 Burnet Rd, Austin, TX  78758
Phone (512) 838-1356 - T/L 678-1356 - Bldg. 908/1C005
Austin, TX.

