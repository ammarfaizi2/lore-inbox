Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbULOCiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbULOCiP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 21:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbULOCiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 21:38:14 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:24823 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S261822AbULOCiL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 21:38:11 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
Date: Tue, 14 Dec 2004 21:38:10 -0500
User-Agent: KMail/1.7
References: <20041124101626.GA31788@elte.hu> <1103062423.14699.48.camel@krustophenia.net> <20041214223118.GD22043@elte.hu>
In-Reply-To: <20041214223118.GD22043@elte.hu>
Cc: Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412142138.10456.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.42.94] at Tue, 14 Dec 2004 20:38:11 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 December 2004 17:31, Ingo Molnar wrote:
>* Lee Revell <rlrevell@joe-job.com> wrote:
>> On Tue, 2004-12-14 at 22:18 +0100, Ingo Molnar wrote:
>> > the two projects are obviously complementary and i have no
>> > intention to reinvent the wheel in any way. Best would be to
>> > bring hires timers up to upstream-mergable state (independently
>> > of the -RT patch) and ask Andrew to include it in -mm, then i'd
>> > port -RT to it automatically.
>>
>> Among other things I think Paul Davis mentioned that George's high
>> res timer patch would make it possible for JACK to send MIDI
>> clock.  This would be a huge improvement.
>
><clueless question> roughly what latency/accuracy requirements does
> the MIDI clock have, and why is it an advantage if Linux generates
> it? What generates it otherwise - external MIDI hardware? Or was
> the problem mainly not latency/accuracy but that Linux couldnt
> generate a finegrained enough clock?
>
> Ingo

I'm not sure of the exact reasons, Ingo.  But the midi clock is a
bit of an odd man out in the normal progression of baud rates,
its 31,250 baud, in case you didn't already know that.
  
A lot of systems resort to a hardware timer driving a seriel shift
register as I doubt if one could guarantee writing to a single
bit port with an interval error of much more than 5% bit to bit,
and cumulatively less than that for the overall byte.  It can be
done though, we have a program for the coco's that run on a .89
mhz clock that can actually drive the seriel port well enough to
run a midi keyboard plugged into it. I've run it, and it has
enough spare time that I can steer some instruments to a second
homemade midi pack plugged into its expansion interface at the
same time & no descernable squiggles in the beat of the music.

Did you see my comment about the later versions seeming to slow
seti a wee bit?  Other than that, I'm in love with this, the
whole system just plain feels better.  The only thing on my wish
list right now is to be able to shut tvtime up, it grows the
system log about a megabyte a minute with its missed read reports.
Or is it tvtime that needs help?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

