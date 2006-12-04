Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936202AbWLDM1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936202AbWLDM1n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936254AbWLDM1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:27:43 -0500
Received: from gateway-1237.mvista.com ([63.81.120.155]:37660 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S936202AbWLDM1n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:27:43 -0500
Message-ID: <4574149B.5070602@ru.mvista.com>
Date: Mon, 04 Dec 2006 15:29:15 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t in	latency_trace.c
 (take 3)
References: <200611132252.58818.sshtylyov@ru.mvista.com> <457326A2.2020402@ru.mvista.com> <20061204095131.GE7872@elte.hu>
In-Reply-To: <20061204095131.GE7872@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Ingo Molnar wrote:

>>   What was the destiny of that patch? I haven't seen it accepted, 
>>haven't seen any comments... while this is not a mere warning fix. 
>>What am I expected to do to get it accepted -- recast it against 
>>2.6.19-rt1?

> i'd suggest to redo it - but please keep it simple and clean. Those 
> dozens of casts to u64 are quite ugly.

    Alas, there's *nothing* I can do about it with 32-bit cycles_t. And if you 
look at the kernel, this is not the only case of such "ugliness", look at this 
commit for example:

http://www.kernel.org/git/?p=linux/kernel/git/paulus/powerpc.git;a=commit;h=685143ac1f7a579a3fac9c7f2ac8f82e95af6864

> Why is cycles_t 32-bits on some 
> of the arches to begin with?

    I guess this was done for speed reasons. That's not a qustion for me 
although...

> 	Ingo

WBR, Sergei
