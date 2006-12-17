Return-Path: <linux-kernel-owner+w=401wt.eu-S1751996AbWLQFQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbWLQFQ6 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 00:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994AbWLQFQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 00:16:58 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46164 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbWLQFQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 00:16:57 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tobias Diedrich <ranma+kernel@tdiedrich.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Yinghai Lu <yinghai.lu@amd.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: IO-APIC + timer doesn't work
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
	<20061216174536.GA2753@melchior.yamamaya.is-a-geek.org>
	<Pine.LNX.4.64.0612160955370.3557@woody.osdl.org>
	<20061216225338.GA2616@melchior.yamamaya.is-a-geek.org>
	<20061216230605.GA2789@melchior.yamamaya.is-a-geek.org>
	<Pine.LNX.4.64.0612161518080.3479@woody.osdl.org>
	<20061216235513.GA2424@melchior.yamamaya.is-a-geek.org>
	<Pine.LNX.4.64.0612161603070.3479@woody.osdl.org>
Date: Sat, 16 Dec 2006 22:16:14 -0700
In-Reply-To: <Pine.LNX.4.64.0612161603070.3479@woody.osdl.org> (Linus
	Torvalds's message of "Sat, 16 Dec 2006 16:04:45 -0800 (PST)")
Message-ID: <m1hcvvt84h.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 17 Dec 2006, Tobias Diedrich wrote:
>> 
>> No such luck, it still panics and the APIC error is also unchanged.
>
> Ok. I don't see anything wrong off-hand, but I'll keep the patch in the 
> tree in the hopes that Andi and/or Eric can see what's wrong and solve it.
>
> If we don't find a solution, I'll have to revert it, but let's give it a 
> few more days. 
>
> Tobias, can you please make sure to remind me about this if nothing seems 
> to happen? 

Just skimming for differences the first test seems to be missing an
umask_IO_APIC_irq(0);

It would be good to know which case is working before this change was made.

Eric
