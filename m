Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWCVQKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWCVQKo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 11:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWCVQKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 11:10:44 -0500
Received: from mxsf17.cluster1.charter.net ([209.225.28.217]:27528 "EHLO
	mxsf17.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751250AbWCVQKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 11:10:43 -0500
X-IronPort-AV: i="4.03,119,1141621200"; 
   d="scan'208"; a="920045331:sNHT18553894"
Message-ID: <442176EB.1050403@cybsft.com>
Date: Wed, 22 Mar 2006 10:10:19 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: "K.R. Foley" <kr@cybsft.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rt1
References: <20060320085137.GA29554@elte.hu> <441F8017.4040302@cybsft.com> <20060321211653.GA3090@elte.hu> <4420B5F0.6000201@cybsft.com> <20060322062932.GA17166@elte.hu> <44215CCB.1080005@cybsft.com>
In-Reply-To: <44215CCB.1080005@cybsft.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

K.R. Foley wrote:
> Ingo Molnar wrote:
>> * K.R. Foley <kr@cybsft.com> wrote:
>>
>>> Sorry I have been onsite and completely buried today. Am running an 
>>> initial test on both UP and SMP now with 2.6.16-rt1. UP doesn't look 
>>> bad at all. SMP on the other hand doesn't look so good. I will give 
>>> -rt4 a spin when these are done.
>> thanks for the testing - i'll check SMP too.
>>
>> 	Ingo
>>
> OK. On my dual 933 under heavy load I get the following with 2.6.16-rt4
> and I get tons of missed interrupts. Running 2.6.15-rc16 I get a max of
> 88usec with most falling under 30usec. On my UP AthlonXP 1700 I get a
> max of 19usec with 2.6.16-rt4 under load. What sort of results do you
> see on SMP?
> 

Found something interesting. Having Wakeup latency timing turned on
makes a HUGE difference. I turned it off and recompiled and now I am
seeing numbers back in line with what I expected from 2.6.16-rt4. Sorry,
but I had no idea it would make that much difference. I don't have a
complete run yet, but I have seen enough to know that I am not seeing
tons of missed interrupts and the highest reported latency thus far is
61 usec.

-- 
   kr
