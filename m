Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266660AbSLWHF1>; Mon, 23 Dec 2002 02:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266675AbSLWHF1>; Mon, 23 Dec 2002 02:05:27 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:64697 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S266660AbSLWHF0>; Mon, 23 Dec 2002 02:05:26 -0500
Message-ID: <3E06B79E.8030903@namesys.com>
Date: Mon, 23 Dec 2002 10:13:34 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Cliff White <cliffw@osdl.org>
CC: Andrew Morton <akpm@digeo.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       linux-kernel@vger.kernel.org, Chris Mason <mason@suse.com>
Subject: Re: [Benchmark] AIM9 results
References: <200212181847.gBIIlhO26530@mail.osdl.org>
In-Reply-To: <200212181847.gBIIlhO26530@mail.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cliff White wrote:

>>Andrew Morton wrote:
>>
>>    
>>
>>>Andrew Morton wrote:
>>> 
>>>
>>>      
>>>
>>>>Hans Reiser wrote:
>>>>   
>>>>
>>>>        
>>>>
>>>>>Andrew and Chris, are these changes in performance definitely due to VM
>>>>>changes (and not some difference I am not thinking of between 2.5 and
>>>>>2.4 reiserfs code)?
>>>>>
>>>>>     
>>>>>
>>>>>          
>>>>>
>>>>aim9 is just doing
>>>>
>>>>       for (lots)
>>>>               close(creat(filename))
>>>>   
>>>>
>>>>        
>>>>
>>>                 unlink(filename);	/* of course */
>>>
>>>
>>> 
>>>
>>>      
>>>
>>Oh, commercial fs vendors must really love tuning for this benchmark.... 
>>sigh....
>>
>>    
>>
>Ya, we think the AIM stuff is getting a little old. The basic idea is fine, but
>many of the tests do _very little work.  We (OSDL) would like to re-do 
>AIM9+7 and make it more useful. We'd love to have some input from everyone....
>For example, how big a file should we create for a real creat() test ?
>cliffw
>
>  
>
>  
>
Well, if you take a look at mongo.pl available at www.namesys.com we 
provide you with a fractal file size generation program that you might 
want to look at, that mongo uses during the creation portion of its 
benchmark.

It makes 80% of the files less than some amount (100 bytes, or 1k, or 
4k, depending on how mean you want to be to ext2;-) ), then 80% of the 
remaining 20% less than 10 times that amount then....

There is more than one version of the file size generation code, so make 
sure you got the one that works as I described above.  I am looking for 
a formula to smooth the above behavior into some sort of gentle curve 
rather than sharp bands, but I haven't found it yet.

Hans

