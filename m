Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268024AbUIUTia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268024AbUIUTia (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 15:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbUIUTia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 15:38:30 -0400
Received: from mail3.utc.com ([192.249.46.192]:16077 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S268024AbUIUTi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 15:38:27 -0400
Message-ID: <41508311.6070606@cybsft.com>
Date: Tue, 21 Sep 2004 14:37:53 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S1
References: <1094473527.13114.4.camel@boxen> <20040906122954.GA7720@elte.hu> <20040907092659.GA17677@elte.hu> <20040907115722.GA10373@elte.hu> <1094597988.16954.212.camel@krustophenia.net> <20040908082050.GA680@elte.hu> <1094683020.1362.219.camel@krustophenia.net> <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu> <415071D4.9060601@cybsft.com> <20040921192143.GA1184@elte.hu>
In-Reply-To: <20040921192143.GA1184@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>Ingo Molnar wrote:
>>
>>>i've released the -S1 VP patch:
>>>
>>> http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm1-S1
>>>
>>
>>Two separate oopses this morning running that above patch. One appears
>>to happen in locks_delete_lock. [...]
> 
> 
> i too got this one today. Seems to be related to the BKL changes -
> locks.c is a heavy user of the BKL. You have an SMP system, right? Does
> the oops happen if you boot with maxcpus=1?
> 
> 	Ingo
> 
This was on my SMP system. I can try the maxcpus=1. However, the trouble 
may be reproducing the oops. This happened at ~5:35 this morning (~9 
hrs. ago). Hadn't happened again as of an hour ago when I booted S2. I 
will give it a try though.

kr
