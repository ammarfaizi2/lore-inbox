Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWJWUkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWJWUkF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWJWUkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:40:05 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:20624 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1751298AbWJWUkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:40:01 -0400
Message-ID: <453D289A.1040306@qumranet.com>
Date: Mon, 23 Oct 2006 22:39:54 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/13] KVM: virtualization infrastructure
References: <453CC390.9080508@qumranet.com> <200610232135.02684.arnd@arndb.de> <453D2604.5010208@qumranet.com> <200610232235.29287.arnd@arndb.de>
In-Reply-To: <200610232235.29287.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Oct 2006 20:40:00.0617 (UTC) FILETIME=[68FEB590:01C6F6E3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
>>>> +struct segment_descriptor {
>>>> +    u16 limit_low;
>>>> +    u16 base_low;
>>>> +    u8  base_mid;
>>>> +    u8  type : 4;
>>>> +    u8  system : 1;
>>>> +    u8  dpl : 2;
>>>> +    u8  present : 1;
>>>> +    u8  limit_high : 4;
>>>> +    u8  avl : 1;
>>>> +    u8  long_mode : 1;
>>>> +    u8  default_op : 1;
>>>> +    u8  granularity : 1;
>>>> +    u8  base_high;
>>>> +} __attribute__((packed));
>>>>    
>>>>         
>>> Bitfields are generally frowned upon. It's better to define
>>> constants for each of these and use a u64.
>>>       
>> Any specific reasons?  I find the code much more readable (and
>> lowercase) with bitfields.
>>     
>
> The strongest reason against bitfields is that they are not
> endian-clean. This doesn't apply on a architecture-specific
> patch such as KVM, but it just feels wrong to read code
> with bit fields in the kernel.
>
>   

Okay, will change.  It's very localized anyway.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

