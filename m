Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278133AbRJRUm3>; Thu, 18 Oct 2001 16:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278136AbRJRUmJ>; Thu, 18 Oct 2001 16:42:09 -0400
Received: from femail25.sdc1.sfba.home.com ([24.254.60.15]:34471 "EHLO
	femail25.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S278133AbRJRUmD>; Thu, 18 Oct 2001 16:42:03 -0400
Date: Thu, 18 Oct 2001 15:42:25 -0500
To: linux-kernel@vger.kernel.org
Cc: forming@hotmail.com
Subject: VM testing with mtest, 2.4.12-ac3 & 2.4.13pre3aa1
Message-ID: <20011018154225.A3833@cy599856-a.home.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, forming@hotmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Editor: GNU Emacs 20.7.2
X-Operating-System: Debian GNU/Linux 2.4.12-ac2 i586 K6-3+
X-Uptime: 15:36:33 up  2:45,  3 users,  load average: 0.01, 0.03, 0.03
From: Josh McKinney <forming@home.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent this once before, but it seems it didn't make it to the list.  I left off
the vmstat output to make it smaller.  If I am just crazy and it did make it to
the list I am sorry.  Rik or Andrea if you would like to see
the vmstat output I can send it to you upon request.

This is a report of the mtest01 scripts posted by rwhron@earthlink.net a day orso ago.

Hardware:
K6-3 450
256MB ram
122MB swap
ATA/100 IBM disk

All the tests were run on a fresh boot, in single user mode.  The test consists
of running the mtest script and playing an mpg with mpg123.

The numbers are rather interesting.  While the latency of the ac kernels is
definitely better, the song only dropped out for a second or two in the
begining but that was it.  The aa kernel drops out more frequently throughout
the test, but the amount of memory allocated is almost twice as much as with the
ac kernels.  I thought the memory allocation was strange, so I ran the tests
again, and came up with the same results.  I understand that it is very
important to have the variables the same across the tests, which is why I ran
the tests in single-user mode, and directly after a clean reboot.

Hope this report helps, thanks to rwhon for the scripts, seem like a good
testing tool, and thanks to AC for keeping Riel's VM alive, and thanks to Rik
and Andrea for two great VM's.  It is nice to see two competing ideas and how
they fair against each other.

<2.4.12-ac3 vanilla>
Averages for 10 mtest01 runs
bytes allocated:                    134427443.2
User time (seconds):                2.546
System time (seconds):              1.370
Elapsed (wall clock) time:          4.798
Percent of CPU this job got:        89.1%
Major (requiring I/O) page faults:  103.8
Minor (reclaiming a frame) faults:  32702

<2.4.12-ac3+riel's hogstop&cache patch>
Averages for 10 mtest01 runs
bytes allocated:                    124885401.6
User time (seconds):                2.380
System time (seconds):              1.253
Elapsed (wall clock) time:          4.401
Percent of CPU this job got:        89.1%
Major (requiring I/O) page faults:  100.2
Minor (reclaiming a frame) faults:  30363.3

<2.4.13-pre3aa1>
Averages for 10 mtest01 runs
bytes allocated:                    288148684.8
User time (seconds):                5.496
System time (seconds):              3.003
Elapsed (wall clock) time:          12.250
Percent of CPU this job got:        68.9%
Major (requiring I/O) page faults:  103.5
Minor (reclaiming a frame) faults:  70380.6

-- 
Linux, the choice                | You will step on the night soil of many
of a GNU generation       -o)    | countries. 
Kernel 2.4.12-ac2          /\    | 
on a i586                 _\_v   | 
                                 | 
