Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282828AbRK0HMw>; Tue, 27 Nov 2001 02:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282831AbRK0HMe>; Tue, 27 Nov 2001 02:12:34 -0500
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:52457 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S282828AbRK0HMb>; Tue, 27 Nov 2001 02:12:31 -0500
Date: Tue, 27 Nov 2001 02:15:13 -0500
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Cc: torvalds@transmeta.com, andrea@suse.de
Subject: VM tests on 5 recent kernels
Message-ID: <20011127021513.A228@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


5 recent kernels:

mtest01		Averages for 10 mtest01 runs
-------
mtest01 allocates and writes to 80% of virtual memory.
Listen to mp3 sampled at 128k.

mp3 on 2.4.16 skipped more than 2.4.15-pre6.
2.4.15-pre6 and 2.5.1-pre1 did best.  (fastest time, highest mp3 play).  
2.4.16-vm is a patch from http://surriel.com/patches/ 


2.4.15-pre6	mp3 played 375 of 376 seconds 99.7%
bytes allocated:                    1654023782
User time (seconds):                20.040
System time (seconds):              3.902
Elapsed (wall clock) time:          37.554
Percent of CPU this job got:        63.30
Major (requiring I/O) page faults:  103.8
Minor (reclaiming a frame) faults:  404608.3

2.4.15aa1	mp3 played 447 of 449 seconds 99%
bytes allocated:                    1663880396
User time (seconds):                20.115
System time (seconds):              3.310
Elapsed (wall clock) time:          44.818
Percent of CPU this job got:        51.70
Major (requiring I/O) page faults:  146.8
Minor (reclaiming a frame) faults:  407006.6

2.4.16-vm	mp3 played 271 of 442 seconds 61%
bytes allocated:                    1392508928
User time (seconds):                17.051
System time (seconds):              2.574
Elapsed (wall clock) time:          44.130
Percent of CPU this job got:        44.30
Major (requiring I/O) page faults:  146.8
Minor (reclaiming a frame) faults:  340758.5

2.4.16		mp3 played 312 of 371 seconds 84%
bytes allocated:                    1603272704
User time (seconds):                19.477
System time (seconds):              4.645
Elapsed (wall clock) time:          37.096
Percent of CPU this job got:        64.40
Major (requiring I/O) page faults:  105.7
Minor (reclaiming a frame) faults:  392213.3

2.5.1-pre1	mp3 played 361 of 365 seconds 99%
bytes allocated:                    1606313574
User time (seconds):                19.448
System time (seconds):              5.011
Elapsed (wall clock) time:          36.475
Percent of CPU this job got:        66.60
Major (requiring I/O) page faults:  105.9
Minor (reclaiming a frame) faults:  392959.1



mmap001		Averages for 5 mmap001 runs
-------
mmap, touch, msync, munmap on 500000 pages.
Listen to mp3 sampled at 128k.

Overall, this test had less variance.  2.4.15-pre6 had the
most mp3 playtime, but also took significantly more wall time.
2.4.15aa1 did well with high mp3 playtime, low wall clock time, 
and the lowest percentage of CPU usage.

2.4.15-pre6	mp3 played 873 of 874 seconds 99.8%
pages allocated:                    500000
User time (seconds):                19.612
System time (seconds):              24.858
Elapsed (wall clock) time:          174.616
Percent of CPU this job got:        25.00
Major (requiring I/O) page faults:  500154.2
Minor (reclaiming a frame) faults:  34.6

2.4.15aa1	mp3 played 730 of 738 seconds 99%
pages allocated:                    500000
User time (seconds):                19.444
System time (seconds):              17.330
Elapsed (wall clock) time:          147.542
Percent of CPU this job got:        24.20
Major (requiring I/O) page faults:  500188.8
Minor (reclaiming a frame) faults:  31.2

2.4.16-vm	mp3 played 704 of 745 seconds 94%
pages allocated:                    500000
User time (seconds):                19.670
System time (seconds):              16.554
Elapsed (wall clock) time:          148.908
Percent of CPU this job got:        23.80
Major (requiring I/O) page faults:  500163.2
Minor (reclaiming a frame) faults:  37.6

2.4.16		mp3 played 691 of 724 seconds 95%
pages allocated:                    500000
User time (seconds):                19.438
System time (seconds):              21.496
Elapsed (wall clock) time:          144.714
Percent of CPU this job got:        27.80
Major (requiring I/O) page faults:  500157.6
Minor (reclaiming a frame) faults:  39.4

2.5.1-pre1	mp3 played 666 of 715 seconds 93%
pages allocated:                    500000
User time (seconds):                19.400
System time (seconds):              20.550
Elapsed (wall clock) time:          142.922
Percent of CPU this job got:        27.60
Major (requiring I/O) page faults:  500159.0
Minor (reclaiming a frame) faults:  39.8

Hardware
--------
Athlon 1333
1024 MB RAM
1027 MB swap

Hope this helps.
-- 
Randy Hron

