Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268505AbTBOCLr>; Fri, 14 Feb 2003 21:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268507AbTBOCLr>; Fri, 14 Feb 2003 21:11:47 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:30224
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268505AbTBOCLq>; Fri, 14 Feb 2003 21:11:46 -0500
Date: Fri, 14 Feb 2003 21:18:09 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
cc: linux-kernel@vger.kernel.org, "" <schwidefsky@de.ibm.com>
Subject: Re: [PATCH][2.5][8/14] smp_call_function_on_cpu - s390
In-Reply-To: <200302142230.XAA13431@faui11.informatik.uni-erlangen.de>
Message-ID: <Pine.LNX.4.50.0302142111560.3518-100000@montezuma.mastecende.com>
References: <200302142230.XAA13431@faui11.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2003, Ulrich Weigand wrote:

> Zwane Mwaikambo wrote:
> 
> >+       cpu = get_cpu();
> >+       mask &= (1UL << cpu);
> >+       num_cpus = hweight32(mask);
> 
> I guess you mean 
>          mask &= ~(1UL << cpu);
> or else num_cpus is always either 0 or 1 ...

Hmm correct

> >+       for (i = 0; i < NR_CPUS; i++) {
> >+               if (cpu_online(i) && ((1UL << cpu) && mask))
> 
> This should be
>  		 if (cpu_online(i) && ((1UL << i) & mask))
> or else the message is sent to all online CPUs anyway ...

Correct again, thanks i'll fix that.

	Zwane
-- 
function.linuxpower.ca
