Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbTLHXxS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 18:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTLHXxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 18:53:18 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:43684 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262104AbTLHXxQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 18:53:16 -0500
Message-ID: <3FD50456.3050003@cyberone.com.au>
Date: Tue, 09 Dec 2003 10:08:06 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: Ingo Molnar <mingo@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zwane Mwaikambo <zwane@zwane.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] make cpu_sibling_map a cpumask_t
References: <3FD3FD52.7020001@cyberone.com.au> <20031208155904.GF19412@krispykreme>
In-Reply-To: <20031208155904.GF19412@krispykreme>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Anton Blanchard wrote:

> 
>
>>I'm not aware of any reason why the kernel should not become generally
>>SMT aware. It is sufficiently different to SMP that it is worth
>>specialising it, although I am only aware of P4 and POWER5 implementations.
>>
>
>I agree, SMT is likely to become more popular in the coming years.
>
>
>>I have an alternative to Ingo's HT scheduler which basically does
>>the same thing. It is showing a 20% elapsed time improvement with a
>>make -j3 on a 2xP4 Xeon (4 logical CPUs).
>>
>>Before Ingo's is merged, I would like to discuss the pros and cons of
>>both approaches with those interested. If Ingo's is accepted I should
>>still be able to port my other SMP/NUMA improvements on top of it.
>>
>
>Sounds good, have you got anything to test? I can throw it on a POWER5.
>

It would be great to get some testing on another architecture.

I don't have an architecture independant way to build SMT scheduling
descriptions, although with the cpu_sibling_map change, you can copy
and paste the code for the P4 if you are able to build a cpu_sibling_map.

I'll just have to add a some bits so SMT and NUMA work together which
I will be unable to test. I'll get back to you with some code.


