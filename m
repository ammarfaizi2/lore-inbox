Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbUB1LXT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 06:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbUB1LXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 06:23:19 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:58269 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261613AbUB1LXF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 06:23:05 -0500
Message-ID: <40407A14.90108@cyberone.com.au>
Date: Sat, 28 Feb 2004 22:23:00 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: sched domains kernbench improvements
References: <200402282159.58452.kernel@kolivas.org> <40407847.7040403@cyberone.com.au> <200402282218.41590.kernel@kolivas.org>
In-Reply-To: <200402282218.41590.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>On Sat, 28 Feb 2004 22:15, Nick Piggin wrote:
>
>>Con Kolivas wrote:
>>
>>>Hi Nick
>>>
>>>
>>>>So it is more a matter of tuning than anything fundamental
>>>>
>>>Geez I know how you feel... :-D
>>>
>>>
>>>I tried it on the X440 with sched smt disabled
>>>
>>>better than before but still slower than vanilla on half load; however
>>>better than vanilla on optimal and full load now! I wonder whether the
>>>worse result on half load is as relevant since this is 8x HT cpus?
>>>
>>Thanks. Yep the drop off at half load is to be expected with
>>CONFIG_SCHED_SMT turned off.
>>
>
>Will this affect the SCHED_SMT performance and should I do a round of benchies 
>with this enabled?
>
>

It will as far as balancing between physical CPUs, yes. It probably
doesn't make quite a big difference because it is less of a problem
if one sibling goes idle than if one CPU (in the 8-way) goes idle).

But if you could do a round with SCHED_SMT enabled it would be very
nice of you ;)

