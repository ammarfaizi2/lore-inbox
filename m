Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWIKEJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWIKEJd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 00:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWIKEJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 00:09:33 -0400
Received: from gate.crashing.org ([63.228.1.57]:34468 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750849AbWIKEJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 00:09:32 -0400
Subject: Re: [PATCH] FRV: do_gettimeofday() should no longer use tickadj
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Howells <dhowells@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <21606.1157718592@warthog.cambridge.redhat.com>
References: <1157669602.22705.326.camel@localhost.localdomain>
	 <1157583693.22705.254.camel@localhost.localdomain>
	 <20060906125626.GA3718@elte.hu> <20060906094301.GA8694@elte.hu>
	 <1157507203.2222.11.camel@localhost> <20060905132530.GD9173@stusta.de>
	 <20060901015818.42767813.akpm@osdl.org>
	 <6260.1157470557@warthog.cambridge.redhat.com>
	 <8430.1157534853@warthog.cambridge.redhat.com>
	 <13982.1157545856@warthog.cambridge.redhat.com>
	 <17274.1157553962@warthog.cambridge.redhat.com>
	 <8934.1157622928@warthog.cambridge.redhat.com>
	 <21606.1157718592@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 14:06:28 +1000
Message-Id: <1157947588.31071.390.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But funky cascading using chained flow handlers doesn't work if the cascade
> must share an IRQ with some other device, right?

Indeed. Best way there is then to have a normal action handler like you
do and have it call generic_handle_irq() on the cascaded interrupts.

Ben.


