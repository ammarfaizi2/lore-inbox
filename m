Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266066AbUALGrn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 01:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266068AbUALGrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 01:47:43 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:20731 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S266066AbUALGrl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 01:47:41 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.1-mm1: drivers/video/sis/sis_main.c link error
Date: Mon, 12 Jan 2004 01:47:36 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <20040109014003.3d925e54.akpm@osdl.org> <20040111214259.568cff35.akpm@osdl.org> <200401120611.i0C6BH7c003591@turing-police.cc.vt.edu>
In-Reply-To: <200401120611.i0C6BH7c003591@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401120147.36032.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.56.190] at Mon, 12 Jan 2004 00:47:40 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 January 2004 01:11, Valdis.Kletnieks@vt.edu wrote:
>On Sun, 11 Jan 2004 21:42:59 PST, Andrew Morton said:
>> Gene Heskett <gene.heskett@verizon.net> wrote:
>> >  hubble of about 4 or 5 months back.  In any other kernel,
>> > switching to that window took about 12 seconds for the backdrop
>> > to be converted to 1600x1200x32 and drawn the first time and
>> > about 8 seconds for the next time.  But with this 2.6.1-mm1
>> > kernel, that repeat window switch is so close to instant that I
>> > cannot see it being drawn.
>>
>> There are no significant fbdev patches in 2.6.1-mm1.  There is a
>> DRM update.
>
>The 12 seconds coming and 8 seconds going, versus instant, sounds an
> *awful* lot like the virtual memory manager making better choices
> in -mm kernels, so the pages of pixmap are staying in memory rather
> than paging out.
>
>Other guess is that o21-sched.patch is DTRT, while the stock
> scheduler DTWT for his particular config.
>
>Gene:  Can you tell what exactly your system is doing for the 12/8
> seconds?  Is it CPU bound, or beating on the disk while paging
> in/out, or just sitting idle?  Leaving a 'vmstat 1' running while
> you change backdrops should tell us something.

I can try that with the 2 kernels, but it will have to be after amanda
is done with her nightly tour, which will take another 2.5 hours.  By
then I expect to be sleeping, or hope to be, its 1:30am here now.

Or maybe not, what do I do when "vmstat 1" prints its column headers and segfaults?:
---
[root@coyote linux-2.6]# vmstat 1
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
Segmentation fault
[root@coyote linux-2.6]#
---
cd'ing to /proc/1, and trying to "cat mem" gets me this:
---
[root@coyote 1]# cat mem
cat: mem: No such process
[root@coyote 1]#
---
Some of the other names there have content, but 'mem' seems to be
a truely empty filename, marked:
-rw-------    1 root     root            0 Jan 12 01:32 mem
but apparently inacessable.

This actually sounds pretty serious, and I did have a hard lockup
in the night last night, had to use the reset button, but I think
that was a cpu overheat, I'd run the heat up cause the missus was
squawking about being cold.

I've rearranged things airwise and got the cpu down to below 70C.
These AMD DX-1600 thoroughbreds really are genuine coffee boilers.
I really should replace it with the cheapest barton cored one, but
this ones been running that hot for 30 months now.  Running seti 24/7
of course doesn't help. :)

Do I need YANP42.6 (Yet Another New Program 4 2.6)?
Sorry, couldn't resist creating a new acronym. :)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

