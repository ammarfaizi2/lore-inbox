Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280026AbRKSD1U>; Sun, 18 Nov 2001 22:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281887AbRKSD1L>; Sun, 18 Nov 2001 22:27:11 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:8958 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S280026AbRKSD0y>; Sun, 18 Nov 2001 22:26:54 -0500
Date: Sun, 18 Nov 2001 22:29:22 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: Re: VM tests on 2.4.15-pre6 and 2.4.15pre6aa1
Message-ID: <20011118222922.A239@earthlink.net>
In-Reply-To: <20011118095720.A324@earthlink.net> <20011119012312.B1331@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011119012312.B1331@athlon.random>; from andrea@suse.de on Mon, Nov 19, 2001 at 01:23:12AM +0100
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2001 at 01:23:12AM +0100, Andrea Arcangeli wrote:
> 
> 	echo 9 >/proc/sys/vm/vm_mapped_ratio
> 
> and also after backing out those two patches in order:
> 
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.15pre6aa1/10_vm-14-no-anonlru-1-simple-cache-1
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.15pre6aa1/10_vm-14-no-anonlru-1
> 
> and again using "echo 9 >/proc/sys/vm/vm_mapped_ratio" after backing out
> the two patches.
> 
> thanks for the feedback,

Andrea,

Changing vm_mapped_ratio from 50 to 9 improved the time on the mmap001 
test by 11%.  

Backing out the 2 patches and changing vm_mapped_ratio to 9 improved the 
time on the memfill tests by 28% and improved mp3 playtime as well. :)  

2.4.15-pre6-vm_scan_rate=9
--------------------------

played 360 seconds of mp3 in 453 second test (79%)

Averages for 10 mtest01 runs
bytes allocated:                    1665138688
User time (seconds):                7.605
System time (seconds):              3.139
Elapsed (wall clock) time:          45.214
Percent of CPU this job got:        23.30
Major (requiring I/O) page faults:  144.6
Minor (reclaiming a frame) faults:  407313.4

played 808 seconds of mp3 in 813 second test (99%)

Average for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                3.530
System time (seconds):              23.138
Elapsed (wall clock seconds) time:  162.60
Percent of CPU this job got:        15.80
Major (requiring I/O) page faults:  500191.8
Minor (reclaiming a frame) faults:  30.2

2.4.15-pre6-vm_scan_rate=9
without: 10_vm-14-no-anonlru-1-simple-cache-1 10_vm-14-no-anonlru-1
--------------------------

played 318 seconds of mp3 in 356 second test (89%)

Averages for 10 mtest01 runs
bytes allocated:                    1668179558
User time (seconds):                7.672
System time (seconds):              3.322
Elapsed (wall clock) time:          35.637
Percent of CPU this job got:        30.50
Major (requiring I/O) page faults:  154.4
Minor (reclaiming a frame) faults:  408058.2

played 796 seconds of mp3 in 806 second test (99%)

Average for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                3.402
System time (seconds):              23.298
Elapsed (wall clock seconds) time:  161.46
Percent of CPU this job got:        15.80
Major (requiring I/O) page faults:  500190.4
Minor (reclaiming a frame) faults:  31.6

-- 
Randy Hron

