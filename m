Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbTLKNab (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 08:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264938AbTLKNab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 08:30:31 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:63955 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264937AbTLKNaa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 08:30:30 -0500
Message-ID: <3FD8715F.9070304@cyberone.com.au>
Date: Fri, 12 Dec 2003 00:30:07 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Anton Blanchard <anton@samba.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [CFT][RFC] HT scheduler
References: <3FD3FD52.7020001@cyberone.com.au> <20031208155904.GF19412@krispykreme> <3FD50456.3050003@cyberone.com.au> <20031209001412.GG19412@krispykreme> <3FD7F1B9.5080100@cyberone.com.au> <3FD81BA4.8070602@cyberone.com.au> <3FD8317B.4060207@cyberone.com.au> <20031211115222.GC8039@holomorphy.com> <3FD86C70.5000408@cyberone.com.au> <20031211132301.GD8039@holomorphy.com>
In-Reply-To: <20031211132301.GD8039@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:

>William Lee Irwin III wrote:
>
>>>If this thing is heavily threaded, it could be mm->page_table_lock.
>>>
>
>On Fri, Dec 12, 2003 at 12:09:04AM +1100, Nick Piggin wrote:
>
>>I'm not sure how threaded it is, probably very. Would inline spinlocks
>>help show up mm->page_table_lock?
>>It really looks like .text.lock.futex though, doesn't it? Would that be
>>the hashed futex locks? I wonder why it suddenly goes downhill past about
>>140 rooms though.
>>
>
>It will get contention anyway if they're all pounding on the same futex.
>OTOH, if they're all threads in the same process, they can hit other
>problems. I'll try to find out more about hackbench.
>


Oh, sorry I was talking about volanomark. hackbench AFAIK doesn't use
futexes at all, just pipes, and is not threaded at all, so it looks like
a different problem to the volanomark one.

hackbench runs into trouble at large numbers of tasks too though.


