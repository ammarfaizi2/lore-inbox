Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVCIO21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVCIO21 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 09:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVCIO1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 09:27:45 -0500
Received: from mail4.utc.com ([192.249.46.193]:30713 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S261634AbVCIO11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 09:27:27 -0500
Message-ID: <422F07C2.7080900@cybsft.com>
Date: Wed, 09 Mar 2005 08:27:14 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       "Jack O'Quin" <joq@io.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11 low latency audio test results
References: <1110324852.6510.11.camel@mindpipe>
In-Reply-To: <1110324852.6510.11.camel@mindpipe>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> OK, I have run some simple tests with JACK, Hydrogen, and 2.6.11.
> 
> 2.6.11 does not seem to be much of an improvement over 2.6.10.  It may
> in fact be slightly worse.  This was what I expected, as it appears that
> a number of latency fixes in the VM got preempted by the 4-level page
> tables merge.
> 
> At 32 frames (0.667 ms latency) I get an xrun about every 10-20 seconds,
> just running JACK and Hydrogen.
> 
> At 64 frames (1.33 ms latency) it's better, but I can easily cause
> massive xruns with "dbench 32".
> 
> At 128 frames (2.66 ms) it seems to work pretty well.
> 
> Overall, this puts us about even with Windows XP, and somewhat worse
> than Mac OS X.
> 
> Of course all of the above settings provide flawless xrun-free
> performance with 2.6.11-rc4 + PREEMPT_RT.
> 

The above mentioned patch will apply (and build and run) just fine to 
2.6.11 if you fix the EXTRAVERSION portion of the patch to not expect -rc4.

> Until Ingo releases the RT preempt patch for 2.6.11, I can't provide
> details, because the vanilla kernel lacks sufficient instrumentation.
> But the above results should help us move in the right direction.
> 
> Given the above results, and the performance of the RT patched kernel,
> I don't see why 2.6.12 should not be able to solidly outperform Windows
> and Mac in this area.
> 
> See the "Latency regressions" thread for some areas that might need
> attention.
> 
> Lee
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

