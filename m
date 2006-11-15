Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030789AbWKOSC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030789AbWKOSC2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030787AbWKOSC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:02:27 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:42904 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030790AbWKOSC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:02:26 -0500
Date: Wed, 15 Nov 2006 19:01:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org,
       Arjan van de Ven <arjan@infradead.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386-pda UP optimization
Message-ID: <20061115180105.GA29795@elte.hu>
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <200611151846.31109.dada1@cosmosbay.com> <20061115174957.GA27827@elte.hu> <200611151858.09958.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611151858.09958.dada1@cosmosbay.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric Dumazet <dada1@cosmosbay.com> wrote:

> > > +	GET_CPU_NUM(%ebx) \
> > >  	PER_CPU(cpu_gdt_descr, %ebx); \
> > >  	movl GDS_address(%ebx), %ebx; \
> >
> > %ebx very definitely wants to have a current CPU number loaded ;) Pick
> > it up from the task struct.
> 
> Hum.... Are you sure ?
> 
> For UP we have this PER_CPU definition :
> 
> #define PER_CPU(var, cpu) \
>         movl $per_cpu__/**/var, cpu;

hm, you are right. No quick ideas then.

	Ingo
