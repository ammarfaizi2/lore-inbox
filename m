Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWJENX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWJENX6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 09:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWJENX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 09:23:58 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:47537 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750843AbWJENX5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 09:23:57 -0400
Message-ID: <452506A2.2020103@aitel.hist.no>
Date: Thu, 05 Oct 2006 15:20:34 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Vadim Lobanov <vlobanov@speakeasy.net>
CC: Andrew Morton <akpm@osdl.org>, Matthew Wilcox <matthew@wil.cx>,
       linux-kernel@vger.kernel.org
Subject: Re: Must check what?
References: <20061004183752.GG28596@parisc-linux.org> <20061004192537.GH28596@parisc-linux.org> <20061004124310.10c9939b.akpm@osdl.org> <200610041358.36515.vlobanov@speakeasy.net>
In-Reply-To: <200610041358.36515.vlobanov@speakeasy.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vadim Lobanov wrote:
> On Wednesday 04 October 2006 12:43, Andrew Morton wrote:
>   
>> I like assertions personally.  If we had something like:
>>
>> void foo(args)
>> {
>> 	locals;
>>
>> 	assert_irqs_enabled();
>> 	assert_spin_locked(some_lock);
>> 	assert_in_atomic();
>> 	assert_mutex_locked(some_mutex);
>>
>> then we get documentation which is (optionally) checked at runtime - best
>> of both worlds.  Better than doing it in kernel-doc.  Automatically
>> self-updating (otherwise kernels go BUG).
>>     
>
> Uhoh! How much is that going to hurt runtime? :) It actually seems to me like 
> this should be doable by static code analysis tools without terribly much 
> pain (in the relative sense of the term). Or am I wrong on this thought?
>   
Surely, any debugging that hurts will only really be there
if you enable CONFIG_DEBUG_something

The kind of stuff you ask people to turn on when they report
strange crashes.

Helge Hafting
