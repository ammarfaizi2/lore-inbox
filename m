Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262452AbVE0MtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbVE0MtB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 08:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVE0MtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 08:49:01 -0400
Received: from mx2.elte.hu ([157.181.151.9]:44966 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262452AbVE0Ms6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 08:48:58 -0400
Date: Fri, 27 May 2005 14:48:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@muc.de>
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       bhuey@lnxw.com, nickpiggin@yahoo.com.au, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050527124837.GA7253@elte.hu>
References: <1116982977.19926.63.camel@dhcp153.mvista.com> <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <20050526200424.GA27162@elte.hu> <20050527123529.GD86087@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527123529.GD86087@muc.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@muc.de> wrote:

> [...] Even normal kernels must have reasonably good latency, as long 
> as it doesnt cost unnecessary performance.

they do get reasonably good latency (within the hard constraints of the 
possibilities of a given preemption model), due to the cross-effects 
between the various preemption models, that i explained in detail in 
earlier mails. Something that directly improves latencies on 
CONFIG_PREEMPT improves the 'subsystem-use latencies' on PREEMPT_RT.  
Also there's the positive interaction between scalability and latencies 
as well.

but it's certainly not for free. Just like there's no zero-cost
virtualization, or there's no zero-cost nanokernel approach either,
there's no zero-cost single-kernel-image deterministic system either.

and the argument about binary kernels - that's a choice up to vendors
and users. Right now PREEMPT_NONE is dominant, so do you argue that
CONFIG_PREEMPT should be removed? It's certainly not zero-cost even on
the source code, witness all the preempt_disable()/preempt_enable() or
get_cpu()/put_cpu() uses.

	Ingo
