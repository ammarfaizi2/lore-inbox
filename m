Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285703AbRLYSLk>; Tue, 25 Dec 2001 13:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285692AbRLYSLb>; Tue, 25 Dec 2001 13:11:31 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:30616 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S285691AbRLYSLQ>; Tue, 25 Dec 2001 13:11:16 -0500
Date: Tue, 25 Dec 2001 13:14:30 -0500
To: linux-kernel@vger.kernel.org
Cc: andrea@suse.de
Subject: 2.4.17rc2aa2 stable on 3 machines and dbench results
Message-ID: <20011225131430.A13534@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm very happy with 2.4.17rc2aa2.  Some things I've run on it:

Laptop PII with 192MB RAM
15 simultaneous copies of crash01 doing 10,000,000 iterations each.
crash01 generates random code and executes it.  This ran for over
36 hours and the test completed normally.  An earlier 2.4.x
kernel locked up or rebooted on the first iteration.  Similarly,
crash02 tests (execute random syscalls) runs for long periods
with no problems.  (both of these tests could be dangerous, so
be careful with them).

K6-2/500 with 384MB RAM.
Several executions of Linux Test Project run all tests as well as
crash tests. 

Athlon 1333 with 1024 MB RAM.
12 simultaneous "./configure && make -j 30" of the kde-2.2.2 source
packages (addons admin artwork base bindings games graphics libs 
multimedia network pim sdk toys utils kdevelop.
This put a load of 40 - 90 on the system for the duration of the
run.  (about 2 hours in total - only hits swap for a few minutes,
on this machine).

dbench 128 on Athlon

2.4.17rc2aa1	Throughput 41.7986 MB/sec (NB=52.2483 MB/sec  417.986 MBit/sec)  128 procs
2.4.17-rc2	Throughput 18.1516 MB/sec (NB=22.6895 MB/sec  181.516 MBit/sec)  128 procs
2.4.17-rc2	Throughput 20.4923 MB/sec (NB=25.6153 MB/sec  204.923 MBit/sec)  128 procs
2.4.17rc2aa2	Throughput 41.805 MB/sec  (NB=52.2563 MB/sec  418.05 MBit/sec)   128 procs
2.4.17rc2aa2	Throughput 42.1931 MB/sec (NB=52.7413 MB/sec  421.931 MBit/sec)  128 procs
2.4.17-rc2rml1	Throughput 36.888 MB/sec  (NB=46.11 MB/sec    368.88 MBit/sec)   128 procs
2.5.1-dj3	Throughput 26.363 MB/sec  (NB=32.9537 MB/sec  263.63 MBit/sec)   128 procs

LTP regression
2.4.17rc2aa1 and 2.4.17rc2aa2 do consistently have a regression on one test, which 
passes on 2.4.17-rc1 and 2.4.17-rc2:
nanosleep02    1  FAIL  :  Remaining sleep time doesn't match with the expected 4 time
nanosleep02    1  FAIL  :  child process exited abnormally

These aren't VM tests, per se.  However, I found myself going back to this kernel
whenever I had a problem with 2.5.2-pre1.

All of the 2.4.17* kernels have been stable on my systems.  For performance, 
I give the nod to the aa kernels.

-- 
Randy Hron

