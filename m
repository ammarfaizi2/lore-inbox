Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965468AbWJ3JC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965468AbWJ3JC5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 04:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965470AbWJ3JC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 04:02:57 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:27347 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965468AbWJ3JCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 04:02:55 -0500
Date: Mon, 30 Oct 2006 10:02:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc3] i386/io_apic: fix compiler warning in create_irq
Message-ID: <20061030090231.GA27146@elte.hu>
References: <tkrat.b1c929dd899e625a@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tkrat.b1c929dd899e625a@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> Fix warning
> arch/i386/kernel/io_apic.c: In function `create_irq':
> arch/i386/kernel/io_apic.c:2420: warning: 'vector' might be used uninitialized in this function

> @@ -2421,6 +2421,7 @@ int create_irq(void)
>  	unsigned long flags;
>  
>  	irq = -ENOSPC;
> +	vector = 0;

NAK - the code is fine, and this is fixed in Jeff's gcc-warnings tree 
via annotation.

	Ingo
