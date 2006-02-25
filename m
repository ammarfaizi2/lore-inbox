Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161081AbWBYTwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161081AbWBYTwM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 14:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161091AbWBYTwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 14:52:12 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:33296 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1161081AbWBYTwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 14:52:11 -0500
Message-ID: <4400B562.6020203@argo.co.il>
Date: Sat, 25 Feb 2006 21:52:02 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Victor Porton <porton@ex-code.com>, linux-kernel@vger.kernel.org
Subject: Re: New reliability technique
References: <E1FCzMX-0000Ym-00@porton.narod.ru>	 <9a8748490602250526p2187e04ej9a680e6b2b948e7d@mail.gmail.com> <9a8748490602250527l78e057ecvcd2e656b8ff5c9f2@mail.gmail.com>
In-Reply-To: <9a8748490602250527l78e057ecvcd2e656b8ff5c9f2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Feb 2006 19:52:08.0128 (UTC) FILETIME=[F5B7AC00:01C63A44]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

>On 2/25/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
>  
>
>>On 2/25/06, Victor Porton <porton@ex-code.com> wrote:
>>    
>>
>>>A minute ago I invented a new reliability enhancing technique.
>>>
>>>In idle cycles (or periodically in expense of some performance) Linux can
>>>calculate MD5 or CRC sums of _unused_ (free) memory areas and compare these
>>>sums with previously calculated sums.
>>>
>>>Additionally it can be done for allocated memory, if it will be write
>>>protected before the first actual write. Moreover, all memory may be made
>>>write-protected if it is not written e.g. more than a second. (When it
>>>is written kernel would unlock it and allow to write, by a techniqie like
>>>to how swap works.) If write-protected memory appears to be modified by
>>>a check sum, this likewise indicates a bug.
>>>
>>>If a sum is inequal, it would notice a bug in kernel or in hardware.
>>>
>>>I suggest to add "Check free memory control sums" in config.
>>>
>>>      
>>>
>>Implement it then and send a patch.
>>
>>    
>>
>
>But, doesn't slab poisoning and the like already cover this ground somewhat?
>
>  
>
No, they don't. They cover only a very small percentage of memory.

On the other hand, ECC memory and caches do this in hardware.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

