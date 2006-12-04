Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934996AbWLDJtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934996AbWLDJtJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 04:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935292AbWLDJtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 04:49:09 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:38577 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S935244AbWLDJtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 04:49:07 -0500
Date: Mon, 4 Dec 2006 10:48:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386/kernel/smp.c: don't use set_irq_regs()
Message-ID: <20061204094835.GD7872@elte.hu>
References: <20061203181642.GA226@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061203181642.GA226@oleg>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0004]
	1.4 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@tv-sign.ru> wrote:

> We don't need to setup _irq_regs in smp_xxx_interrupt (except apic 
> timer). These handlers run with irqs disabled and do not call 
> functions which need "struct pt_regs".
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

yeah. These are leftover inefficiencies from the ptregs conversion, 
which just added a regs variable to every arch-level irq handler 
blindly.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
