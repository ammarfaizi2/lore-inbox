Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135305AbQLOAmI>; Thu, 14 Dec 2000 19:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135400AbQLOAmC>; Thu, 14 Dec 2000 19:42:02 -0500
Received: from nat.dmz.icopyright.com ([209.191.160.234]:2605 "EHLO
	enki.corp.icopyright.com") by vger.kernel.org with ESMTP
	id <S135305AbQLOAlw>; Thu, 14 Dec 2000 19:41:52 -0500
Date: Thu, 14 Dec 2000 16:11:23 -0800 (PST)
From: <lamont@icopyright.com>
To: davej@suse.de
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Signal 11
In-Reply-To: <Pine.LNX.4.21.0012080217400.12383-100000@neo.local>
Message-ID: <Pine.LNX.4.21.0012141602170.3849-100000@enki.corp.icopyright.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had tons of problems with K6III/450s in ASUS P5A motherboards with
various kinds of 128MB SIMMs.  There were multiple different symptoms,
including just sig11s on compiles, corrupted input (leading to syntax
error) in compiles, and corrupted input in the buffer cache (same crash
over and over, but dd if=/dev/hda of=/dev/null bs=1024k count=128 fixed
it).  Swapping the memory would sometimes get rid of the problem, but then
it would come back weeks-months later.

I saw a bizzare problem once in an Tyan dual proc PIII/500 box with
2x256MB ECC RAM that one of the ECC RAM sticks was bad and that repeated
kernel compiles would hang after about 24 hours.  Strange problem, but
found that in troubleshooting it, the problem followed this stick of RAM
around to different machines.  Blamed the RAM but don't understand what
the underlying problem was...

On Fri, 8 Dec 2000 davej@suse.de wrote:
> On Thu, 7 Dec 2000, Jeff V. Merkey wrote:
> 
> > It's related to some change in 2.4 vs. 2.2.  There are other programs
> > affected other than X, SSH also get's spurious signal 11's now and again
> > with 2.4 and glibc <= 2.1 and it does not occur on 2.2.
> 
> <AOL>
> 
> I've begun to get a bit paranoid about my K6-2 500 box.
> 
> Various processes have been getting random signals after heavy CPU usage.
> Playing an MPEG movie, kernel compile, or even just some small apps
> compiling sometimes. Just for the record, this isn't an OOM situation,
> I've watched this box with half its memory free or in buffers left
> unattended, and suddenly a compile will just die.
> 
> I replaced the CPU with a brand new K6-2. Problem remained.
> Next suspect was faulty RAM. Despite having passed a memtest, I
> swapped out the DIMMs for some known good ones.
> Suspecting cooling problems, I added some case fans.
> Next came a bigger power supply. Still the problems.
> The latest last ditch attempt to make this box stable has been
> to attach the biggest fan I could find that would fit a socket 7 CPU.
> 
> And still the problems are there.
> The only remaining suspect would be a flaky motherboard.
> But then comes the real killer : This box is rock solid under 2.2
> 
> *boggle*
> 
> I'm not sure exactly when this started, but I think I first noticed
> it around test5 or so, but didn't suspect the kernel at the time.
> 
> I've tried kernels compiled with everything from 2.91.66 when this
> was a Redhat box, to gcc 2.95.2 (from Debian woody) when I installed
> debian on it.  If this is a compiler bug, it's one that no compiler
> I've tried seems to be immune from.
> 
> regards,
> 
> Davej.
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
