Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267385AbUJWFtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267385AbUJWFtw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 01:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267618AbUJWFtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 01:49:33 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:41061 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267385AbUJWFsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 01:48:45 -0400
Message-ID: <4179F0B9.20908@yahoo.com.au>
Date: Sat, 23 Oct 2004 15:48:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: root@chaos.analogic.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: printk() with a spin-lock held.
References: <Pine.LNX.4.61.0410221504500.6075@chaos.analogic.com> <1098503815.13176.2.camel@krustophenia.net>
In-Reply-To: <1098503815.13176.2.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Fri, 2004-10-22 at 15:07 -0400, Richard B. Johnson wrote:
> 
>>Linux-2.6.9 will bug-check and halt if my code executes
>>a printk() with a spin-lock held.
>>
>>Is this the intended behavior?
> 
> 
> Yes.  printk() can sleep.  No sleeping with a spinlock held.
> 

You can call printk anywhere (except from the scheduler).
Or if you're doing tricky things with preempt.

> 
>>If so, NotGood(tm).
> 
> 
> See above.  If you think you can improve the situation, patches are
> welcome, as always.
> 

In this case, the patch would be to himself though.
