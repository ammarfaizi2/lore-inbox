Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266631AbUIOTnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266631AbUIOTnu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 15:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267333AbUIOTnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 15:43:50 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:31387 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S266631AbUIOTns
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 15:43:48 -0400
Message-ID: <41489B7A.6010407@tmr.com>
Date: Wed, 15 Sep 2004 15:43:54 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Lee Revell <rlrevell@joe-job.com>, Andrea Arcangeli <andrea@novell.com>,
       Chris Wedgwood <cw@f00f.org>, Arjan van de Ven <arjanv@redhat.com>,
       Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
References: <1095027951.22893.69.camel@krustophenia.net><1095027951.22893.69.camel@krustophenia.net> <20040913061641.GA11276@elte.hu>
In-Reply-To: <20040913061641.GA11276@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> 
>>Yes, on a server you would probably disable threading for the disk and
>>network IRQs (the VP patch lets you set this via /proc).  This feature
>>effectively gives you IPLs on Linux, albeit only two of them. [...]
> 
> 
> nono, this has no relation to IPLs. IPLs are a pretty crude hack to
> implement exclusion on a very (and too) broad level. IRQ threading is a
> way to serialize hardirq contexts into a process context and to make
> them schedulable and preemptable. It basically 'flattens out' all the
> hardirq nesting (and parallelism) that may happen on a default kernel
> and together with softirq 'flattening' it creates a deterministic
> execution environment.
> 
> it is not intended for servers, due to the overhead of redirection. It's
> for realtime workloads and for latency-sensitive audio desktop
> workloads. For servers and normal desktops the current IRQ and softirq
> model is pretty OK.

Okay, I'll be the one to ask... what overload of the IPL acronym are you 
using here? I asked google and several jargon files, and they all say 
that IPL (initial program load) is IBMspeak for cold boot. Somehow I 
don't think that's what you mean here.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
