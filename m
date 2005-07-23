Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbVGWCI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbVGWCI4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 22:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbVGWCI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 22:08:56 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:42655
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S262277AbVGWCIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 22:08:55 -0400
Message-ID: <42E1986B.8070202@linuxwireless.org>
Date: Fri, 22 Jul 2005 20:07:55 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Blaisorblade <blaisorblade@yahoo.it>
CC: LKML <linux-kernel@vger.kernel.org>, Andrian Bunk <bunk@stusta.de>,
       "H. Peter Anvin" <hpa@zytor.com>, torvalds@osdl.org
Subject: Re: Giving developers clue how many testers verified certain kernel
 version
References: <200507230244.11338.blaisorblade@yahoo.it>
In-Reply-To: <200507230244.11338.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade wrote:

>Adrian Bunk <bunk <at> stusta.de> writes:
>  
>
>>On Thu, Jul 21, 2005 at 09:40:43PM -0500, Alejandro Bonilla wrote:
>>    
>>
>>>   How do we know that something is OK or wrong? just by the fact that 
>>>it works or not, it doesn't mean like is OK.
>>>
>>>There has to be a process for any user to be able to verify and study a 
>>>problem. We don't have that yet.
>>>      
>>>
>
>  
>
>>If the user doesn't notice the difference then there's no problem for 
>>him.
>>    
>>
>Some performance regressions aren't easily noticeable without benchmarks... 
>and we've had people claiming unnoticed regressions since 2.6.2 
>(http://kerneltrap.org/node/4940)
>  
>
I will get flames for this, but my laptop boots faster and sometimes 
responds faster in 2.4.27 than in 2.6.12. Sorry, but this is the fact 
for me. IBM T42.

>>If there's a problem the user notices, then the process is to send an 
>>email to linux-kernel and/or open a bug in the kernel Bugzilla and 
>>follow the "please send the output of foo" and "please test patch bar" 
>>instructions.
>>    
>>
The thing is, I might not be able to know there *are* issues. I most 
just notice that something is strange. And then wait for a new kernel 
version because i might think it is something silly.

>
>  
>
>>What comes nearest to what you are talking about is that you run LTP 
>>and/or various benchmarks against every -git and every -mm kernel and 
>>report regressions. But this is sinply a task someone could do (and I 
>>don't know how much of it is already done e.g. at OSDL), and not 
>>something every user could contribute to.
>>    
>>
>
>Forgot drivers testing? That is where most of the bugs are hidden, and where 
>wide user testing is definitely needed because of the various hardware bugs 
>and different configurations existing in real world.
>  
>
This is my opinion too. If someone could do a simple script or 
benchmarking file, then users would be able to report most common 
important differences from previous kernel versions on their systems.

i.e. i would run the script that checks the write speed, CPU, latencys, 
and I don't know how many more tests and then compare it with the 
results that were with the previous git or full kernel release. 
Sometimes the users don't even know the commands to benchmark this parts 
of the systems. I don't know them.

>IMHO, I think that publishing statistics about kernel patches downloads would 
>be a very Good Thing(tm) to do. Peter, what's your opinion? I think that was 
>even talked about at Kernel Summit (or at least I thought of it there), but 
>I've not understood if this is going to happen.
>  
>
What can we do here? Can we probably create a project like the janitors 
so that we can report this kind of thing? Should we report here? How can 
we make a script to really benchmark the system and then say, since this 
guy sent a patch for the Pentium M CPU's, things are running slower? Or 
my SCSI drive is running slower since rc2, but not with rc1.

At least if the user notices this kind of things, then one will be able 
to google for patches for your controller for the last weeks and see if 
someone screwed up with a change they sent to the kernel.

In other words, kernel testing is not really easy for normal users, it 
can only really be benchmarked by the one that knows... Which are many, 
but not everyone.

And I really want to give my 2 cent on this.

.Alejandro
