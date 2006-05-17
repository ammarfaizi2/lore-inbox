Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbWEQIhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWEQIhN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 04:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWEQIhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 04:37:12 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:17837 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932491AbWEQIhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 04:37:10 -0400
Date: Wed, 17 May 2006 10:36:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: [patch 39/50] genirq: ARM: Convert omap1 to generic irq handling
Message-ID: <20060517083659.GA26576@elte.hu>
References: <20060517001814.GN12877@elte.hu> <1147834516.17117.10.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147834516.17117.10.camel@c-67-180-134-207.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> The set_wake member in irq_chip structure must have changed ..
> 
> In -v3 it's
> 
> int             (*set_wake)(unsigned int irq, int on);
> 
> and in arch/arm/mach-omap1/irq.c that member gets set to
> 
> static int omap_wake_irq(unsigned int irq, unsigned int enable)
> 
> this is from 2.6.17-rc4 so it's likely in some level of flux either in 
> the generic irq patch or the omap tree ..

indeed - it's flux from -v4 cleanups. I have changed it back to 
'unsigned int on'.

	Ingo
