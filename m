Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbUBZANu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 19:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbUBZANu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 19:13:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19719 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262262AbUBZANq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 19:13:46 -0500
Message-ID: <403D3A2B.40504@zytor.com>
Date: Wed, 25 Feb 2004 16:13:31 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: "Nakajima, Jun" <jun.nakajima@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Intel vs AMD x86-64
References: <7F740D512C7C1046AB53446D37200173EA27D6@scsmsx402.sc.intel.com> <403D3379.60604@techsource.com>
In-Reply-To: <403D3379.60604@techsource.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> 
> 
> Nakajima, Jun wrote:
> 
>> For near branches (CALL, RET, JCC, JCXZ, JMP, etc.), the operand size is
>> forced to 64 bits on both processors in 64-bit mode, basically meaning
>> RIP is updated.
>>
>> Compilers would typically use a JMP short for "intraprocedural jumps",
>> which requires just an 8-bit displacement relative to RIP. 
> 
> I see.  It's too bad you can't have a 16-bit displacement.
> 
> Ummm... so if 66H were used with a near branch, would that affect the
> size of the immediate operand which gets added to RIP, or would that
> affect the the portion of IP/EIP/RIP affected?  If it's the latter,
> that's pretty silly.
> 

Yes, that would be pretty silly.

I honestly don't remember off the top of my head what "o16 jmp blah"
does on i386; I have a vague memory that it zero-extends %eip to 32
bits, which makes it useless, of course.

	-hpa

