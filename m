Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267988AbTGIAWh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 20:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268005AbTGIAWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 20:22:37 -0400
Received: from dyn-ctb-203-221-72-225.webone.com.au ([203.221.72.225]:9220
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S267988AbTGIAVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 20:21:36 -0400
Message-ID: <3F0B6374.2090803@cyberone.com.au>
Date: Wed, 09 Jul 2003 10:36:04 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.74-mm1
References: <20030703023714.55d13934.akpm@osdl.org> <200307080213.53203.phillips@arcor.de> <Pine.LNX.4.55.0307071724540.3524@bigblue.dev.mcafeelabs.com> <200307080307.18018.phillips@arcor.de> <Pine.LNX.4.55.0307072314490.3597@bigblue.dev.mcafeelabs.com> <3F0A8C5C.1070602@cyberone.com.au> <Pine.LNX.4.55.0307080821160.4544@bigblue.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.55.0307080821160.4544@bigblue.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Davide Libenzi wrote:

>On Tue, 8 Jul 2003, Nick Piggin wrote:
>
>
>>I agree some people have some inflated ideas about a desktop workload,
>>but I'd just point out that if your mp3 player was using say 2% CPU,
>>it should be able to preempt the make soon after it becomes runnable,
>>and not have to wait at the end of the queue. It would become a CPU
>>hog itself if you had 48 other processes running though.
>>
>
>This is clearly true, actually even more since player usually suck way
>less than 2% of the CPU. If no video is involved, they simply do a write()
>to /dev/dsp and then they sync by calling GETOSPACE and sleeping in the
>"hope" to be wake up almost in time. I never said that the scheduler
>should not be fixed. It definitely has to.
>

Well, yeah, I can run xmms on my 2xCPU system with 32 processes in
an infinite loop, and 32 in an infinite loop of fork+wait. No skipping.
So maybe gcc gets its priority elevated too much due to the small
amount of waiting it does.


