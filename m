Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbTDFNEa (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 09:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbTDFNEa (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 09:04:30 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:4305 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262960AbTDFNE2 (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 09:04:28 -0400
Date: Sun, 6 Apr 2003 09:13:18 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: hdparm -tT reports "suspicious results" ???
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304060915_MC3-1-333E-AEEA@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Real-world benchmarks show I am getting about 30-32 MB/sec from my
IDE disks on 2.4.21-pre6: raid1 rebuild reports 32MB/sec and copying
a 1GB file to /dev/null on a newly-mounted fs takes 33 sec.  I have
moved the disk to another computer that is almost 100% identical
except for CPU (PPro 200 vs. PII ODP/333) and now hdparm says 24MB/sec
but I am still getting 30-32 real world on the PPro 200.  The below
results are from the PII Overdrive (I have not tested real-world
on 2.5 but notice how much slower hdparm reports its speed.)  What
does "suspicious" mean here?



# uname -a
Linux d2 2.4.21-pre6 #3 Fri Apr 4 18:22:11 EST 2003 i686 unknown
# hdparm -tT /dev/hde

/dev/hde:
 Timing buffer-cache reads:   128 MB in  2.50 seconds = 51.20 MB/sec
 Timing buffered disk reads:  64 MB in  2.15 seconds = 29.77 MB/sec
Hmm.. suspicious results: probably not enough free memory for a proper test.
# 
Script done on Fri Apr  4 20:49:01 2003
Script started on Fri Apr  4 20:52:03 2003
# uname -a
Linux d2 2.4.20 #1 Fri Apr 4 17:33:07 EST 2003 i686 unknown
# hdparm -tT /dev/hde

/dev/hde:
 Timing buffer-cache reads:   128 MB in  2.62 seconds = 48.85 MB/sec
 Timing buffered disk reads:  64 MB in  2.35 seconds = 27.23 MB/sec
Hmm.. suspicious results: probably not enough free memory for a proper test.
# 
Script done on Fri Apr  4 20:52:46 2003
Script started on Fri Apr  4 20:56:54 2003
# uname -a
Linux d2 2.5.66 #11 Sat Mar 29 21:14:17 EST 2003 i686 unknown
# hdparm -tT /dev/hde

/dev/hde:
 Timing buffer-cache reads:   128 MB in  2.66 seconds = 48.14 MB/sec
 Timing buffered disk reads:  64 MB in  3.90 seconds = 16.41 MB/sec
# cat /proc/meminfo
MemTotal:       191956 kB
MemFree:        170728 kB
Buffers:          4244 kB
Cached:           9548 kB
SwapCached:          0 kB
Active:           7908 kB
Inactive:         7764 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       191956 kB
LowFree:        170728 kB
SwapTotal:      262040 kB
SwapFree:       262040 kB
Dirty:               8 kB
Writeback:           0 kB
Mapped:           3668 kB
Slab:             3932 kB
Committed_AS:     2616 kB
PageTables:        292 kB
ReverseMaps:      2832


Configuration (now):
 Dell Optiplex GXPro (MPS 1.4)
      1 PPro 200, Uniprocessor IO-APIC kernel
      Promise Ultra 100TX2
              2 x Maxtor 4K060H3 (60GB 5400RPM)
              (1 drive per channel)

--
 Chuck
 I am not a number!
