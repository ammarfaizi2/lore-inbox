Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279659AbRJ3AIA>; Mon, 29 Oct 2001 19:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279662AbRJ3AHv>; Mon, 29 Oct 2001 19:07:51 -0500
Received: from goose.mail.pas.earthlink.net ([207.217.120.18]:54992 "EHLO
	goose.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S279659AbRJ3AHk>; Mon, 29 Oct 2001 19:07:40 -0500
Date: Mon, 29 Oct 2001 19:10:00 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.14pre3aa3 [was Re: VM test on 2.4.14pre3aa2 (compared to 2.4.14pre3aa1)]
Message-ID: <20011029191000.A202@earthlink.net>
In-Reply-To: <20011028120721.A286@earthlink.net> <20011029014715.J1396@athlon.random> <20011029034546.L1396@athlon.random> <20011029042938.M1396@athlon.random> <20011029045747.N1396@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011029045747.N1396@athlon.random>; from andrea@suse.de on Mon, Oct 29, 2001 at 04:57:47AM +0100
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 04:57:47AM +0100, Andrea Arcangeli wrote:
> BTW, you can still tweak the /proc/sys/vm/vm_* parameters. there's the
> updated commentary in mm/vmscan.c. default values should be sane. As usual an
> unit change isn't going to make relevant differences, those numbers doesn't
> need to be perfect.
> 
> Andrea

I haven't tried the patched version of the LTP tests yet.
This is with 2.4.14-pre3aa4.

Summary:

mtest01
2.4.14-pre3	Elapsed (wall clock) time:          30.517
2.4.14-pre3aa2	Elapsed (wall clock) time:          65.176
2.4.14-pre3aa4	Elapsed (wall clock) time:          37.277

mmap001
2.4.14-pre3	Elapsed (wall clock seconds) time:  171.45
2.4.14-pre3aa2	terminated with signal 9 
2.4.14-pre3aa4	Elapsed (wall clock seconds) time:  170.47

2.4.14-pre3 had the best interactive feel and mp3 sound.

Test:	"mtest01 -p 80" -w and "mmap001 -m 500000"
	Play mp3 sampled at 128k with mp3blaster.
	Light bitchx use (2 sessions), lynx, 52k link to net.
	vmstat 8, iostat 10, no X.  (typical load for these tests).
	Change page-cluster from default (3) to 2.


2.4.14pre3aa4 page-cluster=3

mp3 played 275 seconds of 373 second run.

Averages for 10 mtest01 runs
bytes allocated:                    1247805440
User time (seconds):                2.105
System time (seconds):              2.893
Elapsed (wall clock) time:          37.277
Percent of CPU this job got:        12.80
Major (requiring I/O) page faults:  131.9
Minor (reclaiming a frame) faults:  305428.0

mp3 played 800 seconds of 850 second run.

Average for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                19.502
System time (seconds):              14.312
Elapsed (wall clock seconds) time:  170.47
Percent of CPU this job got:        19.20
Major (requiring I/O) page faults:  500166.4
Minor (reclaiming a frame) faults:  44.2


2.4.14pre3aa4 page-cluster=2

mp3 played 295 seconds of 388 second run

Averages for 10 mtest01 runs
bytes allocated:                    1249692876
User time (seconds):                2.092
System time (seconds):              2.845
Elapsed (wall clock) time:          38.753
Percent of CPU this job got:        12.40
Major (requiring I/O) page faults:  131.9
Minor (reclaiming a frame) faults:  305888.8

mp3 played 810 seconds of 855 second run

Average for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                19.420
System time (seconds):              14.878
Elapsed (wall clock seconds) time:  170.96
Percent of CPU this job got:        19.60
Major (requiring I/O) page faults:  500167.0
Minor (reclaiming a frame) faults:  41.2

Hardware:
AMD 1333 Athlon
512 MB RAM
1024 MB swap.

-- 
Randy Hron

