Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWBECkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWBECkq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 21:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWBECkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 21:40:45 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:51863 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932289AbWBECkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 21:40:45 -0500
Message-ID: <43E56ACA.5050108@comcast.net>
Date: Sat, 04 Feb 2006 22:02:34 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org,
       s0348365@sms.ed.ac.uk
Subject: Re: athlon 64 dual core tsc out of sync
References: <787b0d920602041224p660911b5mc4d639581736e96f@mail.gmail.com>	 <1139101243.2791.78.camel@mindpipe>	 <787b0d920602041745k65504414taaaef7f6d75b364c@mail.gmail.com> <1139105306.2791.83.camel@mindpipe>
In-Reply-To: <1139105306.2791.83.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>On Sat, 2006-02-04 at 20:45 -0500, Albert Cahalan wrote:
>  
>
>>You clearly haven't been paying attention. Lots of computers vary the
>>clock rate. They do this several ways. 
>>    
>>
>
>I certainly have been paying attention.  Most of these problems are
>theoretical.  In practice the only commonly used hardware where the TSC
>is so unreliable as to be unusable are dual core Athlons.
>
>Please check the jackit-devel (this app has tight RT constraints and
>used to use the TSC directly for timing so problems show up quickly)
>list for details - we have seen zero bug reports due to CPU frequency
>scaling issues, and TONS related to the Athlon X2.
>
>Lee
>
>  
>

Actually my problem relates to both, seeing as how most people with 
athlon x2's probably have cpufreq compiled and working concurrently, I'd 
say they're pretty much tied together.  Though it's very much likely 
that the architecture of the athlon x2 makes cpufreq cause timing issues.


I dont know of anyone who's had just the athlon x2 in smp mode without 
cpufreq have these timing sync issues...  I could be mistaken, but every 
message i've seen relating to X2's is "frequency has changed, blah blah 
blah"  timing errors. 


In any case it's been generally accepted that pm timer is suggested to 
get around these errors, but i've been unable to use mine, there is no 
config option in menuconfig/gconfig etc and my .config seems to show 
that it's compiled in.   Boot args like timer=pmtmr and just pmtmr and 
having nothing have resulted in the same dmesg output , with no mention 
of using the pm-timer.   I know I used it in 2.6.14.3 and never had any 
sync issues, my setup and config hasn't changed since then except for 
the use of libata for pata.   So how can i determine what's going on 
here?   Default or not, i'd like to get the pmtmr in use if it's what 
works.


