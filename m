Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278362AbRJSL3p>; Fri, 19 Oct 2001 07:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278363AbRJSL3g>; Fri, 19 Oct 2001 07:29:36 -0400
Received: from Expansa.sns.it ([192.167.206.189]:43538 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S278362AbRJSL3W>;
	Fri, 19 Oct 2001 07:29:22 -0400
Date: Fri, 19 Oct 2001 13:30:05 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: <rwhron@earthlink.net>
cc: <linux-kernel@vger.kernel.org>, <ltp-list@lists.sourceforge.net>
Subject: Re: VM tests on 2.4.13-pre5aa1
In-Reply-To: <20011019023800.A252@earthlink.net>
Message-ID: <Pine.LNX.4.33.0110191327260.11050-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting!
on the week end I will set up a stress test for the VM to see if I am able
to get some failure. Just I need a little of time, since I am at SMAU for
the magazine I write for (by the way, inside of the press room there is
a very very pretty bar girl :) ).
mmm, I should immagine some good test case...

Luigi

On Fri, 19 Oct 2001 rwhron@earthlink.net wrote:

>
> Kernel: 2.4.13-pre5aa1
>
> I discovered something important for the test results I've
> been reporting.  The mp3's that I've been listening to were
> not all sampled at the same rate.  That means some of the
> comparisons are suspect.
>
> The mp3's were sampled between 88k and 192k.  I did not notice
> the sample rate affecting whether an mp3 skips or not.
> I.E. an 88k mp3 and a 192k mp3 skip about the same on a
> kernel/test that sputters.  There probably is a difference,
> but it isn't obvious.  So the subjective reports on sound quality
> are reasonable.  In the future, I'll make sure comparisons that
> include timing are done with comparable mp3's.
>
>
> Timing variance:
>
> mmap01  Low time: 4:13  High  4:29
> mtest01	Low time:  :43  High  1:10
>
> I'm not saying the difference between the high and low times
> is the variance between an 88k and 192k mp3. For mtest01 it
> could be, because that test is short enough to run a couple
> times during one song.  mmap01 may have had part at 88k and part
> at 192k.
>
> Okay, with the disclaimers out of the way.  Here are the results:
>
>
> mmap001
>
> Average for 5 mmap001 runs
> bytes allocated:                    2048000000
> User time (seconds):                19.172
> System time (seconds):              15.182
> Elapsed (wall clock seconds) time:  258.82
> Percent of CPU this job got:        12.80
> Major (requiring I/O) page faults:  500169.0
> Minor (reclaiming a frame) faults:  32.0
>
> mtest01
>
> Averages for 10 mtest01 runs
> bytes allocated:                    1251370598
> User time (seconds):                2.079
> System time (seconds):              2.849
> Elapsed (wall clock) time:          54.075
> Percent of CPU this job got:        8.70
> Major (requiring I/O) page faults:  107.2
> Minor (reclaiming a frame) faults:  306293.2
>
>
> Even though I made the disclaimers, I will note that 2.4.13-pre3aa1
> was doing the mmap001 test consistently (4 runs) at around 210
> seconds average.  2.4.13-pre5 and 2.4.13-pre5aa1 are both
> around 260 seconds.
>
>
> Sound quality:
>
> Mostly good for mtest01.  page-cluster is 3.
>
> Not as good, for mmap01.    I'll give a subjective 4 on a scale of 10.
>
> Ideally I'd have a nice long mp3, and could say the test took 18:27 and mp3
> played 15:10 (or whatever).
>
>
> One other note for people who do similar tests.  mp3blaster skips less
> when compiled with glibc-linuxthreads-2.2.4 (default configure) than with
> pth-1.40.  glibc-linuxthreads uses more memory and creates more processes
> though.  All of my tests were with a glibc threads mp3blaster.
>
> I'm looking forward to playing with Andrea's new knobs in /proc/sys/vm.
>
> Have fun!
> --
> Randy Hron
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

