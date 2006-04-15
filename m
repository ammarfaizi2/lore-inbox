Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbWDOScq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbWDOScq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 14:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbWDOScq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 14:32:46 -0400
Received: from smtp-out.google.com ([216.239.45.12]:5909 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030309AbWDOScq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 14:32:46 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
	b=P97ZT8RWuXm6dmd6rzG27hHW0MG+RApT36pFqhigD5gWirav4wMgoehAVPKgO+4vk
	Wm1wVD6aw9EZEEXe52kaQ==
Message-ID: <44413C44.4010309@google.com>
Date: Sat, 15 Apr 2006 11:32:36 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: LTP test failures on current kernels (latest -git and -mm)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing a lot of LTP failures in current kernels. Is this just LTP
being horribly broken? Or are mailine kernels broken?

I've never been keen on it's "expected failure" model, but this does
seem to be excessive. Get very similar failures from -mm and mainline.

2.6.17-rc1-mm2: 
http://test.kernel.org/abat/27722/001.ltp.test/results/ltp.failures

2.6.17-rc1-git9:
http://test.kernel.org/abat/28423/001.ltp.test/results/ltp.failures

accept01    1  FAIL  :  bad file descriptor ; returned -454050240 
(expected -1), errno 0 (expected 9)
capset02    4  BROK  :  Unexpected signal 15 received.
clone06     0  WARN  :  sprintf() failed
clone06     1  BROK  :  Unexpected signal 11 received.
connect01    1  FAIL  :  bad file descriptor ; returned -435334536 
(expected -1), errno 0 (expected 9)
dup06       1  FAIL  :  Not enough files duped
dup06       2  FAIL  :  Test failed.
fcntl23     1  FAIL  :  fcntl(tfile_15730, F_SETLEASE,F_RDLCK) Failed, 
errno=11 : Resource temporarily unavailable
getdtablesize01    2  FAIL  :  0 != 1023
getpeername01    1  FAIL  :  bad file descriptor ; returned -1209263248 
(expected -1), errno 0 (expected 9)
getsockname01    1  FAIL  :  bad file descriptor ; returned -1209283664 
(expected -1), errno 0 (expected 9)
getsockopt01    1  FAIL  :  bad file descriptor ; returned -457777152 
(expected -1), errno 0 (expected 9)
ioperm02    1  FAIL  :  Unexpected results for Invalid I/O address ; 
returned 0 (expected -1), errno 0 (expected errno  22)
kill05      0  INFO  :  WARNING: shared memory deletion failed.
listen01    1  FAIL  :  bad file descriptor ; returned 0 (expected -1), 
errno 0 (expected 9)
mlockall02    1  CONF  :  mlockall02 did not FAIL as expected.This may 
be okay if you are running Red Hat Enterprise Linux 3 (RHEL)
mlockall02    2  CONF  :  mlockall02 did not FAIL as expected.This may 
be okay if you are running Red Hat Enterprise Linux 3 (RHEL)
mincore01    4  FAIL  :  call succeeded unexpectedly
recvmsg01    1  FAIL  :  bad file descriptor ; returned -1056444352 
(expected -1), errno 0 (expected 9)
sendmsg01    1  FAIL  :  bad file descriptor ; returned -1 (expected 
-1), errno 14 (expected 9)
setitimer01    1  FAIL  :  old timer value is not equal to expected value
setregid02    7  FAIL  :  setregid(65535, -1) failed (1) but did not set 
the expected errno (22).
setregid02    8  FAIL  :  setregid(-1, 65535) failed (1) but did not set 
the expected errno (22).
setsockopt01    1  FAIL  :  bad file descriptor ; returned 13 (expected 
-1), errno 0 (expected 9)
socket01    4  FAIL  :  raw open as non-root ; returned -1 (expected 
-1), errno 93 (expected 94)
socket01    6  FAIL  :  UDP stream ; returned -1 (expected -1), errno 93 
(expected 94)
socket01    7  FAIL  :  TCP dgram ; returned -1 (expected -1), errno 93 
(expected 94)
socket01    9  FAIL  :  ICMP stream ; returned -1 (expected -1), errno 
93 (expected 94)
socketpair01    4  FAIL  :  raw open as non-root ; returned -1 (expected 
-1), errno 93 (expected 94)
socketpair01    8  FAIL  :  TCP dgram ; returned -1 (expected -1), errno 
93 (expected 94)
socketpair01   10  FAIL  :  ICMP stream ; returned -1 (expected -1), 
errno 93 (expected 94)
writev03    1  FAIL  :  Got error EFAULT
writev03    0  INFO  :  block 1 FAILED
writev03    2  FAIL  :  Got error EFAULT
writev03    0  INFO  :  block 2 FAILED
writev03    3  FAIL  :  Got error EFAULT
writev03    0  INFO  :  block 3 FAILED
writev04    1  FAIL  :  Got error EFAULT
writev04    0  INFO  :  block 1 FAILED
writev04    2  FAIL  :  Got error EFAULT
writev04    0  INFO  :  block 2 FAILED
writev04    3  FAIL  :  Got error EFAULT
writev04    0  INFO  :  block 3 FAILED
INFO: pan reported some tests FAIL
