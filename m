Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263390AbVCKPbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263390AbVCKPbz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 10:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbVCKPby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 10:31:54 -0500
Received: from mail3.utc.com ([192.249.46.192]:10626 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S263379AbVCKPbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 10:31:16 -0500
Message-ID: <4231B9A7.5050709@cybsft.com>
Date: Fri, 11 Mar 2005 09:30:47 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rostedt@goodmis.org
CC: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
References: <20050204100347.GA13186@elte.hu> <1108789704.8411.9.camel@krustophenia.net> <Pine.LNX.4.58.0503100323370.14016@localhost.localdomain> <Pine.LNX.4.58.0503100447150.14016@localhost.localdomain> <20050311095747.GA21820@elte.hu> <Pine.LNX.4.58.0503110508360.19798@localhost.localdomain> <20050311101740.GA23120@elte.hu> <Pine.LNX.4.58.0503110521390.19798@localhost.localdomain> <20050311024322.690eb3a9.akpm@osdl.org> <Pine.LNX.4.58.0503110754240.19798@localhost.localdomain> <Pine.LNX.4.58.0503111006160.19798@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.58.0503111006160.19798@localhost.localdomain>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
>>+#ifdef CONFIG_PREEMPT_RT
>>+#define PICK_SPIN_LOCK(otype,bit,name) spin_##otype(&bh->b_##name##_lock)
>>+#else
>>+#define PICK_SPIN_LOCK(otype,bit,name) bit_spin_##otype(bit,bh->b_state);
>>+#endif
>>+
> 
> 
> Oops, extra semicolon on the non RT side.
> 
> 
> I'll try again.
> 
> -- Steve

Haven't tried it yet, but does apply cleanly to 2.6.11-final-V0.7.40-00.

kr
