Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVATEGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVATEGl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 23:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVATEGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 23:06:41 -0500
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:27299 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262033AbVATEGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 23:06:38 -0500
Message-ID: <41EF2E7E.8070604@kolivas.org>
Date: Thu, 20 Jan 2005 15:07:26 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
Cc: linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
References: <41EEE1B1.9080909@kolivas.org> <41EF00ED.4070908@kolivas.org>	<873bwwga0w.fsf@sulphur.joq.us> <41EF123D.703@kolivas.org> <87ekgges2o.fsf@sulphur.joq.us>
In-Reply-To: <87ekgges2o.fsf@sulphur.joq.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack O'Quin wrote:
> Con Kolivas <kernel@kolivas.org> writes:

> 
> Does it degrade significantly with a compile running in the background?

Check results below.

>>Full results and pretty pictures available here:
>>http://ck.kolivas.org/patches/SCHED_ISO/iso2-benchmarks/

More pretty pictures with compile load on SCHED_ISO put up there now.

> Outstanding.  
> 
> How do you get rid of that checkerboard grey background in the graphs?

Funny; that's the script you sent me so... beats me?

> Looking at the graphs, your system has a substantial 4 to 6 msec delay
> on approximately 40 second intervals, regardless of which scheduling
> class or how many clients you run.  I'm guessing this is a recurring
> long code path in the kernel and not a scheduling artifact at all.

Probably. No matter what I do the hard drive seems to keep trying to 
spin down. Might be related.

in the background:
while true ; do make clean && make ; done

SCHED_ISO with 40 clients:
*********************************************
Timeout Count . . . . . . . . :(    0)
XRUN Count  . . . . . . . . . :     3
Delay Count (>spare time) . . :    20
Delay Count (>1000 usecs) . . :     0
Delay Maximum . . . . . . . . :  5841   usecs
Cycle Maximum . . . . . . . . :   891   usecs
Average DSP Load. . . . . . . :    34.1 %
Average CPU System Load . . . :    10.7 %
Average CPU User Load . . . . :    87.8 %
Average CPU Nice Load . . . . :     0.0 %
Average CPU I/O Wait Load . . :     0.7 %
Average CPU IRQ Load  . . . . :     0.8 %
Average CPU Soft-IRQ Load . . :     0.0 %
Average Interrupt Rate  . . . :  1711.4 /sec
Average Context-Switch Rate . : 20751.6 /sec
*********************************************

Cheers,
Con
