Return-Path: <linux-kernel-owner+w=401wt.eu-S1422757AbXAMTQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422757AbXAMTQA (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 14:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422759AbXAMTQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 14:16:00 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:57587 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422757AbXAMTP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 14:15:59 -0500
Message-ID: <45A93069.5080906@student.ltu.se>
Date: Sat, 13 Jan 2007 20:18:01 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] How to (automatically) find the correct maintainer(s)
References: <45A9092F.7060503@student.ltu.se> <tkrat.428a51215926acac@s5r6.in-berlin.de>
In-Reply-To: <tkrat.428a51215926acac@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter wrote:
> On 13 Jan, Richard Knutsson wrote:
> [...]
>   
>> SUPERCOOL ALPHA CARD
>>
>> P:	Clark Kent
>> M:	superman@krypton.kr
>> L:	some@thing.com
>> C:	SUPER_A
>> S:	Maintained
>> (C: for CONFIG. Any better idea?)
>>
>> then if someone changes a file who are built with CONFIG_SUPER_A, can 
>> easily backtrack it to the correct maintainer(s).
>>     
> [...]
>   
>> My first idea was to use the pathway and define that directories above 
>> the specified (if not specified by another) would fall to the current 
>> maintainer. It would work, but requires that all pathways be specified 
>> at once, or a few maintainers with "short" pathways would get much of 
>> the patches (and it is not as correct/easy to maintain as looking for 
>> the CONFIG_flag).
>>
>>
>> Any thoughts on this is very much appreciated (is there any flaws with 
>> this?).
>>     
>
>  - What about drivers which have no MAINTAINER entry but reside in a
>    subsystem with MAINTAINER entry?
>   
Hmm, how are those drivers built? Can you please point me to one?
>  - What if these drivers depend on two subsystems?
>   
Not sure if I understand the problem. I don't see the maintainers for 
the subsystems too interested in a driver, and it is the drivers 
maintainer we want.
>  
>  - Config options map to object files but do not map directly to source
>    files. Diffstats show source files.
>   
Can you make a object-file out of 2 c-files? Using Makefile?
> Example: The sbp2 driver is an IEEE 1394 driver and a SCSI driver.
> sbp2.o is enabled by CONFIG_IEEE1394_SBP2 which depends on
> CONFIG_IEEE1394 and CONFIG_SCSI. sbp2.c resides in drivers/ieee1394/.
> What is the algorithm to look up sbp2's maintainers?
>   
The one listed for CONFIG_IEEE1394_SBP2 :)

But what about ex ieee1394_core.o? Is ieee1394-objs "equal" to 
ieee1394.o? (Seems I need to read some Makefile docs...)
> Don't get me wrong though. Easier lookup of maintainers and mailinglists
> sounds to me like a desirable feature, not just from the point of view
> of submitters but also of maintainers.
>   
Well, as they say: "If it is too good to be true, it usually is" (but I 
don't think it is too far fetched)

(Btw, what I can see, there is no possibility to get the wrong 
maintainer. Just that sometime it can't give you an answer and you have 
to do it in the old way).

Thanks for all the pointers!
