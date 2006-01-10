Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWAJTsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWAJTsO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWAJTsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:48:14 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:11257 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1751090AbWAJTsN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:48:13 -0500
Message-ID: <43C40F30.1010009@mvista.com>
Date: Tue, 10 Jan 2006 11:46:56 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH RT] make hrtimer_nanosleep return immediately if time
 has passed
References: <1136557086.12468.138.camel@localhost.localdomain>  <43BEEEED.9040308@mvista.com> <1136588597.12468.162.camel@localhost.localdomain> <43C30FB9.1000609@mvista.com> <Pine.LNX.4.58.0601092042260.11138@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0601092042260.11138@gandalf.stny.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Mon, 9 Jan 2006, George Anzinger wrote:
> 
>>Steven Rostedt wrote:
>>
>>Uh... I have been wondering about the "mode" thing, thinking "flags" might be
>>better.  And allowing, say, a "return if elapsed" flag as well as the ABS
>>flag.  Then all you would need to do is to add the "return if elapsed" flag
>>to the nanosleep calls.  I have other reasons for wanting to expand the
>>"mode" to more that two states... but, even with out that, I think the result
>>would be a) less code, and b) easier to follow and understand.  I just have
>>trouble pushing a word on the stack to make a call and then use only one bit
>>of it when it could be combined...
> 
> 
> And I perfectly agree with you :)
> 
> The problem is that the hrtimes is not my code, and I don't like doing
> too many changes in code that I don't understand the consequences of. As
> you showed me earlier, that the previous change broke the posix_timers.
> So I really only did the bare minimum to fix what I considered a bug, and
> let Thomas, John, Ingo or yourself do a proper fix.  Someone that
> understands the timers better than I do.
> 
> Currently, it seems those people are too busy, and I just wanted a quick
> fix.  I personally didn't like the patch, but my nose is stuck more into
> the scheduling, memory and Ingo's rt_mutex now to spend time understanding
> all the timer code. ;)
> 
I am working on a general clean up of this area.  I will roll you idea into 
it and see what they say.
> 


-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
