Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270499AbTHLPVw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 11:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270501AbTHLPVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 11:21:52 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:57872 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S270499AbTHLPVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 11:21:49 -0400
Message-ID: <3F390969.8080309@techsource.com>
Date: Tue, 12 Aug 2003 11:36:09 -0400
From: Timothy Miller <tim@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: rob@landley.net, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O13int for interactivity
References: <200308050207.18096.kernel@kolivas.org> <200308052022.01377.kernel@kolivas.org> <3F2F87DA.7040103@cyberone.com.au> <200308110248.09399.rob@landley.net> <3F385633.3090807@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>>
>
> I don't quite understand what you are getting at, but if you don't 
> want to
> sleep you should be able to use a non blocking syscall. But in some cases
> I think there are times when you may not be able to use a non blocking 
> call.
>
> And if a process is a CPU hog, its a CPU hog. If its not its not. Doesn't
> matter how it would behave on another system.
>
>

The idea is that this kind of process WANTS to be a CPU hog.  If it were 
not for the fact that the I/O is not immediately available, it would 
never want to sleep.  The only thing it ever blocks on is the read, and 
this is involuntary.  It doesn't use a non blocking call because it 
can't continue without the data.

The questions is:  Does this matter for the issue of interactivity?


