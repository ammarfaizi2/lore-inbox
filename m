Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbTIWVgi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 17:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbTIWVgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 17:36:38 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:47599 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263448AbTIWVgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 17:36:36 -0400
Subject: bug w/ threads-max, pid_max, & /proc
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1064352192.740.3063.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Sep 2003 17:23:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Plain 2.6.0-test5 is affected. (so don't blame me)
The /proc filesystem gets really messed up when you
create more threads than you have PID values. Yes,
you can do this. I created 40000 threads on a system
with pid_max of 32768 and a threads-max of 98304.
This should not be allowed, for obvious reasons, and
because it breaks the /proc filesystem. Doing a
simple "/bin/ls /proc" would return 0, 1, or 2 of
every file. Stuff like /proc/cpuinfo was affected,
not just the process directories.


