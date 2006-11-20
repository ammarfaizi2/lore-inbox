Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966203AbWKTQ5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966203AbWKTQ5c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 11:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966197AbWKTQ5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 11:57:32 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:28112 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S966203AbWKTQ5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 11:57:31 -0500
Date: Mon, 20 Nov 2006 17:56:21 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi type IRQ handlers
Message-ID: <20061120165621.GA1504@elte.hu>
References: <200611192243.34850.sshtylyov@ru.mvista.com> <1163966437.5826.99.camel@localhost.localdomain> <20061119200650.GA22949@elte.hu> <1163967590.5826.104.camel@localhost.localdomain> <20061119202348.GA27649@elte.hu> <1163985380.5826.139.camel@localhost.localdomain> <20061120100144.GA27812@elte.hu> <4561C9EC.3020506@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4561C9EC.3020506@ru.mvista.com>
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


* Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> >on PPC64, 'get the vector' initiates an ACK as well - is that done 
> >before handle_irq() is done?
> 
>    Exactly. How else do_IRQ() would know the vector?

the reason i'm asking is that in this case masking is a bit late at this 
point and there's a chance for a repeat interrupt.

	Ingo
