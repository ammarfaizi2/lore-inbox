Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030506AbVKCVrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030506AbVKCVrA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 16:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030508AbVKCVq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 16:46:59 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:9164 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030506AbVKCVq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 16:46:59 -0500
Subject: 2.6.14-rt1: oprofile doesn't work anymore
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 16:39:33 -0500
Message-Id: <1131053974.23154.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several months ago oprofile just stopped working on my system.  All I
have changed on the system was updating the kernel.  This used to work
perfectly.  I figured it was something I overlooked but recently I
double checked everything and I can't for the life of me figure out
what's wrong.

I am using the simple "profile" script that Andrew Morton posted several
months ago.  But no matter what I do, all I get is:

opreport error: No sample file found: try running opcontrol --dump
or specify a session containing sample files

(Of course I have tried running opcontrol --dump, it has absolutely no
effect)

Examining the log files I see that it does not collect any samples.

root@mindpipe:~# cat /var/lib/oprofile/oprofiled.log 
oprofiled started Thu Nov  3 16:32:05 2005
kernel pointer size: 4

Thu Nov  3 16:32:31 2005

Nr. sample dumps: 4
Nr. non-backtrace samples: 0
Nr. kernel samples: 0
Nr. lost samples (no kernel/user): 0
Nr. lost kernel samples: 0
Nr. incomplete code structs: 0
Nr. samples lost due to sample file open failure: 0
Nr. samples lost due to no permanent mapping: 0
Nr. event lost due to buffer overflow: 0
Nr. samples lost due to no mapping: 0
Nr. backtraces skipped due to no file mapping: 0
Nr. samples lost due to no mm: 0
Nr. samples lost cpu buffer overflow: 0
Nr. samples received: 0
Nr. backtrace aborted: 0
oprofiled stopped Thu Nov  3 16:32:31 2005

Is there something in the -rt tree that's known to break oprofile?  Or
did the userspace interface change in an incompatible way?

Lee

