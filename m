Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751555AbWHAC3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbWHAC3X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 22:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbWHAC3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 22:29:22 -0400
Received: from terminus.zytor.com ([192.83.249.54]:51936 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751363AbWHAC3W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 22:29:22 -0400
Message-ID: <44CEBC6D.4040400@zytor.com>
Date: Mon, 31 Jul 2006 19:29:01 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86_64 built-in command line
References: <20060731171442.GI6908@waste.org> <200607312207.58999.ak@suse.de> <44CE6AEA.2090909@zytor.com> <200608010017.00826.ak@suse.de> <20060801014319.GO6908@waste.org>
In-Reply-To: <20060801014319.GO6908@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Tue, Aug 01, 2006 at 12:17:00AM +0200, Andi Kleen wrote:
>> On Monday 31 July 2006 22:41, H. Peter Anvin wrote:
>>> Andi Kleen wrote:
>>>>   
>>>>> +#ifdef CONFIG_CMDLINE_BOOL
>>>>> +	strlcpy(saved_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
>>>>> +#endif
>>>> I think I would prefer a strcat.
>>>>
>>>> Also you should describe the exact behaviour (override/append) in Kconfig help.
>>>>
>>> In the i386 thread, Matt described having a firmware bootloader which 
>>> passes bogus parameters.  For that case, it would make sense to have a 
>>> non-default CONFIG option to have override rather than conjoined (and I 
>>> maintain that the built-in command line should be prepended.)
>> Is that boot loader common? What's its name? 
>> If not I would prefer that he keeps the one liner patch to deal
>> with that private.
>>
>> For generic semantics strcat (or possible prepend) is probably better.
> 
> No, it doesn't work for numerous kernel options that can't be negated.
> 

How about we fix the real problem, then?

	-hpa
