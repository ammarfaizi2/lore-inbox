Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbUCVQDV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 11:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbUCVQDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 11:03:21 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:1286 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262073AbUCVQCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 11:02:52 -0500
Message-ID: <405F121E.40701@techsource.com>
Date: Mon, 22 Mar 2004 11:19:42 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Tigran Aivazian <tigran@veritas.com>
CC: David Schwartz <davids@webmaster.com>, Justin Piszcz <jpiszcz@hotmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Microcode Question
References: <Pine.LNX.4.44.0403191721110.3892-100000@einstein.homenet>     <405F0B8D.8040408@techsource.com> <Pine.GSO.4.58.0403220736480.8694@south.veritas.com>
In-Reply-To: <Pine.GSO.4.58.0403220736480.8694@south.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Tigran Aivazian wrote:
> On Mon, 22 Mar 2004, Timothy Miller wrote:
> 
>>I don't see anything wrong with what he said.  As I understand it,
>>Pentium 4 CPUs don't use microcode for much of anything.  If an
>>instruction which was done entirely in dedicated hardware was buggy, and
>>it's replaced by microcode, then it will most certainly be slower.
>>
>>You seem to have missed where David used terms like "theoretically
>>possible" and "an operation".
> 
> 
> No, that is not what he said and that (what you say) is certainly wrong,
> namely this bit:
> 
>   If an instruction which was done entirely in dedicated hardware was
>   buggy, and it's replaced by microcode, then it will most certainly be
>   slower.
> 
> All instructions are done by means of microcode of some sort, i.e. the
> instructions are "compiled" as they are executed into a more primitive
> instruction set (called "microcode" or "u-code"). If a buggy instruction
> (or rather the sequence of microcode which corresponds to it) is replaced
> by a fixed version (i.e. by some other sequence of microcode) then there
> is no reason to say that the result will "most certainly be slower". For
> some bugs the fix runs faster than the broken code, for others it may be
> slower --- there is no way to tell apriori that it will always be slower.
> 
> Do you understand now?

What you're describing is not microcode in the traditional sense. 
Traditionally, microcode is a program store in the processor, and 
machine instructions cause the CPU to start executing micro instructions 
from that program store.  The Pentium 4 doesn't operate that way.

On the other hand, it would make sense to have some of the instruction 
decode being done using lookup tables, but the complexity of the x86 
instruction set is such that it can't all be done that way.

