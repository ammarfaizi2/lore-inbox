Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWD3VeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWD3VeT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 17:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWD3VeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 17:34:19 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:41094 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1750934AbWD3VeS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 17:34:18 -0400
Message-ID: <44552D49.8020401@vilain.net>
Date: Mon, 01 May 2006 09:34:01 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
Cc: Kirill Korotaev <dev@sw.ru>, Kir Kolyshkin <kir@openvz.org>, akpm@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>, serue@us.ibm.com,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, herbert@13thfloor.at
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <1143228339.19152.91.camel@localhost.localdomain> <200603282029.AA00927@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <4429A17D.2050506@openvz.org> <443151B4.7010401@tmr.com> <443B873B.9040908@sw.ru> <4454BA24.4070204@tmr.com>
In-Reply-To: <4454BA24.4070204@tmr.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

>Kirill Korotaev wrote:
>
>  
>
>>Bill,
>>
>>    
>>
>>>>OpenVZ will have live zero downtime migration and suspend/resume 
>>>>some time next month.
>>>>
>>>>        
>>>>
>>>Please clarify. Currently a migration involves:
>>>- stopping or suspending the instance
>>>- backing up the instance and all of its data
>>>- creating an environment for the instance on a new machine
>>>- transporting the data to a new machine
>>>- installing the instance and all data
>>>- starting the instance
>>>      
>>>
>>    
>>
>>>If you could just briefly cover how you do each of these steps with zero
>>>downtime...
>>>      
>>>
>>it does exactly what you wrote with some minor steps such as 
>>networking stop on source and start on destination etc.
>>
>>So I would detailed it like this:
>>- freeze VPS
>>    
>>
>
>when the VM stops providing services it's down as far as I'm concerned
>  
>

You're entirely nitpicking.

Sam.

>>- freeze networking
>>- copy VPS data to destination
>>- dump VPS
>>- copy dump to the destination
>>- restore VPS
>>- unfreeze VPS
>>    
>>
>
>and here is where my service is available again. The server may not know 
>it's been down, but the clients will.
>
>  
>
>>- kill original VPS on source
>>
>>Moreover, in OpenVZ live migration allows to migrate 32bit VPSs 
>>between i686 and x86-64 Linux machines.
>>    
>>
>
>I guess you're using "zero downtime" as a marketing term rather than a 
>technical term.
>
>  
>

