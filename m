Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263181AbTJUP57 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 11:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbTJUP57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 11:57:59 -0400
Received: from mail-04.iinet.net.au ([203.59.3.36]:46804 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263181AbTJUP55
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 11:57:57 -0400
Message-ID: <3F95577D.7070508@cyberone.com.au>
Date: Wed, 22 Oct 2003 01:57:49 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: rwhron@earthlink.net
CC: venom@sns.it, linux-kernel@vger.kernel.org, dmo@osdl.org, akpm@osdl.org
Subject: Re: [BENCHMARK] I/O regression after 2.6.0-test5
References: <20031021130501.GA4409@rushmore>
In-Reply-To: <20031021130501.GA4409@rushmore>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



rwhron@earthlink.net wrote:

>>If you have time, would you please try testing as-iosched.c from
>>test5 in a later kernel (it won't go into test8-mm1 though).
>>
>
>copying drivers/block/as-iosched.c from 2.6.0-test5 to test8
>looks like it fixes the regression.  Here are the results so far.
>
>In the AIM7 database benchmark, jobs/minute using test5 as-iosched.c
>doubled.  At 32 tasks, jobs/min went from 300 to 601.
>At 256 tasks, jobs/min went from 552 to 1010.
>

Yep, looks right. Thanks for your thoroughness. There are a few
important direct IO bug fixes gone in there as well (hopefully
they aren't causing the regressions... unlikely), so for stability
you'll want to continue to use the test8 version.

I'll get a patch out soon.


