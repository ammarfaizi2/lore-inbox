Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbVJFOKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVJFOKN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 10:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbVJFOKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 10:10:13 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:7634 "EHLO gw1.cosmosbay.com")
	by vger.kernel.org with ESMTP id S1750808AbVJFOKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 10:10:12 -0400
Message-ID: <43453042.4030400@cosmosbay.com>
Date: Thu, 06 Oct 2005 16:10:10 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: discuss@x86-64.org, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, xemul@sw.ru,
       Andrey Savochkin <saw@sawoct.com>, st@sw.ru
Subject: Re: [discuss] Re: SMP syncronization on AMD processors (broken?)
References: <434520FF.8050100@sw.ru> <p73hdbuzs7l.fsf@verdi.suse.de> <43452BAC.3000306@cosmosbay.com> <200510061556.31305.ak@suse.de>
In-Reply-To: <200510061556.31305.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 06 Oct 2005 16:10:07 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen a écrit :
> On Thursday 06 October 2005 15:50, Eric Dumazet wrote:
> 
> 
>>Maybe we should reflect this in Kconfig ?
>>
>>config NR_CPUS
>>range 2 128
>>
>>Or use a plain int for spinlock, instead of a signed char.
> 
> 
> Hmm? 2.6 already uses int as far as I can see.
> 

Not in public 2.6 at least.

ffffffff8030be10 <_spin_lock>:
ffffffff8030be10:   55                      push   %rbp
ffffffff8030be11:   48 89 e5                mov    %rsp,%rbp
ffffffff8030be14:   f0 fe 0f                lock decb (%rdi)
ffffffff8030be17:   0f 88 d1 02 00 00       js     <.text.lock.spinlock>
ffffffff8030be1d:   c9                      leaveq
ffffffff8030be1e:   c3                      retq

Sorry Andi, I only trust assembly :)

Eric

