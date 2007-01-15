Return-Path: <linux-kernel-owner+w=401wt.eu-S1751452AbXAOUFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbXAOUFa (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 15:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbXAOUFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 15:05:30 -0500
Received: from enyo.dsw2k3.info ([195.71.86.239]:57470 "EHLO enyo.dsw2k3.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452AbXAOUF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 15:05:29 -0500
Message-ID: <45ABDE79.7050706@citd.de>
Date: Mon, 15 Jan 2007 21:05:13 +0100
From: Matthias Schniedermeyer <ms@citd.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] How to (automatically) find the correct maintainer(s)
References: <45A9092F.7060503@student.ltu.se> <45A93B02.7040301@citd.de> <45A96E31.3080307@student.ltu.se> <45A973A8.1000101@citd.de> <45AAA3C2.80603@student.ltu.se> <tkrat.b40f8fe0936d84cd@s5r6.in-berlin.de> <45AAC44D.808@citd.de> <tkrat.0ce30797d3555dc3@s5r6.in-berlin.de> <45ABC17D.3050105@student.ltu.se>
In-Reply-To: <45ABC17D.3050105@student.ltu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Knutsson wrote:
> Stefan Richter wrote:
> 
>> On 15 Jan, Matthias Schniedermeyer wrote:
>>  
>>
>>> Stefan Richter wrote:
>>>    
>>>
>>>> On 14 Jan, Richard Knutsson wrote:
>>>>      
>>>>
>>>>> (Really liked the idea to have a "Maintainer"-button next to "Help"
>>>>> in *config)
>>>>>         
>>>>
>>>> Rhetorical question: What will this button be used for?
>>>>       
>>>
>>> Having "all(tm)" information of something in one place?
>>>     
>>
>>
>> Or, "click here to say 'it does not work'"?
>>
>> My rhetorical question wasn't about what it is intended for, but what
>> people would think it was intended for if it was there.
>>
>>   
> 
> I think it could be practical to have an easy access to whom is
> responsible for a driver and which mailinglist its development is
> addressed to, both for people interested in helping develop the driver
> and those who got an error (or fan-mail :).
> 
>>> I think adding the Maintainers-data is more or less a logical next step.
>>>
>>> It's not always clear from the MAINTAINERS-file who is the right person
>>> for what. Especially as it is a rather large text-file with only
>>> mediocre search-friendlieness. It's a 3.5 K-lines file!
>>>
>>> So when you know that you have a problem with drivers X, wouldn't it be
>>> great if you could just "go to" the driver in *config and see not only
>>> the Help-Text but the Maintainers-Data also.
>>>     
>>
>>
>> Seems more like what you actually want to have there is links to users'
>> mailinglists or forums.
>>
>> When this thread started, it was about assisting authors in submitting
>> patches.
>>
>>   
> 
> Yes, this is a bit out of scope, but just realized a simple way to
> implement it if using the CONFIG_FLAG-approach, just "grep" after the
> flag, under which the user hit the "Maintainer"-button, in the
> MAINTAINER-file. Also, I think this solves the handler-problem since an
> entry can have multiple CONFIG_FLAG's stated.
> 
> I don't think we should add the maintainer-entries directly in Kconfig,
> as you Stefan stated, because it is for configure the kernel. With the
> above approach, it will just require minor fixes in the "make *config"
> to handle it.

But how do you suppose the user gets the CONFIG_-String, which the user
then could for searching?

I'd say only a small percentage of hardcore-users would use the
.config-file directly, the others would deviate over *config, so i'd say
if the MAINTAINERS-data is integrated into Kconfig it's the perfect(tm)
90% solution.

OTOH you could just teach the *config to lookup a MAINTAINERS-entry when
all they are properly flagged.





Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated,
cryptic, powerful, unforgiving, dangerous.

