Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286672AbSAUOLn>; Mon, 21 Jan 2002 09:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286687AbSAUOLc>; Mon, 21 Jan 2002 09:11:32 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:40977 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S286672AbSAUOL1>; Mon, 21 Jan 2002 09:11:27 -0500
Message-ID: <3C4C20A2.9040009@namesys.com>
Date: Mon, 21 Jan 2002 17:07:30 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33L.0201211153110.32617-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Mon, 21 Jan 2002, Hans Reiser wrote:
>
>>Pressure received is not equal to pages yielded. ... The number of
>>pages yielded should depend on the interplay of pressure received and
>>accesses made.
>>
>>Does this make more sense now?
>>
>
>Nice recipie for total chaos.  You _know_ each filesystem will
>behave differently in this respect, it'll be impossible to get
>the VM balanced in this way...
>
>Rik
>
No, I don't _know_ that.   Just because it got screwed up previously 
doesn't mean that no one can ever get it right.

I think there should be well commented code with well commented 
templates and examples, and persons who abuse the interface should be 
handled like persons who abuse all the other interfaces.

Optimal is optimal, and if VM's default is seriously suboptimal for a 
particular backing store then it simply shouldn't be used for that 
backing store.  Write clustering, slum squeezing, block allocating, 
encrypting, committing transactions, all of these are serious things 
that should be pushed by memory pressure from a VM that delegates.  This 
issue is no different from a human boss that refuses to delegate because 
he doesn't want to lose control, and he doesn't have the managerial 
skill that gives him the confidence that he can delegate well, and so 
nothing gets done well because he doesn't have the time to optimize all 
of the subordinates working for him as well as they could optimize 
themselves.  Rik, your plan won't scale.  Sure, you have the time needed 
to create one example template, but you cannot possibly create a single 
VM well optimized for every cache in the kernel.  They each have 
different needs, different properties, different filessytem layouts.

Hans


