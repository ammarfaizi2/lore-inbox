Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWFWN6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWFWN6W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWFWN57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:57:59 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:728 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750706AbWFWNmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:42:39 -0400
Date: Fri, 23 Jun 2006 15:37:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: [patch 8/8] lock validator: add s390 to supported options
Message-ID: <20060623133739.GA15113@elte.hu>
References: <20060614142503.GI1241@osiris.boeblingen.de.ibm.com> <20060619150547.0b6213b1.akpm@osdl.org> <20060623130506.GD9446@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623130506.GD9446@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> On Mon, Jun 19, 2006 at 03:05:47PM -0700, Andrew Morton wrote:
> > Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> > >
> > >  config DEBUG_SPINLOCK_ALLOC
> > >  	bool "Spinlock debugging: detect incorrect freeing of live spinlocks"
> > > -	depends on DEBUG_SPINLOCK && X86
> > > +	depends on DEBUG_SPINLOCK && (X86 || S390)
> > 
> > Can we please stomp this out before it starts to look like
> > CONFIG_FRAME_POINTER?
> > 
> > We should define CONFIG_ARCH_SUPPORTS_LOCKDEP down in
> > arch/[i386|x86_64|s390]/Kconfig and use that in lib/Kconfig.debug.
> 
> How about this:
> 
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Add LOCKDEP_SUPPORT config option per architecture.

fine with me. Perhaps we can thus replace IRQ_TRACE_SUPPORT with 
LOCKDEP_SUPPORT as well, and would codify LOCKDEP_SUPPORT to mean 
irqflags-trace support and stacktrace support?

	Ingo
