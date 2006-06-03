Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWFCW0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWFCW0T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 18:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWFCW0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 18:26:19 -0400
Received: from terminus.zytor.com ([192.83.249.54]:13733 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751401AbWFCW0S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 18:26:18 -0400
Message-ID: <44820C7D.6080501@zytor.com>
Date: Sat, 03 Jun 2006 15:26:05 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: maximilian attems <maks@sternwelten.at>
CC: linux-kernel@vger.kernel.org, klibc list <klibc@zytor.com>
Subject: Re: [PATCH] klibc
References: <20060602081416.GA11358@nancy>
In-Reply-To: <20060602081416.GA11358@nancy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maximilian attems wrote:
> On Thu, 01 June 2006, H. Peter Anvin wrote:
>> Brian F. G. Bidulock wrote:
>>> On Thu, 01 Jun 2006, Bob Picco wrote:
>>>>  
>>>> -#if !defined(__x86_64__) && !defined(__ia64__) && !defined(__sparc_v9__)
>>>> +#if !defined(__x86_64__) && !defined(__ia64__) && !defined(__sparc_v9__) && \
>>>> +	!defined(__powerpc64__)
>>> Why not just !defined(__LP64__) ?
>> _BITSIZE == 64 is really the right formula... if I remember correctly, there were some 
>> 64-bit platforms (Alpha?) which didn't conform, though.  I will look at this later today.
>>
>> 	-hpa
> 
> indeed aboves line contains an mistake by an earlier patch of mine.
> 
> -#if !defined(__x86_64__) && !defined(__ia64__) && !defined(__sparc_v9__)
> +#if !defined(__x86_64__) && !defined(__ia64__) && !defined(__arch64__)
> 
> is atm needed to get statfs right on sparc.
> 

__arch64__ is ugly; it doesn't say it's a sparc thing.  I have added 
-D__sparc_v9__ to the sparc64 MCONFIG file, so I think that's fine.

Perhaps the right thing to do is to make this an archconfig.h configurable.

	-hpa
