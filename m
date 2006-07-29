Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161124AbWG2EB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161124AbWG2EB0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 00:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161157AbWG2EB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 00:01:26 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:7633 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161124AbWG2EBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 00:01:25 -0400
Date: Sat, 29 Jul 2006 05:55:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] bootmem: use MAX_DMA_ADDRESS instead of LOW32LIMIT
Message-ID: <20060729035523.GA29875@elte.hu>
References: <20060728130852.GB9559@osiris.boeblingen.de.ibm.com> <20060728131306.GA32513@elte.hu> <1154098725.3211.5.camel@localhost> <20060728194104.GA11622@osiris.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060728194104.GA11622@osiris.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> Hm... how about this one then:
> 
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Introduce ARCH_LOW_ADDRESS_LIMIT which can be set per architecture to
> override the 4GB default limit used by the bootmem allocater within
> __alloc_bootmem_low() and __alloc_bootmem_low_node().
> E.g. s390 needs a 2GB limit instead of 4GB.
> 
> Cc: Ingo Molnar <mingo@elte.hu>

Acked-by: Ingo Molnar <mingo@elte.hu>

(although you might get some flak about using an ARCH* define. I'm not 
sure what the current upstream policy is - using an #ifndef default 
value is the most compact hence sanest thing to do, still it's sometimes 
being frowned upon in favor of sprinkling the default value into every 
architecture's processor.h. Putting the value into a Kconfig and 
combining it with #ifndef might be better.)

	Ingo
