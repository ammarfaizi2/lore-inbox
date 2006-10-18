Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWJRKug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWJRKug (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 06:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWJRKug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 06:50:36 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:62704 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751461AbWJRKuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 06:50:35 -0400
Message-ID: <453605F7.7000605@cn.ibm.com>
Date: Wed, 18 Oct 2006 18:46:15 +0800
From: Yi CDL Yang <yyangcdl@cn.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: [RT-Tester Question]: rt-tester always says Pass no matter the kernel
 supports RT or not
X-MIMETrack: Itemize by SMTP Server on D23M0037/23/M/IBM(Release 7.0HF124 | January 12, 2006) at
 10/18/2006 18:53:26,
	Serialize by Router on D23M0037/23/M/IBM(Release 7.0HF124 | January 12, 2006) at
 10/18/2006 18:53:28,
	Serialize complete at 10/18/2006 18:53:28
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=GB2312
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ingo

When I run rt-tester, it always says "Pass" although the kernel is
2.6.16, can you explain how to decide it is failed or successful.


The following is all the output of rt-test on 2.6.16:


C: resetevent:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
# Set schedulers
C: schedfifo:		0: 	80
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
C: schedfifo:		1: 	80
/sys/devices/system/rttest/rttest1/command
W: opcodeeq:		1: 	0
/sys/devices/system/rttest/rttest1/status
# T0 lock L0
C: locknowait:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: locked:		0: 	0
/sys/devices/system/rttest/rttest0/status
# T1 lock L1
C: locknowait:		1:	1
/sys/devices/system/rttest/rttest1/command
W: locked:		1: 	1
/sys/devices/system/rttest/rttest1/status
# T0 lock L1
C: lockintnowait:	0: 	1
/sys/devices/system/rttest/rttest0/command
W: blocked:		0: 	1
/sys/devices/system/rttest/rttest0/status
# T1 lock L0
C: lockintnowait:	1: 	0
/sys/devices/system/rttest/rttest1/command
W: blocked:		1: 	0
/sys/devices/system/rttest/rttest1/status
# Make deadlock go away
C: signal:		1:	0
/sys/devices/system/rttest/rttest1/command
W: unlocked:		1:	0
/sys/devices/system/rttest/rttest1/status
C: signal:		0:	0
/sys/devices/system/rttest/rttest0/command
W: unlocked:		0:	1
/sys/devices/system/rttest/rttest0/status
# Unlock and exit
C: unlock:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: unlocked:		0: 	0
/sys/devices/system/rttest/rttest0/status
C: unlock:		1: 	1
/sys/devices/system/rttest/rttest1/command
W: unlocked:		1: 	1
/sys/devices/system/rttest/rttest1/status
Pass
C: resetevent:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
# Set schedulers
C: schedother:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
C: schedfifo:		1: 	81
/sys/devices/system/rttest/rttest1/command
W: opcodeeq:		1: 	0
/sys/devices/system/rttest/rttest1/status
C: schedfifo:		2: 	82
/sys/devices/system/rttest/rttest2/command
W: opcodeeq:		2: 	0
/sys/devices/system/rttest/rttest2/status
# T0 lock L0
C: locknowait:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: locked:		0: 	0
/sys/devices/system/rttest/rttest0/status
# T1 lock L0
C: locknowait:		1: 	0
/sys/devices/system/rttest/rttest1/command
W: blocked:		1: 	0
/sys/devices/system/rttest/rttest1/status
T: prioeq:		0: 	81
/sys/devices/system/rttest/rttest0/status
# T2 lock L0
C: locknowait:		2: 	0
/sys/devices/system/rttest/rttest2/command
W: blocked:		2: 	0
/sys/devices/system/rttest/rttest2/status
T: prioeq:		0: 	82
/sys/devices/system/rttest/rttest0/status
T: prioeq:		1:	81
/sys/devices/system/rttest/rttest1/status
# T0 unlock L0
C: unlock:		0: 	0
/sys/devices/system/rttest/rttest0/command
# Wait until T2 got the lock
W: locked:		2: 	0
/sys/devices/system/rttest/rttest2/status
W: unlocked:		0:	0
/sys/devices/system/rttest/rttest0/status
T: priolt:		0:	1
/sys/devices/system/rttest/rttest0/status
# T2 unlock L0
C: unlock:		2: 	0
/sys/devices/system/rttest/rttest2/command
W: unlocked:		2: 	0
/sys/devices/system/rttest/rttest2/status
W: locked:		1: 	0
/sys/devices/system/rttest/rttest1/status
C: unlock:		1: 	0
/sys/devices/system/rttest/rttest1/command
W: unlocked:		1: 	0
/sys/devices/system/rttest/rttest1/status
Pass
C: resetevent:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
# Set schedulers
C: schedother:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
C: schedfifo:		1: 	80
/sys/devices/system/rttest/rttest1/command
W: opcodeeq:		1: 	0
/sys/devices/system/rttest/rttest1/status
# T0 lock L0
C: locknowait:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: locked:		0: 	0
/sys/devices/system/rttest/rttest0/status
# T1 lock L0
C: locknowait:		1: 	0
/sys/devices/system/rttest/rttest1/command
W: blocked:		1: 	0
/sys/devices/system/rttest/rttest1/status
T: prioeq:		0: 	80
/sys/devices/system/rttest/rttest0/status
# T0 unlock L0
C: unlock:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: locked:		1: 	0
/sys/devices/system/rttest/rttest1/status
# Verify T1
W: unlocked:		0: 	0
/sys/devices/system/rttest/rttest0/status
T: priolt:		0: 	1
/sys/devices/system/rttest/rttest0/status
# Unlock and exit
C: unlock:		1: 	0
/sys/devices/system/rttest/rttest1/command
W: unlocked:		1: 	0
/sys/devices/system/rttest/rttest1/status
Pass
C: resetevent:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
# Set schedulers
C: schedother:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
C: schedfifo:		1: 	80
/sys/devices/system/rttest/rttest1/command
W: opcodeeq:		1: 	0
/sys/devices/system/rttest/rttest1/status
C: schedfifo:		2: 	81
/sys/devices/system/rttest/rttest2/command
W: opcodeeq:		2: 	0
/sys/devices/system/rttest/rttest2/status
# T0 lock L0
C: lock:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: locked:		0: 	0
/sys/devices/system/rttest/rttest0/status
# T1 lock L0
C: lock:		1: 	0
/sys/devices/system/rttest/rttest1/command
W: blocked:		1: 	0
/sys/devices/system/rttest/rttest1/status
T: prioeq:		0: 	80
/sys/devices/system/rttest/rttest0/status
# T0 unlock L0
C: unlock:		0: 	0
/sys/devices/system/rttest/rttest0/command
# Wait until T1 is in the wakeup loop
W: blockedwake:		1: 	0
/sys/devices/system/rttest/rttest1/status
T: priolt:		0: 	1
/sys/devices/system/rttest/rttest0/status
# T2 lock L0
C: lock:		2: 	0
/sys/devices/system/rttest/rttest2/command
# T1 leave wakeup loop
C: lockcont:		1: 	0
/sys/devices/system/rttest/rttest1/command
# T2 must have the lock and T1 must be blocked
W: locked:		2: 	0
/sys/devices/system/rttest/rttest2/status
W: blocked:		1: 	0
/sys/devices/system/rttest/rttest1/status
# T2 unlock L0
C: unlock:		2: 	0
/sys/devices/system/rttest/rttest2/command
# Wait until T1 is in the wakeup loop and let it run
W: blockedwake:		1: 	0
/sys/devices/system/rttest/rttest1/status
C: lockcont:		1: 	0
/sys/devices/system/rttest/rttest1/command
W: locked:		1: 	0
/sys/devices/system/rttest/rttest1/status
C: unlock:		1: 	0
/sys/devices/system/rttest/rttest1/command
W: unlocked:		1: 	0
/sys/devices/system/rttest/rttest1/status
Pass
C: resetevent:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
# Set schedulers
C: schedother:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
C: schedother:		1: 	0
/sys/devices/system/rttest/rttest1/command
W: opcodeeq:		1: 	0
/sys/devices/system/rttest/rttest1/status
C: schedfifo:		2: 	82
/sys/devices/system/rttest/rttest2/command
W: opcodeeq:		2: 	0
/sys/devices/system/rttest/rttest2/status
C: schedfifo:		3: 	83
/sys/devices/system/rttest/rttest3/command
W: opcodeeq:		3: 	0
/sys/devices/system/rttest/rttest3/status
# T0 lock L0
C: locknowait:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: locked:		0: 	0
/sys/devices/system/rttest/rttest0/status
# T1 lock L1
C: locknowait:		1: 	1
/sys/devices/system/rttest/rttest1/command
W: locked:		1: 	1
/sys/devices/system/rttest/rttest1/status
# T3 lock L0
C: lockintnowait:	3: 	0
/sys/devices/system/rttest/rttest3/command
W: blocked:		3: 	0
/sys/devices/system/rttest/rttest3/status
T: prioeq:		0: 	83
/sys/devices/system/rttest/rttest0/status
# T0 lock L1
C: lock:		0: 	1
/sys/devices/system/rttest/rttest0/command
W: blocked:		0: 	1
/sys/devices/system/rttest/rttest0/status
T: prioeq:		1: 	83
/sys/devices/system/rttest/rttest1/status
# T1 unlock L1
C: unlock:		1:	1
/sys/devices/system/rttest/rttest1/command
# Wait until T0 is in the wakeup code
W: blockedwake:		0:	1
/sys/devices/system/rttest/rttest0/status
# Verify that T1 is unboosted
W: unlocked:		1: 	1
/sys/devices/system/rttest/rttest1/status
T: priolt:		1: 	1
/sys/devices/system/rttest/rttest1/status
# T2 lock L1 (T0 is boosted and pending owner !)
C: locknowait:		2:	1
/sys/devices/system/rttest/rttest2/command
W: blocked:		2: 	1
/sys/devices/system/rttest/rttest2/status
T: prioeq:		0: 	83
/sys/devices/system/rttest/rttest0/status
# Interrupt T3 and wait until T3 returned
C: signal:		3:	0
/sys/devices/system/rttest/rttest3/command
W: unlocked:		3:	0
/sys/devices/system/rttest/rttest3/status
# Verify prio of T0 (still pending owner,
# but T2 is enqueued due to the previous boost by T3
T: prioeq:		0:	82
/sys/devices/system/rttest/rttest0/status
# Let T0 continue
C: lockcont:		0:	1
/sys/devices/system/rttest/rttest0/command
W: locked:		0:	1
/sys/devices/system/rttest/rttest0/status
# Unlock L1 and let T2 get L1
C: unlock:		0:	1
/sys/devices/system/rttest/rttest0/command
W: locked:		2:	1
/sys/devices/system/rttest/rttest2/status
# Verify that T0 is unboosted
W: unlocked:		0:	1
/sys/devices/system/rttest/rttest0/status
T: priolt:		0:	1
/sys/devices/system/rttest/rttest0/status
# Unlock everything and exit
C: unlock:		2:	1
/sys/devices/system/rttest/rttest2/command
W: unlocked:		2:	1
/sys/devices/system/rttest/rttest2/status
C: unlock:		0:	0
/sys/devices/system/rttest/rttest0/command
W: unlocked:		0:	0
/sys/devices/system/rttest/rttest0/status
Pass
C: resetevent:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
# Set schedulers
C: schedfifo:		0: 	80
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
C: schedfifo:		1: 	81
/sys/devices/system/rttest/rttest1/command
W: opcodeeq:		1: 	0
/sys/devices/system/rttest/rttest1/status
C: schedfifo:		2: 	82
/sys/devices/system/rttest/rttest2/command
W: opcodeeq:		2: 	0
/sys/devices/system/rttest/rttest2/status
# T0 lock L0
C: locknowait:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: locked:		0: 	0
/sys/devices/system/rttest/rttest0/status
# T1 lock L0
C: locknowait:		1: 	0
/sys/devices/system/rttest/rttest1/command
W: blocked:		1: 	0
/sys/devices/system/rttest/rttest1/status
T: prioeq:		0: 	81
/sys/devices/system/rttest/rttest0/status
# T2 lock L0
C: locknowait:		2: 	0
/sys/devices/system/rttest/rttest2/command
W: blocked:		2: 	0
/sys/devices/system/rttest/rttest2/status
T: prioeq:		0: 	82
/sys/devices/system/rttest/rttest0/status
# T0 unlock L0
C: unlock:		0: 	0
/sys/devices/system/rttest/rttest0/command
# Wait until T2 got the lock
W: locked:		2: 	0
/sys/devices/system/rttest/rttest2/status
W: unlocked:		0:	0
/sys/devices/system/rttest/rttest0/status
T: prioeq:		0:	80
/sys/devices/system/rttest/rttest0/status
# T2 unlock L0
C: unlock:		2: 	0
/sys/devices/system/rttest/rttest2/command
W: locked:		1: 	0
/sys/devices/system/rttest/rttest1/status
W: unlocked:		2: 	0
/sys/devices/system/rttest/rttest2/status
C: unlock:		1: 	0
/sys/devices/system/rttest/rttest1/command
W: unlocked:		1: 	0
/sys/devices/system/rttest/rttest1/status
Pass
C: resetevent:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
# Set schedulers
C: schedother:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
C: schedfifo:		1: 	81
/sys/devices/system/rttest/rttest1/command
W: opcodeeq:		1: 	0
/sys/devices/system/rttest/rttest1/status
C: schedfifo:		2: 	82
/sys/devices/system/rttest/rttest2/command
W: opcodeeq:		2: 	0
/sys/devices/system/rttest/rttest2/status
C: schedfifo:		3: 	83
/sys/devices/system/rttest/rttest3/command
W: opcodeeq:		3: 	0
/sys/devices/system/rttest/rttest3/status
C: schedfifo:		4: 	84
/sys/devices/system/rttest/rttest4/command
W: opcodeeq:		4: 	0
/sys/devices/system/rttest/rttest4/status
# T0 lock L0
C: locknowait:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: locked:		0: 	0
/sys/devices/system/rttest/rttest0/status
# T1 lock L1
C: locknowait:		1: 	1
/sys/devices/system/rttest/rttest1/command
W: locked:		1: 	1
/sys/devices/system/rttest/rttest1/status
# T1 lock L0
C: lockintnowait:	1: 	0
/sys/devices/system/rttest/rttest1/command
W: blocked:		1: 	0
/sys/devices/system/rttest/rttest1/status
T: prioeq:		0: 	81
/sys/devices/system/rttest/rttest0/status
# T2 lock L2
C: locknowait:		2: 	2
/sys/devices/system/rttest/rttest2/command
W: locked:		2: 	2
/sys/devices/system/rttest/rttest2/status
# T2 lock L1
C: lockintnowait:	2: 	1
/sys/devices/system/rttest/rttest2/command
W: blocked:		2: 	1
/sys/devices/system/rttest/rttest2/status
T: prioeq:		0: 	82
/sys/devices/system/rttest/rttest0/status
T: prioeq:		1:	82
/sys/devices/system/rttest/rttest1/status
# T3 lock L3
C: locknowait:		3: 	3
/sys/devices/system/rttest/rttest3/command
W: locked:		3: 	3
/sys/devices/system/rttest/rttest3/status
# T3 lock L2
C: lockintnowait:	3: 	2
/sys/devices/system/rttest/rttest3/command
W: blocked:		3: 	2
/sys/devices/system/rttest/rttest3/status
T: prioeq:		0: 	83
/sys/devices/system/rttest/rttest0/status
T: prioeq:		1:	83
/sys/devices/system/rttest/rttest1/status
T: prioeq:		2:	83
/sys/devices/system/rttest/rttest2/status
# T4 lock L3
C: lockintnowait:	4:	3
/sys/devices/system/rttest/rttest4/command
W: blocked:		4: 	3
/sys/devices/system/rttest/rttest4/status
T: prioeq:		0: 	84
/sys/devices/system/rttest/rttest0/status
T: prioeq:		1:	84
/sys/devices/system/rttest/rttest1/status
T: prioeq:		2:	84
/sys/devices/system/rttest/rttest2/status
T: prioeq:		3:	84
/sys/devices/system/rttest/rttest3/status
# Signal T4
C: signal:		4: 	0
/sys/devices/system/rttest/rttest4/command
W: unlocked:		4: 	3
/sys/devices/system/rttest/rttest4/status
T: prioeq:		0: 	83
/sys/devices/system/rttest/rttest0/status
T: prioeq:		1:	83
/sys/devices/system/rttest/rttest1/status
T: prioeq:		2:	83
/sys/devices/system/rttest/rttest2/status
T: prioeq:		3:	83
/sys/devices/system/rttest/rttest3/status
# Signal T3
C: signal:		3: 	0
/sys/devices/system/rttest/rttest3/command
W: unlocked:		3: 	2
/sys/devices/system/rttest/rttest3/status
T: prioeq:		0: 	82
/sys/devices/system/rttest/rttest0/status
T: prioeq:		1:	82
/sys/devices/system/rttest/rttest1/status
T: prioeq:		2:	82
/sys/devices/system/rttest/rttest2/status
# Signal T2
C: signal:		2: 	0
/sys/devices/system/rttest/rttest2/command
W: unlocked:		2: 	1
/sys/devices/system/rttest/rttest2/status
T: prioeq:		0: 	81
/sys/devices/system/rttest/rttest0/status
T: prioeq:		1:	81
/sys/devices/system/rttest/rttest1/status
# Signal T1
C: signal:		1: 	0
/sys/devices/system/rttest/rttest1/command
W: unlocked:		1: 	0
/sys/devices/system/rttest/rttest1/status
T: priolt:		0: 	1
/sys/devices/system/rttest/rttest0/status
# Unlock and exit
C: unlock:		3:	3
/sys/devices/system/rttest/rttest3/command
C: unlock:		2:	2
/sys/devices/system/rttest/rttest2/command
C: unlock:		1:	1
/sys/devices/system/rttest/rttest1/command
C: unlock:		0:	0
/sys/devices/system/rttest/rttest0/command
W: unlocked:		3:	3
/sys/devices/system/rttest/rttest3/status
W: unlocked:		2:	2
/sys/devices/system/rttest/rttest2/status
W: unlocked:		1:	1
/sys/devices/system/rttest/rttest1/status
W: unlocked:		0:	0
/sys/devices/system/rttest/rttest0/status
Pass
C: resetevent:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
# Set priorities
C: schedother:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
C: schedfifo:		1: 	80
/sys/devices/system/rttest/rttest1/command
W: opcodeeq:		1: 	0
/sys/devices/system/rttest/rttest1/status
C: schedfifo:		2: 	81
/sys/devices/system/rttest/rttest2/command
W: opcodeeq:		2: 	0
/sys/devices/system/rttest/rttest2/status
# T0 lock L0
C: lock:		0:	0
/sys/devices/system/rttest/rttest0/command
W: locked:		0: 	0
/sys/devices/system/rttest/rttest0/status
# T1 lock L0, no wait in the wakeup path
C: locknowait:		1: 	0
/sys/devices/system/rttest/rttest1/command
W: blocked:		1: 	0
/sys/devices/system/rttest/rttest1/status
T: prioeq:		0:	80
/sys/devices/system/rttest/rttest0/status
# T2 lock L0 interruptible, no wait in the wakeup path
C: lockintnowait:	2:	0
/sys/devices/system/rttest/rttest2/command
W: blocked:		2: 	0
/sys/devices/system/rttest/rttest2/status
T: prioeq:		0:	81
/sys/devices/system/rttest/rttest0/status
# Interrupt T2
C: signal:		2:	2
/sys/devices/system/rttest/rttest2/command
W: unlocked:		2:	0
/sys/devices/system/rttest/rttest2/status
T: prioeq:		0:	80
/sys/devices/system/rttest/rttest0/status
T: locked:		0:	0
/sys/devices/system/rttest/rttest0/status
T: blocked:		1:	0
/sys/devices/system/rttest/rttest1/status
# T0 unlock L0
C: unlock:		0: 	0
/sys/devices/system/rttest/rttest0/command
# Wait until T1 has locked L0 and exit
W: locked:		1:	0
/sys/devices/system/rttest/rttest1/status
W: unlocked:		0: 	0
/sys/devices/system/rttest/rttest0/status
T: priolt:		0:	1
/sys/devices/system/rttest/rttest0/status
C: unlock:		1: 	0
/sys/devices/system/rttest/rttest1/command
W: unlocked:		1: 	0
/sys/devices/system/rttest/rttest1/status
Pass
C: resetevent:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
# Set schedulers
C: schedfifo:		0: 	80
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
C: schedfifo:		1: 	80
/sys/devices/system/rttest/rttest1/command
W: opcodeeq:		1: 	0
/sys/devices/system/rttest/rttest1/status
# T0 lock L0
C: locknowait:		0: 	0
/sys/devices/system/rttest/rttest0/command
C: locknowait:		1:	0
/sys/devices/system/rttest/rttest1/command
W: locked:		0: 	0
/sys/devices/system/rttest/rttest0/status
W: blocked:		1: 	0
/sys/devices/system/rttest/rttest1/status
T: prioeq:		0: 	80
/sys/devices/system/rttest/rttest0/status
# T0 unlock L0
C: unlock:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: locked:		1: 	0
/sys/devices/system/rttest/rttest1/status
# Verify T0
W: unlocked:		0: 	0
/sys/devices/system/rttest/rttest0/status
T: prioeq:		0: 	80
/sys/devices/system/rttest/rttest0/status
# Unlock
C: unlock:		1: 	0
/sys/devices/system/rttest/rttest1/command
W: unlocked:		1: 	0
/sys/devices/system/rttest/rttest1/status
# T1,T0 lock L0
C: locknowait:		1: 	0
/sys/devices/system/rttest/rttest1/command
C: locknowait:		0:	0
/sys/devices/system/rttest/rttest0/command
W: locked:		1: 	0
/sys/devices/system/rttest/rttest1/status
W: blocked:		0: 	0
/sys/devices/system/rttest/rttest0/status
T: prioeq:		1: 	80
/sys/devices/system/rttest/rttest1/status
# T1 unlock L0
C: unlock:		1: 	0
/sys/devices/system/rttest/rttest1/command
W: locked:		0: 	0
/sys/devices/system/rttest/rttest0/status
# Verify T1
W: unlocked:		1: 	0
/sys/devices/system/rttest/rttest1/status
T: prioeq:		1: 	80
/sys/devices/system/rttest/rttest1/status
# Unlock and exit
C: unlock:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: unlocked:		0: 	0
/sys/devices/system/rttest/rttest0/status
Pass
C: resetevent:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
# Set schedulers
C: schedother:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
C: schedother:		1: 	0
/sys/devices/system/rttest/rttest1/command
W: opcodeeq:		1: 	0
/sys/devices/system/rttest/rttest1/status
C: schedfifo:		2: 	82
/sys/devices/system/rttest/rttest2/command
W: opcodeeq:		2: 	0
/sys/devices/system/rttest/rttest2/status
# T0 lock L0
C: locknowait:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: locked:		0: 	0
/sys/devices/system/rttest/rttest0/status
# T1 lock L0
C: locknowait:		1: 	0
/sys/devices/system/rttest/rttest1/command
W: blocked:		1: 	0
/sys/devices/system/rttest/rttest1/status
T: priolt:		0: 	1
/sys/devices/system/rttest/rttest0/status
# T2 lock L0
C: locknowait:		2: 	0
/sys/devices/system/rttest/rttest2/command
W: blocked:		2: 	0
/sys/devices/system/rttest/rttest2/status
T: prioeq:		0: 	82
/sys/devices/system/rttest/rttest0/status
# T0 unlock L0
C: unlock:		0: 	0
/sys/devices/system/rttest/rttest0/command
# Wait until T2 got the lock
W: locked:		2: 	0
/sys/devices/system/rttest/rttest2/status
W: unlocked:		0:	0
/sys/devices/system/rttest/rttest0/status
T: priolt:		0:	1
/sys/devices/system/rttest/rttest0/status
# T2 unlock L0
C: unlock:		2: 	0
/sys/devices/system/rttest/rttest2/command
W: unlocked:		2: 	0
/sys/devices/system/rttest/rttest2/status
W: locked:		1: 	0
/sys/devices/system/rttest/rttest1/status
C: unlock:		1: 	0
/sys/devices/system/rttest/rttest1/command
W: unlocked:		1: 	0
/sys/devices/system/rttest/rttest1/status
Pass
C: resetevent:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
# Set schedulers
C: schedother:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
C: schedother:		1: 	0
/sys/devices/system/rttest/rttest1/command
W: opcodeeq:		1: 	0
/sys/devices/system/rttest/rttest1/status
# T0 lock L0
C: locknowait:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: locked:		0: 	0
/sys/devices/system/rttest/rttest0/status
# T1 lock L0
C: lockintnowait:	1: 	0
/sys/devices/system/rttest/rttest1/command
W: blocked:		1: 	0
/sys/devices/system/rttest/rttest1/status
# Interrupt T1
C: signal:		1:	0
/sys/devices/system/rttest/rttest1/command
W: unlocked:		1: 	0
/sys/devices/system/rttest/rttest1/status
T: opcodeeq:		1:	-4
/sys/devices/system/rttest/rttest1/status
# Unlock and exit
C: unlock:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: unlocked:		0: 	0
/sys/devices/system/rttest/rttest0/status
Pass
C: resetevent:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
# Set schedulers
C: schedother:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: opcodeeq:		0: 	0
/sys/devices/system/rttest/rttest0/status
C: schedother:		1: 	0
/sys/devices/system/rttest/rttest1/command
W: opcodeeq:		1: 	0
/sys/devices/system/rttest/rttest1/status
C: schedfifo:		2: 	82
/sys/devices/system/rttest/rttest2/command
W: opcodeeq:		2: 	0
/sys/devices/system/rttest/rttest2/status
# T0 lock L0
C: locknowait:		0: 	0
/sys/devices/system/rttest/rttest0/command
W: locked:		0: 	0
/sys/devices/system/rttest/rttest0/status
# T1 lock L0
C: locknowait:		1: 	0
/sys/devices/system/rttest/rttest1/command
W: blocked:		1: 	0
/sys/devices/system/rttest/rttest1/status
T: priolt:		0: 	1
/sys/devices/system/rttest/rttest0/status
# T2 lock L0
C: locknowait:		2: 	0
/sys/devices/system/rttest/rttest2/command
W: blocked:		2: 	0
/sys/devices/system/rttest/rttest2/status
T: prioeq:		0: 	82
/sys/devices/system/rttest/rttest0/status
# T0 unlock L0
C: unlock:		0: 	0
/sys/devices/system/rttest/rttest0/command
# Wait until T2 got the lock
W: locked:		2: 	0
/sys/devices/system/rttest/rttest2/status
W: unlocked:		0:	0
/sys/devices/system/rttest/rttest0/status
T: priolt:		0:	1
/sys/devices/system/rttest/rttest0/status
# T2 unlock L0
C: unlock:		2: 	0
/sys/devices/system/rttest/rttest2/command
W: unlocked:		2: 	0
/sys/devices/system/rttest/rttest2/status
W: locked:		1: 	0
/sys/devices/system/rttest/rttest1/status
C: unlock:		1: 	0
/sys/devices/system/rttest/rttest1/command
W: unlocked:		1: 	0
/sys/devices/system/rttest/rttest1/status
Pass
