Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265369AbSL1B5O>; Fri, 27 Dec 2002 20:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbSL1B5O>; Fri, 27 Dec 2002 20:57:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17415 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265369AbSL1B5N>; Fri, 27 Dec 2002 20:57:13 -0500
Message-ID: <3E0D06AA.80201@transmeta.com>
Date: Fri, 27 Dec 2002 18:04:26 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Ulrich Drepper <drepper@redhat.com>, bart@etpmod.phys.tue.nl,
       davej@codemonkey.org.uk, terje.eggestad@scali.com,
       Matti Aarnio <matti.aarnio@zmailer.org>, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212242127190.6603-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> On Tue, 24 Dec 2002, Linus Torvalds wrote:
> 
> 
>>I realized that there is really no reason to use __KERNEL_DS for this,
>>and that as far as the kernel is concerned, the only thing that matters
>>is that it's a flat 32-bit segment. So we might as well make the kernel
>>always load ES/DS with __USER_DS instead, which has the advantage that
>>we can avoid one set of segment loads for the "sysenter/sysexit" case.
> 
> 
> this basically hardcodes flat segment layout on x86. If anything (Wine?)
> modifies the default segments, it can wrap syscalls by saving/restoring
> the modified %ds and %es selectors explicitly.
> 

I don't think you can modify the GDT segments.

	-hpa

P.S. Please don't use my @transmeta.com address for non-Transmeta 
business.  I'm trying very hard to keep my mailboxes semi-organized.



