Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbVJPWoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVJPWoR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 18:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbVJPWoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 18:44:17 -0400
Received: from smtpa3.netcabo.pt ([212.113.174.18]:20435 "EHLO
	exch01smtp02.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S932075AbVJPWoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 18:44:16 -0400
Message-ID: <4352D79D.9070901@rncbc.org>
Date: Sun, 16 Oct 2005 23:43:41 +0100
From: Rui Nuno Capela <rncbc@rncbc.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: tsc_c3_compensate undefined since patch-2.6.13-rt13
References: <20050901072430.GA6213@elte.hu> <1125571335.15768.21.camel@localhost.localdomain> <20051003065032.GA23777@elte.hu> <43424B7C.9020508@rncbc.org> <20051004101434.GA26882@elte.hu>
In-Reply-To: <20051004101434.GA26882@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2005 22:44:09.0784 (UTC) FILETIME=[1F606380:01C5D2A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Rui Nuno Capela <rncbc@rncbc.org> wrote:
> 
> 
>>Ingo,
>>
>>I'll take this late opportunity to report something that have been 
>>looking suspicious since 2.6.13-rt13, inclusive, about this symbol of 
>>tsc_c3_compensate being undefined and causing some noise on all kernel 
>>builds since then.
>>
>>To put things in brief, here follows a small exchange that took place 
>>on the linux-audio-user list, regarding this thingie. Apparently for 
>>Mark, it was a kernel build showstopper.
> 
> 
> thanks for the reminder!
> 
> 
>>WARNING: 
>>/lib/modules/2.6.13.1-rt13.0mdk/kernel/drivers/char/hangcheck-timer.ko 
>>needs unknown symbol do_monotonic_clock
>>WARNING: 
>>/lib/modules/2.6.13.1-rt13.0mdk/kernel/drivers/acpi/processor.ko needs 
>>unknown symbol tsc_c3_compensate
> 
> 
> back then i fixed do_monotonic_clock, but forgot to export 
> tsc_c3_compensate. I have fixed this in my tree, and have uploaded the 
> 2.6.14-rc3-rt3 patch. Does it build without warnings for you now?
> 

As it seems, tsc_c3_compensate isn't being defined again, as of 
patch-2.6.14-rc4-rt6 (-rt4 was ok).

Cheers.
--
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
