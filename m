Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289102AbSBLQtE>; Tue, 12 Feb 2002 11:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289663AbSBLQsy>; Tue, 12 Feb 2002 11:48:54 -0500
Received: from cpu1808.adsl.bellglobal.com ([206.47.37.39]:44794 "HELO
	oak.cpu1808.adsl.bellglobal.com") by vger.kernel.org with SMTP
	id <S289102AbSBLQsk>; Tue, 12 Feb 2002 11:48:40 -0500
From: idallen@freenet.carleton.ca (Ian! D. Allen [NCFreeNet])
Date: Tue, 12 Feb 2002 11:48:39 -0500
X-Mailer: Mail User's Shell (7.2.6 beta(5) 10/07/98)
To: linux-kernel@vger.kernel.org
Subject: file size rlimit inhibits kernel process accounting
Message-Id: <20020212164839.9DE481408B@oak.cpu1808.adsl.bellglobal.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Consider a file size ulimit/rlimit, set using something like:

    ulimit -f 1000  # kilobytes of output files

All processes run from the above shell will be unable to write their
accounting file records (enabled with accton) if the size of the
accounting file is larger than the given file size limit.

This seems unintended.  In fact, an intruder could purposefully set
a low file size limit to prevent process accounting and cover his/her
traces in the accounting log.  (Or, someone could do it to avoid being
charged for system usage, etc.)

Same behaviour: 2.2.19 and 2.4.18-pre7

# cat /proc/version
Linux version 2.2.19-6.3mdk (root@updates.mandrakesoft.com) (gcc version
egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Thu Nov 15 15:17:52
MST 2001

# cat /proc/version
Linux version 2.4.18-pre7 (root@idallen-home) (gcc version 2.96 20000731
(Mandrake Linux 8.1 2.96-0.62mdk)) #13 Thu Jan 31 00:51:41 EST 2002

-- 
-IAN!  Ian! D. Allen   Ottawa, Ontario, Canada   idallen@ncf.ca
       Home Page on the Ottawa FreeNet: http://www.ncf.ca/~aa610/
       College professor at: http://www.algonquincollege.com/~alleni/
       Board Member, TeleCommunities CANADA  http://www.tc.ca/
