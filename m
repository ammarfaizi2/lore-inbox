Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267971AbUIUSwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267971AbUIUSwf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 14:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267967AbUIUSwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 14:52:35 -0400
Received: from mail4.utc.com ([192.249.46.193]:15569 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S267971AbUIUSwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 14:52:15 -0400
Message-ID: <4150783C.1080605@cybsft.com>
Date: Tue, 21 Sep 2004 13:51:40 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S2
References: <20040906122954.GA7720@elte.hu> <20040907092659.GA17677@elte.hu> <20040907115722.GA10373@elte.hu> <1094597988.16954.212.camel@krustophenia.net> <20040908082050.GA680@elte.hu> <1094683020.1362.219.camel@krustophenia.net> <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu>
In-Reply-To: <20040921074426.GA10477@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i've released the -S2 VP patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm1-S2
> 

Another smp_processor_id in modprobe. Now I see these for every 
modprobe. Is this a different global lock?

Sep 21 13:27:53 porky kernel: using smp_processor_id() in preemptible 
code: modprobe/1737
Sep 21 13:27:53 porky kernel:  [<c011c58e>] smp_processor_id+0x8e/0xa0
Sep 21 13:27:53 porky kernel:  [<c01401e5>] __stop_machine_run+0xb5/0xc0
Sep 21 13:27:53 porky kernel:  [<c013de30>] __try_stop_module+0x0/0x46
Sep 21 13:27:53 porky kernel:  [<c01151e8>] mcount+0x14/0x18
Sep 21 13:27:53 porky kernel:  [<c0140214>] stop_machine_run+0x24/0x3d
Sep 21 13:27:53 porky kernel:  [<c013de30>] __try_stop_module+0x0/0x46
Sep 21 13:27:53 porky kernel:  [<c013b019>] try_stop_module+0x39/0x40
Sep 21 13:27:53 porky kernel:  [<c013de30>] __try_stop_module+0x0/0x46
Sep 21 13:27:53 porky kernel:  [<c013b1e0>] sys_delete_module+0x110/0x180
Sep 21 13:27:53 porky kernel:  [<c0154c09>] sys_munmap+0x59/0x80
Sep 21 13:27:53 porky kernel:  [<c01066b9>] sysenter_past_esp+0x52/0x71

kr

