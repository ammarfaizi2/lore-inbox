Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbTLTXRz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 18:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTLTXRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 18:17:55 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:25501 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261812AbTLTXRx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 18:17:53 -0500
Message-ID: <3FE4D89C.2050605@cyberone.com.au>
Date: Sun, 21 Dec 2003 10:17:48 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] 2.6.0 sched fork cleanup
References: <3FE46885.2030905@cyberone.com.au> <3FE468BF.9000102@cyberone.com.au> <20031220195542.GA32320@elte.hu>
In-Reply-To: <20031220195542.GA32320@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:

>* Nick Piggin <piggin@cyberone.com.au> wrote:
>
>
>>Move some fork related scheduler policy from fork.c to sched.c where
>>it belongs.
>>
>
>this only makes sense if all the other fork-time initializations are
>done in sched.c too - these are scattered all around copy_process(). 
>The attached patch (it compiles & boots) does this. All the lowlevel
>scheduler logic (that was done in fork.c) is now in sched.c - fork.c
>only sees the higher level primitives. I've also updated a couple of
>comments that relate to the affected code.
>

OK I missed those bits. Looks good, of course. Thanks Ingo


