Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266888AbRGYK4y>; Wed, 25 Jul 2001 06:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266900AbRGYK4e>; Wed, 25 Jul 2001 06:56:34 -0400
Received: from m7.limsi.fr ([192.44.78.7]:11527 "EHLO m7.limsi.fr")
	by vger.kernel.org with ESMTP id <S266888AbRGYK4Y>;
	Wed, 25 Jul 2001 06:56:24 -0400
Message-ID: <3B5EA77F.5060200@limsi.fr>
Date: Wed, 25 Jul 2001 13:03:27 +0200
From: Damien TOURAINE <damien.touraine@limsi.fr>
Organization: LIMSI-CNRS
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.18 i686; en-US; rv:0.9.1) Gecko/20010607
X-Accept-Language: fr, en
MIME-Version: 1.0
To: landley@webofficenow.com
CC: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Call to the scheduler...
In-Reply-To: <Pine.LNX.3.95.1010724134717.32263A-100000@chaos.analogic.com> <01072415121901.00631@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Rob Landley wrote:

>On Tuesday 24 July 2001 13:54, Richard B. Johnson wrote:
>
>>Try sched_yield(). Accounting may still be messed up so the process
>>may be 'charged' for CPU time that it gave up. Also, usleep(n) works
>>very well with accounting working.
>>
>>This works, does not seem to load the system, but `top` shows
>>99+ CPU time usage:
>>
>>main()
>>{
>>    for(;;) sched_yield();
>>
>>}
>>
>This may not be an accounting problem.  If the system has nothing else to do, 
>it'll just re-schedule your yielding thread.
>
>How much of that 99% cpu usage is user and how much of it is system?  
>Basically what the above does is beat the scheduler to death...
>
In my case, as the process/thread that call the "sched_yield();" 
function "actively" waits for another process/thread finish its job, the 
process won't be the only one in the queue of activ job ...
Then, it won't use 99% of the time ...

>>This works and `top` shows nothing being used:
>>
>>main()
>>{
>>
>>    for(;;) usleep(1);
>>
>>}
>>
>And here you DO block for a bit without getting called back immediately.
>
However, I would like to know the scheduler frequency to switch between 
tasks.
If it's above 1 us, the usleep don't match my requirements ...

However, thanks for your quick and pertinent answer !

Friendly
    Damien TOURAINE


