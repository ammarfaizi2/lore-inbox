Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbTKIUjf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 15:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbTKIUjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 15:39:35 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:32385 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S262792AbTKIUje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 15:39:34 -0500
Date: Sun, 09 Nov 2003 12:39:16 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Con Kolivas <kernel@kolivas.org>, Nick Piggin <piggin@cyberone.com.au>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Fix find busiest queue 2.6.0-test9
Message-ID: <126890000.1068410355@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0311090921090.12198-100000@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.44.0311090921090.12198-100000@bigblue.dev.mdolabs.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> +/* 
>> + * macro to make the code more readable - this_rq->prev_cpu_load[i]
>> + * is our local cached value of i's prev cpu_load. However, putting
>> + * this_rq->prev_cpu_load into the code makes it read like it's the
>> + * prev_cpu_load of this_cpu, which makes it confusing to read
>> + */
>> +#define prev_cpu_load_cache(cpu) (this_rq->prev_cpu_load[cpu])
> 
> Ouch, the implicit "this_rq" is really evil ;) Eventually:

Yeah, I know, but ...
 
># define prev_cpu_load_cache(rq, cpu) (rq->prev_cpu_load[cpu])

I think the implicit version is clearer to read. Oh well, maybe a good
balance between readability and sheer evil ;-)

M.

