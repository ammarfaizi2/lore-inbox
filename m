Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313641AbSDFBv2>; Fri, 5 Apr 2002 20:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313916AbSDFBvS>; Fri, 5 Apr 2002 20:51:18 -0500
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:10196 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S313641AbSDFBvJ> convert rfc822-to-8bit; Fri, 5 Apr 2002 20:51:09 -0500
Message-Id: <5.1.0.14.2.20020405174611.00b1dad0@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 05 Apr 2002 17:49:02 -0800
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: some more nifty benchmarks
Cc: Ed Sweetman <ed.sweetman@wmich.edu>, Robert Love <rml@tech9.net>,
        Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@zip.com.au>,
        George Anzinger <george@mvista.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrea Arcange <andrea@suse.de>
In-Reply-To: <200204052237.29299.Dieter.Nuetzel@hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:37 PM 5/04/2002 +0200, Dieter Nützel wrote:
>That's not true with the O(1)-scheduler.
>In most of my tests (Ingo got my results) you have to renice the audio daemon
>to something like -16 (first "real time" class) and X to -10 (for good
>interactivity) during "heavy" background stuff (40 gcc and 40 g++ processes
>reniced +19 for example). This load resulting in ~350 processes, 80~85
>running in parallel and sound playing on my "old" 1 GHz Athlon II with 640
>MB...;-)

you've completely missed the point.

for "CPU intensive" tasks (which GCC will be for large files being 
compiled), it will want to use its entire time-slice.
with HZ set at 100 for x86, that means it can run for up to 10msec without 
being preempted (if its not performing any system calls, I/O or other 
things which can cause a context-switch).

with 40 of these running, i have no doubt that you'll get skips on your audio.

are you using xmms?  if so, this has been discussed to death previously - 
and the fault lies with the userspace application.


cheers,

lincoln.

