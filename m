Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262410AbSJ2WdG>; Tue, 29 Oct 2002 17:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262418AbSJ2WdG>; Tue, 29 Oct 2002 17:33:06 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:1669 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262410AbSJ2WdG>;
	Tue, 29 Oct 2002 17:33:06 -0500
Subject: Re: [Linux-ia64] Re: [PATCH] topology for ia64
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Erich Focht <efocht@ess.nec.de>, davidm@hpl.hp.com,
       linux-ia64 <linux-ia64@linuxia64.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3DBF096D.6080703@us.ibm.com>
References: <200210051904.22480.efocht@ess.nec.de>
	<15796.38594.516266.130894@napali.hpl.hp.com>
	<200210221123.37145.efocht@ess.nec.de>  <3DBF096D.6080703@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 29 Oct 2002 14:35:28 -0800
Message-Id: <1035930929.1274.1766.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-29 at 14:19, Matthew Dobson wrote:
> Erich Focht wrote:
> +/*
> + * Returns the number of the first CPU on Node 'node'.
> + * Slow in the current implementation.
> + * Who needs this?
> + */
> +/* #define __node_to_first_cpu(node) pool_cpus[pool_ptr[node]] */
> +static inline int __node_to_first_cpu(int node)
> 
> No one is using it now.  I think that I will probably deprecate this 
> function in the near future as it is pretty useless.  Anyone looking for 
> that functionality can just do an __ffs(__node_to_cpu_mask(node)) 
> instead, and hope that there is a reasonably quick implementation of 
> __node_to_cpu_mask.
> 
I'm using this in the simple NUMA scheduler.  This is quite useful
for iterating through a specific node's CPUs.  Yes, the functionality
can be obtained in a different manner, but is less obvious.

-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

