Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266222AbUGJMGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266222AbUGJMGH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 08:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266224AbUGJMGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 08:06:07 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:19075 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266223AbUGJMFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 08:05:54 -0400
Message-ID: <40EFDB97.70109@yahoo.com.au>
Date: Sat, 10 Jul 2004 22:05:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Con Kolivas <kernel@kolivas.org>, Peter Williams <pwil3058@bigpond.net.au>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Likelihood of rt_tasks
References: <40EE6CC2.8070001@kolivas.org> <40EF2FF2.6000001@bigpond.net.au> <40EF354F.9090903@kolivas.org> <20040710111528.GA22265@elte.hu>
In-Reply-To: <20040710111528.GA22265@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> the unlikely() check in rt_task() was mainly done because there was a
> steady stream of microoptimizations that added unlikely() to rt_task().
> So now we do in everywhere and have removed the unlikely()/likely()
> branches from sched.c. It doesnt really matter in real-world terms, but
> it will make the common case code (non-RT) a tiny bit more compact. And
> i challenge anyone to be able to even measure the difference to an RT
> task.
> 

Also, the scenario where it may possibly make a tiny positive
contribution (something *very* scheduler bound) would be using
non-RT tasks I'd say.
