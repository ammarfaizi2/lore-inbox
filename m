Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272417AbTHEDbm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 23:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272418AbTHEDbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 23:31:42 -0400
Received: from dyn-ctb-210-9-244-254.webone.com.au ([210.9.244.254]:16396 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S272417AbTHEDbl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 23:31:41 -0400
Message-ID: <3F2F2517.7080507@cyberone.com.au>
Date: Tue, 05 Aug 2003 13:31:35 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O13int for interactivity
References: <200308050207.18096.kernel@kolivas.org> <200308051220.04779.kernel@kolivas.org> <3F2F149F.1020201@cyberone.com.au> <200308051318.47464.kernel@kolivas.org>
In-Reply-To: <200308051318.47464.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>On Tue, 5 Aug 2003 12:21, Nick Piggin wrote:
>
>>No, this still special-cases the uninterruptible sleep. Why is this
>>needed? What is being worked around? There is probably a way to
>>attack the cause of the problem.
>>
>
>Footnote: I was thinking of using this to also _elevate_ the dynamic priority 
>of tasks waking from interruptible sleep as well which may help throughput.
>

Con, an uninterruptible sleep is one which is not be woken by a signal,
an interruptible sleep is one which is. There is no other connotation.
What happens when read/write syscalls are changed to be interruptible?
I'm not saying this will happen... but come to think of it, NFS probably
has interruptible read/write.

In short: make the same policy for an interruptible and an uninterruptible
sleep.




