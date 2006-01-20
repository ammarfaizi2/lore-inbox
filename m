Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWATWrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWATWrY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 17:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWATWrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 17:47:24 -0500
Received: from S01060080c85517f6.wp.shawcable.net ([24.79.196.167]:15571 "EHLO
	ubb.ca") by vger.kernel.org with ESMTP id S932252AbWATWrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 17:47:23 -0500
In-Reply-To: <20060120144114.08f0c340.akpm@osdl.org>
References: <6951EFDF-9499-40D5-AD09-2AE217A0A579@ubb.ca> <20060120044407.432eae02.akpm@osdl.org> <20060120203104.GA31803@stusta.de> <20060120144114.08f0c340.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8BD55BB2-E4C4-4E73-970B-0C4FD4EDD19B@ubb.ca>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Tony Mantler <nicoya@ubb.ca>
Subject: Re: CONFIG_MK6 = lsof hangs unkillable
Date: Fri, 20 Jan 2006 16:47:15 -0600
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20-Jan-06, at 4:41 PM, Andrew Morton wrote:

> Adrian Bunk <bunk@stusta.de> wrote:
>>
>> On Fri, Jan 20, 2006 at 04:44:07AM -0800, Andrew Morton wrote:
>>> Tony Mantler <nicoya@ubb.ca> wrote:
>>>>
>>>> I'm having trouble running lsof on 2.6.15.1 when the kernel is
>>>> compiled with CONFIG_MK6. When run as root, lsof will segfault, and
>>>> when run as a user lsof will hang unkillable.
>>>>
>>>> The same kernel, same machine, but compiled with CONFIG_MK7 runs  
>>>> just
>>>> lsof just fine.
>>>
>>> That's creepy.  CONFIG_MK6 hardly does anything.  The main thing  
>>> it does is
>>> feed `-march=k6' into the compiler.  MK7 uses `-march=athlon'.
>>> ...
>>
>> CONFIG_MK7 results in a bigger L1_CACHE_SHIFT than CONFIG_MK6.
>>
>> AFAIR it wouldn't be the first time that changing L1_CACHE_SHIFT  
>> would
>> hide a real bug visible with a different L1_CACHE_SHIFT.
>>
>
> hm, OK.  Well that's something we can ask Tony to eliminate, by  
> patching
> his Kconfig.cpu to make CONFIG_MK6 have the larger L1_CACHE_SHIFT  
> (and/or
> vice versa).

Just tested that a few seconds ago, actually.

CONFIG_MK6 with CONFIG_L1_CACHE_SHIFT=6 results in the same crash.

I'm going to twiddle the configs again and see if I can make a  
CONFIG_MK7 kernel with -march=k6


Cheers - Tony 'Nicoya' Mantler :)

--
Tony 'Nicoya' Mantler -- Master of Code-fu -- nicoya@ubb.ca
--  http://nicoya.feline.pp.se/  --  http://www.ubb.ca/  --

