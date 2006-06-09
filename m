Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbWFIQB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWFIQB0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWFIQBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:01:25 -0400
Received: from relay00.pair.com ([209.68.5.9]:6151 "HELO relay00.pair.com")
	by vger.kernel.org with SMTP id S1030252AbWFIQBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:01:24 -0400
X-pair-Authenticated: 71.197.50.189
Date: Fri, 9 Jun 2006 11:01:22 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Hui Zhou <hzhou@hzsolution.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Frustrating Random Reboots, seeking suggestions
In-Reply-To: <20060609145757.GB1640@smtp.comcast.net>
Message-ID: <Pine.LNX.4.64.0606091058320.4969@turbotaz.ourhouse>
References: <20060609145757.GB1640@smtp.comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2006, Hui Zhou wrote:

> Hi Lists,
>
> I understand this type of ask for help may be slightly off topic here, but 
> hoping for some clue to my desperation, here it goes:
>
> I am running a linux machine with a self programmed pvr running on it. All is 
> well until I reinstalled the linux system a few weeks ago. Now I am suffering 
> from random reboots. The reboots does not leave any debug messages or clues. 
> After some isolation, I finally narrowed it down to a blankscene marking 
> program -- bkmark. Running bkmark against any recording randomly reboots the 
> computer. By random, I mean  it may complete sucessfully once, but repeating 
> it for a few times, the reboots will happen.  On average, it reboots every 2 
> - 3 runs.
>
> I am happy with and used to seg faults, which given time, I can debug it. But 
> this random reboots stuff is new to me and I have no clues at all. How and 
> why would a user land program reboots the system?
>
> I am running debian stable. Self compiled unpatched kernel 2.6.16.15 PREEMPT. 
> Single Pentium 2.8GHz on Intel 865P motherboard. bkmark uses libmpeg2 shared 
> library. The source code is 471 lines, availible on request. The same program 
> runs without problem on the system before (debian unstable) and even before 
> (debian stable, but that was 5 months ago) and even with the same kernel 
> (2.6.14.6, I updated the kernel after this problem occured).
>
> More info is availible but I felt it may be inapprorate to post here and 
> honestly I have no clue which info is relavant. Any suggestions or clues or 
> advices on how to debug or narrow down the cause are very appreciated.
>
> Thank you.
>
>

Try to knock out any hardware problems first (run memtest86, check for 
high heat / crappy power).

If you're still having trouble, purchase a serial cable. Plug it into 
another computer with a terminal program. Enable serial console support in 
your kernel (and on your kernel command line). When the kernel boots, use 
SysRq on the serial console to turn the console messaging level up to 
maximum. If you're lucky, you'll catch some sort of diagnostics message on 
the serial console before this happens.

Cheers,
Chase
