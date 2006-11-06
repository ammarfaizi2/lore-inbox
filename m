Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWKFKrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWKFKrk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 05:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWKFKrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 05:47:40 -0500
Received: from il.qumranet.com ([62.219.232.206]:9684 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1750890AbWKFKrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 05:47:39 -0500
Message-ID: <454F12C7.4070504@qumranet.com>
Date: Mon, 06 Nov 2006 12:47:35 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 1/14] KVM: userspace interface
References: <454E4941.7000108@qumranet.com>	 <20061105202934.B5F842500A7@cleopatra.q>	 <1162807420.3160.186.camel@laptopd505.fenrus.org>	 <454F0E4A.7030001@qumranet.com> <1162809128.3160.201.camel@laptopd505.fenrus.org>
In-Reply-To: <1162809128.3160.201.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>> \> as a general rule, it's a lot better to sort structures big-to-small, to
>>     
>>> make sure alignments inside the struct are minimized and don't suck too
>>> much. This is especially important to get right for 32/64 bit
>>> compatibility. This comment is true for most structures in this header
>>> file; please consider this at least
>>>   
>>>       
>> Doesn't that cause an unnatural field order? 
>>     
>
> Does it matter?
>
>   

Just a matter of taste.

>> for example, in some 
>> structures I separated in and out variables.  Sorting by size is a bit 
>> like sorting alphabetically.
>>
>> Anyway I observed 32/64 bit compatibility religiously.
>>     
>
> but you did take the alignment rules of 64 bit variables into account,
> eg 32 bit has it 4 byte aligned, while 64 bit has it 8 byte aligned..
> you are 100% sure even your 32 bit structures have all 64 bit values 8
> byte aligned?
> (you get this automatic if you sort by size)
> Also you made sure that if you have such implicit padding that you zero
> out the memory between the fields to avoid information leaks?
>   

I put explicit padding everywhere.

> Sorting by size at least makes this all go away.....
>
>   

True.  I'll rethink it.

-- 
error compiling committee.c: too many arguments to function

