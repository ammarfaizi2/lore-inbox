Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288735AbSADUQM>; Fri, 4 Jan 2002 15:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288747AbSADUPx>; Fri, 4 Jan 2002 15:15:53 -0500
Received: from mout1.freenet.de ([194.97.50.132]:52201 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S284728AbSADUPf>;
	Fri, 4 Jan 2002 15:15:35 -0500
Message-ID: <3C360D6E.9020207@athlon.maya.org>
Date: Fri, 04 Jan 2002 21:15:42 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20011225
X-Accept-Language: en-us
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: Ken Brownfield <brownfld@irridia.com>,
        Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <200201040019.BAA30736@webserver.ithnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:

>>Unfortunately, I lost the response that basically said "2.4 looks   
>>stable                                                                
>>to me", but let me count the ways in which I agree with Andreas'    
>>sentiment:                                                          
>>                                                                    
>>A) VM has major issues                                              


Unfortunately you are right.

>>
>                                                                       
> On all boxes I run currently (all 1GB or below RAM), I cannot find    
> _major_ issues.                                                       


Question is: which nature is your application / load of the system? You 
wrote something about database server. How much rows alltogether? What's 
the size of the table(s)? How many concurrent accesses do you have? Do 
you do "easy" searches where all of the conditions are located in the 
index? How big is your index? How big is the throughput of your 
database? Do you have your tables on raw partitions (without caching; as 
you can do it with UDB)?

You mentioned squid, too. I'm running squid here on a AMD K6 2 400, 256 
MB RAM. It's mostly (sometimes plus my wife) for my own. No more users. 
In this situation, I can't see any problem, too. Why? There is no load, 
no throughput, ... .

How big are the partitions you are mounting at once? In my case, all the 
partitions together have about 70GB (all reiserfs).

I want to know it, because I think the problem depends on how much 
different HD-memory is accessed. If you have applications, which doesn't 
access to much memory, you can't view the problems.
If you access more than 1G (and you do not just copy, but rsync e.g.) 
and you have only 512MB of RAM, the machine swaps a lot with most actual 
2.4.-kernels (patches).


Another question:
Are there any tools to meassure the datathroughput a application causes? 
Interesting would be the sum at the end of the process, the maximum and 
average throughput (in- and output seperated) and the same for swapactivity.
It could probably help to find optimization potential. At least it would 
give the chance to directly compare the demand of different applications.


Regards,
Andreas Hartmann

