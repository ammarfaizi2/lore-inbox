Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVCGVaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVCGVaD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 16:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbVCGV2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 16:28:53 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:56973 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261781AbVCGVRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:17:52 -0500
Subject: [ANNOUNCE] March Release of LTP now available
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       ltp-list@lists.sf.net
Cc: ltp-announce@lists.sf.net
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFAC579230.20711D81-ON85256FBD.0074E0C1-86256FBD.0074FF60@us.ibm.com>
From: Marty Ridgeway <mridge@us.ibm.com>
Date: Mon, 7 Mar 2005 15:17:40 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.53IBM1 HF8|January 11, 2005) at
 03/07/2005 16:17:48
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





LTP-20050307
- Added -v option to LTP, fixed -s option
- Removed fcntl16 until testcase can be fixed/changed.
- Fix for defect 14136, growfiles expanding a file past the 2G limit on
ext2
- Applied patch from Marcus Meissner for SF bug #1114114
- Applied patch from David Miller for sigaction problems
- Applied a patch from Suzuki Kp to resolve some race/signal handling
conditions
- In adapting specific LTP tests to uClinux running on Analog Devices'
  Blackfin processor, we found a problem in mount01 where malloc was not
  reserving space for the trailing null byte and strncpy was being called
  without enough bytes to account for the trailing null byte.  The
  following patch fixes the problem
- Increased USER_PRECISION to 2200 to take into account the processes
switching time nanosleep02
- The attached patch fixes a swapon cross compile build error I ran into
  recently. I verified that RH9 self hosted and cross compile builds now
- Removed the include of <asm/atomic.h> back out.  Most distros and kernels
  can build and execute the test without it now.
- Change for defect 13778, when the /var/log/messages file is first moved,
the first write fails
- The SIGINT sighandler will set the "intinitr" flag to 1 for the children.
But if the
  "runtime" is small( a command line argument passed, the testcases were
running
  for 5 secs here), it may happen that the SIGINT may be recieved before
the
  child initialize the flag to 0, and which may lead to a hang
- Change to exclude lib6 directory from default build since it breaks
earlier Distros
- Added code to handle cases where certain distros don't define AI_V4MAPPED
in /usr/include/netdb.h


Linux Test Project
Linux Technology Center
IBM Corporation


Internet E-Mail : mridge@us.ibm.com
IBM, 11501 Burnet Rd, Austin, TX  78758
Phone (512) 838-1356 - T/L 678-1356 - Bldg. 908/1C005
Austin, TX.

