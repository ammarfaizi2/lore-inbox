Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbUBYRJY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 12:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbUBYRJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 12:09:23 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:9994 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261440AbUBYRIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 12:08:55 -0500
Message-ID: <403CD900.6080003@techsource.com>
Date: Wed, 25 Feb 2004 12:18:56 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Intel vs AMD x86-64
References: <7F740D512C7C1046AB53446D37200173EA2718@scsmsx402.sc.intel.com> <403CCBE0.7050100@techsource.com> <c1ihqh$e0r$1@terminus.zytor.com>
In-Reply-To: <c1ihqh$e0r$1@terminus.zytor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



H. Peter Anvin wrote:
> Followup to:  <403CCBE0.7050100@techsource.com>
> By author:    Timothy Miller <miller@techsource.com>
> In newsgroup: linux.dev.kernel
> 
>>
>>Nakajima, Jun wrote:
>>
>>>No, it's not a problem. Branches with 16-bit operand size are not useful
>>>for compilers.
>>
>> From AMD's documentation, I got the impression that 66H caused near 
>>branches to be 32 bits in long mode (default is 64).
>>
>>So, Intel makes it 16 bits, and AMD makes it 32 bits?
>>
>>Either way, I don't see much use for either one.
>>
> 
> 
> Both claims are pretty bogus.  Shorter branches are quite nice for
> intraprocedural jumps; it reduces the cache footprint.

I think we were talking about absolute branches when referring to "near 
branches".  For absolute branches, having a 32-bit address restricts you 
to the lower 4G of the address space.

For long mode on AMD64, default operand size for _relative_ branch is 32 
bits.  I get the impression that the size of the relative branch operand 
is handled differently from the "segment default word size".


