Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269464AbRHCQYk>; Fri, 3 Aug 2001 12:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269465AbRHCQYa>; Fri, 3 Aug 2001 12:24:30 -0400
Received: from cpe.atm0-0-0-122182.bynxx2.customer.tele.dk ([62.243.2.100]:65157
	"HELO marvin.athome.dk") by vger.kernel.org with SMTP
	id <S269464AbRHCQYS>; Fri, 3 Aug 2001 12:24:18 -0400
Message-ID: <3B6AD039.5060809@fugmann.dhs.org>
Date: Fri, 03 Aug 2001 18:24:25 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010716
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <Pine.LNX.4.33L.0108031303000.11893-100000@imladris.rielhome.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I dont know task states are defined, but by 'running' I mean that it is 
  not stopped by the VM, when the VM needs to fetch memory for the 
process. What I meant was that if we could somehow garrentee that a 
process runs at least for one time-quantum, the system would not grind 
to a halt but just feel slow since resheduling occur less often (due to 
waiting ie. for memory to be swapped in).

Is there a way to know if a running task needs something that has been 
swapped out, if so we could flag the process and not schedule it out 
right away:

Flag the current process, it the VM kicks in, and only resched if the 
flag is clear, othervice the scheduler just clear the flag.



Still I'm not quite sure what the reason for problem is. Could somone 
please summerize it for me. Untill now I assume that one of the problems 
is that multible processes are "fighting" eachother for memory, and thus 
  working against eachother.


Regards
Anders Fugmann

Rik van Riel wrote:
> We don't know which additional memory the big task will
> need until we let it run a bit and do its page fault.
> 
> 
> Rik
> --
> Virtual memory is like a game you can't win;
> However, without VM there's truly nothing to lose...
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 
> Send all your spam to aardvark@nl.linux.org (spam digging piggy)
> 
> 


