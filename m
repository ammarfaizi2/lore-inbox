Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWIHWso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWIHWso (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWIHWso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:48:44 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:23084 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751120AbWIHWsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:48:43 -0400
Message-ID: <4501F348.7000208@mvista.com>
Date: Fri, 08 Sep 2006 15:48:40 -0700
From: Kevin Hilman <khilman@mvista.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt] use SA_NODELAY for XScale PMU interrupts
References: <4501C2FE.40109@mvista.com> <1157750869.30730.137.camel@laptopd505.fenrus.org>
In-Reply-To: <1157750869.30730.137.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Fri, 2006-09-08 at 12:22 -0700, Kevin Hilman wrote:
>> In the XScale oprofile support, the performance monitoring unit (PMU)
>> triggers interrupts and the ISR reads out the performance data.  These
>> ISRs are currently set to SA_INTERRUPT.  In order to get accurate
>> performance and profiling data under PREEMPT_RT, these should use
>> SA_NODELAY.  The functions called by this ISR are limited to
>> drivers/oprofile functions.
>>
>> Patch against 2.6.18-rt8
> 
> hmm I thought the SA_ flags were deprecated ???
> 

Sorry, although I said 2.6.18-rt8, the patch is against 2.6.17-rt8,
where the SA_ flags are still used.

Kevin


