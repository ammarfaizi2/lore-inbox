Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278091AbRJPFHy>; Tue, 16 Oct 2001 01:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278529AbRJPFHp>; Tue, 16 Oct 2001 01:07:45 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:26632 "EHLO
	mail12.speakeasy.net") by vger.kernel.org with ESMTP
	id <S278091AbRJPFHb>; Tue, 16 Oct 2001 01:07:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: VM
Date: Tue, 16 Oct 2001 01:08:02 -0400
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011015211216.A1314@localhost> <20011015232245.F1314@localhost> <1003202891.863.1.camel@phantasy>
In-Reply-To: <1003202891.863.1.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011016050739Z278091-17409+653@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think it was said earlier that we're dealing with definitions of stability 
and performance.   
If you look at stability as being able to depend on an effect given a cause, 
then andrea's has been said to be more stable in that sense.   If you look at 
performance being the amount of different situations  that the vm is stable 
and everything else being a lower priority, then andrea's vm is better 
performing.   

Rik's vm is performance first, meaning it tries to do what's best for each 
situation and basically the difference is that rik's vm has more variables 
effecting what happens.  This treats everything differently but it means that 
each situation is dealt with personally instead of trying to blanket each 
like situation.  That basically destroys our previous definition of 
stability.  So we make a new one.  Stability here deals with how much the 
system needs to stop other things for VM things.  Of course the not 
corrupting things and crashing things are implied to both definitions. 
For instance though,  when you swap, that takes time away to write to disk.  
This can take longer than a complex way of re-arranging pages and removing 
pages in ram.  

It seems like andrea's vm is more tuned for systems that do the same things 
over and over, like a server.  And rik's vm is more tuned for systems that 
you dont know what is going to be run or is running numerous programs that 
have no real regularity.  

And complex does not mean smart, but it doesn't mean it can't be smart.  When 
you're dealing with something as complex as a VM, using a simplistic approach 
may just be too limiting in the end and I think many people are seeing that 
when they say programs are more responsive in alan's kernel and memory usage 
is more efficient.  It doesn't seem very logical to make the VM do B when you 
do A on a multiprocessing system unless the environment is exactly the same 
every time you do A because what's good at one time doesn't mean it's good 
the second or third time you do it either due to memory limitations or other 
applications requiring different things of the VM.
 
I'm kind of picturing the two VM's like the two parts of our brain.  The 
brain stem (sometimes called the reptillian brain) and the cerebrum.  Your 
reptillian brain is quite fast at reacting and can make a few decisions on 
what to do based on a few specific variables.   The cerebrum is slower at 
those same tasks but it better manages those tasks, based on many more 
variables, so that the reaction is not too much or too little so that the 
next thing that happens is in a better position than what the reptillian 
brain would have left for it.  

Of course being able to do more means you have opened yourself up to more 
problems.  I wont speak for all ac branch users, but i feel that the more 
complex way of handing memory is a better choice because it's a function of 
the kernel that demands a complex solution. A simplistic solution is too 
limited, it would be like reacting from your brain stem and overreacting 
instead of using your higher logic and taking a more educated reaction.  

And that's all the contraversy, deciding if 2.4's VM demands a complex 
solution that handles each situation uniquely,  or it can have a simple 
solution that handles a wide range fairly good.   

Perhaps aiming for a simplistic VM should be the goal of 2.5 from the 
beginning ( as if it wasn't), that way you can build everything else around 
it and avoid all this vm trouble that 2.4 has been plagued with since the mid 
2.3 days.   
