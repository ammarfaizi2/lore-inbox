Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262978AbTIGCfy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 22:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbTIGCfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 22:35:54 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:36528 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262978AbTIGCfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 22:35:52 -0400
Date: Sat, 06 Sep 2003 19:34:58 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ed Sweetman <ed.sweetman@wmich.edu>
cc: Nick Piggin <piggin@cyberone.com.au>, Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v12
Message-ID: <146640000.1062902095@[10.10.2.4]>
In-Reply-To: <3F59C956.5050200@wmich.edu>
References: <3F58CE6D.2040000@cyberone.com.au> <195560000.1062788044@flay> <20030905202232.GD19041@matchmail.com> <207340000.1062793164@flay> <3F5935EB.4000005@cyberone.com.au> <6470000.1062819391@[10.10.2.4]> <3F5980CD.2040600@cyberone.com.au> <139550000.1062861227@[10.10.2.4]> <3F59C956.5050200@wmich.edu>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you dont see why X is super special then why is xmms even a part of 
> the discussion?  

Because it's an example of why X *isn't* super special - it's just another
interactive app. If we have to  explicitly boost every interactive app, 
we're screwed.

> All of this basing scheduling performance on a bloated wannabe winamp 
> makes as much sense as gauging car performance using a van.   If this 
> was a purely scheduling problem, then why do other players like 
> alsaplayer and such not suck as bad as xmms when under the exact same 
> priority and all?  At least use something without a frontend so that 
> you can limit the possibility that the programmers did something stupid 
> like make decoding dependent on some update to the gui. 
> xmms was coded first and foremost to look and work like winamp. 
> Streamlined - even low latency performance was not a base goal.  

The reality is that people use xmms, and whilst it may not be the greatest
program known to man, I don't believe it's *that* fundamentally screwed up
that it should skip under normal desktop loads. *Especially* if it worked
fine under 2.4 ;-)

Some people have observed that ALSA drivers seem worse than the older
ones ... I haven't done enough comparisons to be sure that's true, but
maybe they have less buffering or something. More buffering in the kernel
side might get rid of the sound skips.

> And outside of these two programs X and some audio player, how are
> things going to be effected?   Forget having to renice certain 
> processes, if i have a video player that say, outputs using X will 
> the video thread get lowered below certain other processes because 
> the audio thread is getting a higher dynamic priority and the video 
> thread uses a lot of cpu (maybe i dont have hw accel).  What about 
> video players that dont use theads, they require both a lot of cpu 
> and audio playing performance to stay in sync, will it be dropped 
> below the priority of other apps?

Don't think that's really so easy to solve, unless you do the hardware
boost thing. The original focus seemed to be giving a prio boost to
tasks that weren't cpu hogs. 

> It's early for me so maybe i'm overreacting.  I just dont see the logic 
> in using a program like xmms to guage audio playback performance since 
> it's main goal is to be like winamp, not efficiently playback audio 
> and so can be introducing all kinds of performance hits not found in 
> other players.

People should gague performance by how well we do on the apps they want
to run. If people want to run xmms, they'll be interested in how well
it works. My main objection to benchmarking like this is (and window
wiggle tests) are that they're pretty much subjective, and hard to 
measure.

Personally, I just use xmms because I've found nothing better, but the 
the UI does suck. Mostly that's because I'm too idle to look hard (or
I have better things to do) and it's good enough. Here is _not_ the 
place for people to tell me what I should use instead ;-)

M.

