Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263621AbUCUIJO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 03:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263622AbUCUIJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 03:09:14 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:48092 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263621AbUCUIJN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 03:09:13 -0500
Message-ID: <405D4D98.1070601@cyberone.com.au>
Date: Sun, 21 Mar 2004 19:08:56 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [BENCHMARKS] 2.6.4 vs 2.6.4-mm1
References: <40525C1F.5030705@cyberone.com.au> <20040319095047.GA6301@elte.hu> <405AC456.1070806@cyberone.com.au> <405D1433.4000904@cyberone.com.au> <20040321073119.GA4165@elte.hu>
In-Reply-To: <20040321073119.GA4165@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:

>your patch looks interesting. 
>
>

I'll see if I can get some numbers for it soon.

>wrt. making a fully scalable MM read side:
>
>perphaps RCU could be used to make lookup access to the vma tree and
>lookup of the pagetables lockless. This would make futexes (and
>pagefaults) fundamentally scalable.
>
>another option would be to introduce a rwsem which is read-scalable, but
>this would pessimise writes quite as bad as brlocks did. I'm not sure
>how acceptable that is.
>
>

It is a pretty silly benchmark. But I guess one day someone
is going to complain about mm scalability.
