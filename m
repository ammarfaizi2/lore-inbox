Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbSJ2X7b>; Tue, 29 Oct 2002 18:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262107AbSJ2X7b>; Tue, 29 Oct 2002 18:59:31 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:62696 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261908AbSJ2X7a>;
	Tue, 29 Oct 2002 18:59:30 -0500
Message-ID: <3DBF213E.5090902@us.ibm.com>
Date: Tue, 29 Oct 2002 16:01:02 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Erich Focht <efocht@ess.nec.de>, davidm@hpl.hp.com,
       linux-ia64 <linux-ia64@linuxia64.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-ia64] Re: [PATCH] topology for ia64
References: <200210051904.22480.efocht@ess.nec.de> <15796.38594.516266.130894@napali.hpl.hp.com> <200210221123.37145.efocht@ess.nec.de> <3DBF096D.6080703@us.ibm.com> <20021029224725.GH23425@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Tue, Oct 29, 2002 at 02:19:25PM -0800, Matthew Dobson wrote:
> +/*
> + * Returns the number of the first CPU on Node 'node'.
> + * Slow in the current implementation.
> + * Who needs this?
> + */
> +/* #define __node_to_first_cpu(node) pool_cpus[pool_ptr[node]] */
> +static inline int __node_to_first_cpu(int node)
> 
> So far so safe... though no obvious use of it.

Yep...


> On Tue, Oct 29, 2002 at 02:19:25PM -0800, Matthew Dobson wrote:
> 
>>No one is using it now.  I think that I will probably deprecate this 
>>function in the near future as it is pretty useless.  Anyone looking for 
>>that functionality can just do an __ffs(__node_to_cpu_mask(node)) 
>>instead, and hope that there is a reasonably quick implementation of 
>>__node_to_cpu_mask.
> 
> 
> This assumes the value returned by __node_to_cpu_mask() is a single word.

Which is the case right now.  When (not if) that changes, we'll come up 
with more flexible ffs macros, or a better way to count variable length 
bitmasks...  especially as there will be a TON of them.

Cheers!

-Matt

