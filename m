Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287263AbRL2XjL>; Sat, 29 Dec 2001 18:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287257AbRL2Xil>; Sat, 29 Dec 2001 18:38:41 -0500
Received: from ns.ithnet.com ([217.64.64.10]:62725 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S287253AbRL2Xi2>;
	Sat, 29 Dec 2001 18:38:28 -0500
Message-Id: <200112292338.AAA29985@webserver.ithnet.com>
Cc: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Date: Sun, 30 Dec 2001 00:38:12 +0100
Subject: Re: [PATCH] Balanced Multi Queue Scheduler ...
To: Davide Libenzi <davidel@xmailserver.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
In-Reply-To: <Pine.LNX.4.40.0112291424560.1580-100000@blue1.dev.mcafeelabs.com>
From: Stephan von Krawczynski <skraw@ithnet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, 29 Dec 2001, Dieter [iso-8859-15] Nützel wrote:             
>                                                                     
> The new patch need ver >= 2.5.2-pre3 because Linus merged the Time  
Slice                                                                 
> Split Scheduler and making it to apply to 2.4.x could be a pain in  
the b*tt.                                                             
> Yes, as i expected numbers on big SMP are very good but still i     
don't                                                                 
> think that this can help you with your problem.                     
                                                                      
Just a short note on that:                                            
                                                                      
Before the scheduler stuff really got rolling there was a pretty      
distinct discussion why L didn't quite get involved in the thread. I  
may remind you that he thought it to be not a _that_ interesting stuff
and I well remember he said something about the smallness and the low 
possibility that it gets broken by (well-thought-out) patches. This   
leads me to believe he has no major issues with enhancements to 2.4   
scheduler.                                                            
Well, me neither :-)                                                  
In fact we should keep in mind that 2.5 is a _development_ kernel and 
a next stable branch is out-of-sight at this time. So it would be     
quite reasonable to do a "backport" to 2.4 of the scheduler, because  
SMP systems do get more in size and number today and the near future. 
And we should not expect the not-LKML world to use _development_      
kernels on their cool-nu-SMP-box (tm), because this can only be bad   
for ongoing comparisons with other OSs. Well, you know what I mean.   
In fact I can see two major steps to take for marcelo's maintenance   
(besides the bugfixes of course):                                     
1) the SMP-scheduling (its all yours, Davide :-)                      
2) the HIGHMEM problems (a warm welcome to Andrea :-)                 
We cannot deny the fact that people expect the scalability of the     
system, and just to give you a small hint, I personally already       
stopped buying UP machines. There is no real big difference in prices 
between UP and 2-SMP these days, and RAM is unbelievably cheap in this
decade - and it makes your seti-statistics fly ;-)                    
So these issues will be very much in the mainstream of all users. No  
way to deny this.                                                     
I have no fear: this is a reachable goal, let's just take it.         
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
PS: Yes, Alan, I read your mail about the 32GB box and DMA and stuff, 
but nevertheless we should keep up with the market-ongoings (damn     
cheap 1GB modules).                                                   
                                                                      
                                                                      
