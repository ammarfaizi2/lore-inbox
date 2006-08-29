Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWH2Nll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWH2Nll (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 09:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbWH2Nll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 09:41:41 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:7346 "EHLO gepetto.dc.ltu.se")
	by vger.kernel.org with ESMTP id S964971AbWH2Nlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 09:41:40 -0400
Message-ID: <44F445A0.9000306@student.ltu.se>
Date: Tue, 29 Aug 2006 15:48:16 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Kleikamp <shaggy@austin.ibm.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 2.6.18-rc4-mm2] fs/jfs: Conversion to generic boolean
References: <44F086E8.7090602@student.ltu.se>	 <1156774979.7495.5.camel@kleikamp.austin.ibm.com>	 <44F35537.6000308@student.ltu.se>	 <1156799492.8732.19.camel@kleikamp.austin.ibm.com>	 <44F37D4C.1080801@student.ltu.se> <1156855062.8082.7.camel@kleikamp.austin.ibm.com>
In-Reply-To: <1156855062.8082.7.camel@kleikamp.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp wrote:

>On Tue, 2006-08-29 at 01:33 +0200, Richard Knutsson wrote:
>  
>
>>Dave Kleikamp wrote:
>>
>>    
>>
>>>On Mon, 2006-08-28 at 22:42 +0200, Richard Knutsson wrote:
>>>
>>> 
>>>
>>>      
>>>
>>>>Just why is it, that when there is a change to make locally defined 
>>>>booleans into a more generic one, it is converted into integers? ;)
>>>>   
>>>>
>>>>        
>>>>
>>>I just see this as an opportunity to make jfs more closely fit the
>>>coding style of the mainline kernel.
>>> 
>>>
>>>      
>>>
>>That is what I am trying to do, making bool as accepted as any other 
>>integer. No more, no less.
>>    
>>
>
>Okay.  My initial impression is that you were just offended by the
>ugliness of having so many different definitions of true, false, and
>boolean types.
>  
>
It isn't a pretty sight, but I think it is more important to let the 
"user" know what kind of value to expect from a function/variable.
Then to prevent errors and letting the compiler know it is a boolean, I 
think a globally typedef of _Bool with defined (enum) true/false is a 
good thing.
Just reminded my of the error-prone locally defined MAX/MIN and the 
global max/min.

>>>>I can understand if authors disprove making an integer into a boolean, 
>>>>but here it already were booleans.
>>>>But hey, you are the maintainer ;)
>>>>   
>>>>
>>>>        
>>>>
>>>I could be persuaded to leave the declarations as boolean_t or even
>>>making them bool, but right now I'm leaning toward making them int for
>>>consistency.
>>> 
>>>
>>>      
>>>
>>A root-beer maybe?
>>    
>>
>
>heh
>
>  
>
>>What do you say, can you hold on it for a while (can't be urgent, can 
>>it?) and see how the conversion go. Will take time for it during this 
>>week(end) and if the result is that almost no maintainer wants it, then...
>>Just seem strange to having a boolean function but declaring it integer, 
>>for (in my knowledge) no reason.
>>    
>>
>
>Sounds good to me.  I think I'll go ahead and kill the use of TRUE and
>FALSE, but hold off on the type change for now.
>  
>
To 0/1 or false/true?
Thanks

