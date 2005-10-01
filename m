Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbVJAXJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbVJAXJJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 19:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbVJAXJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 19:09:09 -0400
Received: from rrcs-67-78-243-58.se.biz.rr.com ([67.78.243.58]:7568 "EHLO
	mail.concannon.net") by vger.kernel.org with ESMTP id S1750889AbVJAXJH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 19:09:07 -0400
Message-ID: <433F173E.2020108@concannon.net>
Date: Sat, 01 Oct 2005 19:09:50 -0400
From: Michael Concannon <mike@concannon.net>
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1.centos4 (X11/20050721)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lokum spand <lokumsspand@hotmail.com>
CC: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: A possible idea for Linux: Save running programs to disk
References: <BAY105-F2270EEA37B83483AE53063A48E0@phx.gbl>
In-Reply-To: <BAY105-F2270EEA37B83483AE53063A48E0@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>
>>>> Suppose Linux could save the total state of a program to disk, for
>>>> instance, imagine a program like mozilla with many open windows. I 
>>>> give
>>>> it a SIGNAL-SAVETODISK and the process memory image is dropped to a
>>>> file. I can then turn off the computer and later continue using the
>>>> program where I left it, by loading it back into memory.
>>>>
>>>> Would that be possible? At least a program can be given a ctrl-z 
>>>> and is
>>>>
>>>>
>>>
>>> there is a LOT of state though.. the moment you add networking in the
>>> picture the amount of state just isn't funny anymore. Your X example is
>>> a good one as well...
>>>
>>>
>> There are a few cluster/parallel computing libraries out there that 
>> are starting to allow "process migration"...
>>
>> One would assume that "saving it to a disk" is simply a degenerate 
>> case of migrating the process...
>>
>> Presuming they have process migration working (and it seemed close a 
>> while ago when I last looked), saving to a file might already be 
>> supported...  I'd google "process migration" and you are likely to 
>> find a lot of discussion on this topic...
>>
>> /mike
>>
>>> -
>>> To unsubscribe from this list: send the line "unsubscribe 
>>> linux-kernel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>>
>>>
>>
>
> In fact moving processes from one machine to another would be a 
> brilliant feature at my work, since we run fairly large and 
> time-consuming simulations on electronic circuits. If the kernel could 
> natively support bouncing jobs back and forth, that would really be 
> something. Since we simulate with proprietary software, I suppose we 
> can't rely on the simulator being rewritten to support such special 
> libraries.
>
> Does any other Unix variant have process bouncing already?

Yes, plenty of proprietary tools in that space...  This is something 
Big-Iron has needed to do for quite a while - if nothing else 
fault-tolerance requires migrating processes of dead or dying nodes.

More recently some of the gnu stuff has come up to speed - though, I 
must admit it has been a while since I looked...

For the gnu world, have a look at "mosix" - but again, groups.google.com 
and search for "process migration"...  I am sure there have been 
developments in the time since I last looked at it...  I satisfied my 
needs with gridengine as the least invasive way to deal with load 
balance of EDA tools without having to use $LSF.  My requirements at the 
time were - "can I get it running and use it in an hour...", So, I doubt 
it was the best or only choice...

The goal of most of the clustering libraries is that it is transparent 
to the tool, but flexlm causes trouble even if you don't do screwy 
things,  so  YMMV.  At this point I have exhausted my expertise on the 
subject :-).

search terms:
gridengine
PVM
mosix
cluter
process migration

/mike


