Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266790AbUGLLAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266790AbUGLLAT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 07:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266792AbUGLLAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 07:00:19 -0400
Received: from [193.178.151.93] ([193.178.151.93]:42045 "EHLO as.unibanka.lv")
	by vger.kernel.org with ESMTP id S266790AbUGLLAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 07:00:06 -0400
From: Aivils <aivils@unibanka.lv>
Reply-To: aivils@unibanka.lv
Organization: Unibanka
To: kernel@kolivas.org
Subject: Re: Voluntary Preemption + concurent games
Date: Mon, 12 Jul 2004 14:52:17 +0300
User-Agent: KMail/1.6.1
Cc: Ingo Molnar <mingo@elte.hu>, ck kernel mailing list <ck@vds.kolivas.org>,
       linux-kernel@vger.kernel.org, linuxconsole-dev@lists.sourceforge.net
References: <20040709182638.GA11310@elte.hu> <200407121123.11520.aivils@unibanka.lv> <40F25F0A.3060900@kolivas.org>
In-Reply-To: <40F25F0A.3060900@kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-13"
Content-Transfer-Encoding: 7bit
Message-Id: <200407121452.17170.aivils@unibanka.lv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 July 2004 12:51, Con Kolivas wrote:
> > 	I still use in my home minicomputer under Linux, where
> > 3 users use one CPU/RAM , but own video.
> > 	By default 2.6.XX task scheduler don' t like concurent applications
> > at all. 2.6.XX task scheduler allways raise on top of tasks only one
> > task and keep it on top until user stop it.
> > 	This rule is very unwanted for minicomputers, because multile
> > local users will use one CPU and feel lucky.
> > 
> > 	As point of reference i use 2.4.XX tack scheduler, which is very
> > "righteous" and allways give CPU time for all tasks. Under 2.4.XX
> > concurent games run smooth.
> > 
> > 	2.6.XX non-preemptive and 2.6.XX voluntary-preemptive task
> > scheduling looks very similar. My gamer' s eye report me very
> > thiny and very subjective difference - preferable is voluntary-preemtive.
> > Anyway all concurent CPU intensive tasks should be started with
> > nice -n +19 game-bin . Any other nice value remake one of
> > running game to slide show or both running games became slide show.
> > 
> > 	So we should start any game with nice +19. In is this set goes in
> > netscape and konqueror because of java web-chat and games.
> > 
> > 	At least voluntary-preemptive allow me move away from 2.4.26
> 
> I'm not sure I understand you. You said that voluntary preempt and 
> preempt look the same yet in your last line you say voluntary preempt 
> allows you to move away from 2.4.26?

Before moving away from 2.4.26 was insane for me. I check out
vanilla and Your kernels and reboot back to 2.4.26 as soon as i can.
My decision is _subjective_.

I will more play games neither measure miliseconds :)
I do not know how to profile all 4-5 threads of game, epspecialy if
runs two copies. Video, audio, net, game-logic latency ?

> Anyway apart from that comment I'm not really sure how you can address 
> this because if nice +19 works at smoothing out the games then that 
> almost surely suggests a yield() implementation in your games. 
> Unfortunately this, I noticed while coding my new scheduler policy, 
> seems to be _very_ common. There were lots of "big name" new games that 
> did the same thing. It was decided quite a while back in 2.5 development 
> that applications that use yield() for locking were broken by design. If 
> nice +19 fixes the problem then all I can suggest for the time being is 
> to use nice +19. The fact that the current processor is much more 
> out-of-order in it's scheduling is what is fooling these applications 
> now, and their unfortunate programming suffers in that setting.

Seems magic touch is "nice +19" , scheduler independ.

> What you need to cope with this is gang scheduling, but that's absurd to 
> implement such a complicated policy to cope with poor application 
> coding. Gang may be implemented in the future for different reasons, though.

Actulay i do not need because 2.4.XX do all things. 
I will notify developers about exisiting of trouble.
sched.c developers do all counter my needs :)

Aivils
