Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132895AbRDWLzt>; Mon, 23 Apr 2001 07:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132898AbRDWLzj>; Mon, 23 Apr 2001 07:55:39 -0400
Received: from pisces.bazza.com ([194.130.12.65]:26116 "EHLO pisces.bazza.com")
	by vger.kernel.org with ESMTP id <S132895AbRDWLzV>;
	Mon, 23 Apr 2001 07:55:21 -0400
Date: Mon, 23 Apr 2001 12:55:19 +0100
From: barry <bazza@bazza.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: really odd timing issues with 2.4 kernels and SMP
Message-ID: <20010423125519.A438@bazza.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux, the choice of a GNU generation
X-uptime: 12:47pm  up 6 min,  3 users,  load average: 0.07, 0.21, 0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I'll try and do this as best I can from the REPORTING-BUGS file, I can't
post any Oops information or anything, because it's not a fatal problem.

Last week, I replaced an HD in my machine, to make life easier copying things
over, I made it /dev/hdc (to replace /dev/hdb) and made it reiserfs, since
this point, timing on my machine has gone out the window, if I have a clock on
screen at any time, once in a while I can see the minute digits going up and
down, I'm getting *negative* ping times when doing traceroutes and things, an
nmap downright refuses to do anything due to it

I've tried moving the drive to being secondary on the first channel, and
disabling the 2nd IDE channel, but to no avail, the same problem still happsn

examples of these

traceroute from my machine to www.sgi.com

traceroute to www.sgi.com (216.32.174.155), 30 hops max, 38 byte packets
 1  194.130.12.126  0.360 ms  0.349 ms  0.264 ms
 2  194.130.14.200  -1.196 ms  1.202 ms  1.152 ms
 3  158.43.231.4  1.291 ms  1.081 ms  1.086 ms
 4  158.43.229.2  1.442 ms  1.300 ms  1.387 ms
 5  158.43.254.5  11.348 ms  10.438 ms  10.928 ms
 6  158.43.253.85  17.719 ms  15.862 ms  13593.196 ms
 7  158.43.254.242  -13558.366 ms  17.898 ms  19.462 ms
 8  158.43.254.138  13610.568 ms  -13575.933 ms  13622.115 ms
 9  158.43.254.102  -13580.373 ms  13633.611 ms  -13594.861 ms
10  158.43.150.98  13641.817 ms  24.509 ms  22.838 ms
11  146.188.15.33  -13612.859 ms  13660.370 ms  -13622.886 ms
12  146.188.15.50  89.162 ms  89.650 ms  89.557 ms
13  152.63.23.61  13827.715 ms  -13645.459 ms  89.359 ms
14  152.63.15.185  13899.914 ms  -13715.589 ms  90.849 ms
15  152.63.21.121  93.317 ms  13990.084 ms  -13806.116 ms
16  152.63.24.133  14036.214 ms  -13851.295 ms  93.566 ms
17  157.130.60.98  99.936 ms  14134.792 ms  -13943.983 ms
18  216.32.223.129  91.871 ms  95.679 ms  92.265 ms
19  209.185.249.214  98.350 ms  100.625 ms  97.005 ms
20  216.32.173.85  174.472 ms  177.885 ms  174.619 ms
21  216.33.153.68  175.279 ms  174.430 ms  174.089 ms
22  216.33.152.115  174.455 ms  177.037 ms  -14382.650 ms
23  216.32.174.155  173.624 ms  172.421 ms  175.609 ms

trying to nmap between one of my machines and another

Starting nmap V. 2.12 by Fyodor (fyodor@dhp.com, www.insecure.org/nmap/)
Serious time computation problem in adjust_timeout ... end = (988026829,
608142) sent=(988026829,608908) delta = -768 srtt = -94 rttvar = 858 to =
75000
QUITTING!

output of ver_linux

-- Versions installed: (if some fields are empty or looks
-- unusual then possibly you have very old versions)
Linux pisces 2.4.2 #1 SMP Sun Apr 22 03:49:58 BST 2001 i686 unknown
Kernel modules         2.4.2
Gnu C                  2.95.2
Binutils               2.9.5.0.37
Linux C Library        ..
Dynamic Linker (ld.so) 1.9.11
ls: /usr/lib/libg++.so: No such file or directory
Procps                 2.0.6
Mount                  2.10s
Net-tools              (1999-04-20)
Kbd                    0.99
Sh-utils               2.0
Sh-utils               Parker.
Sh-utils               
Sh-utils               Inc.
Sh-utils               NO
Sh-utils               PURPOSE.

hopefully this will help someone, or help someone to help me :) 
Thanks

-- 
-Barry Hughes
my parents made me what I am today .. I'm thinking of suing
                             http://bazza.com/
