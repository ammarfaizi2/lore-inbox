Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWEQCzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWEQCzU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 22:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWEQCzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 22:55:20 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:44123 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751184AbWEQCzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 22:55:19 -0400
Subject: Re: [patch 39/50] genirq: ARM: Convert omap1 to generic irq
	handling
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
In-Reply-To: <20060517001814.GN12877@elte.hu>
References: <20060517001814.GN12877@elte.hu>
Content-Type: text/plain
Date: Tue, 16 May 2006 19:55:16 -0700
Message-Id: <1147834516.17117.10.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The set_wake member in irq_chip structure must have changed ..

In -v3 it's

int             (*set_wake)(unsigned int irq, int on);

and in arch/arm/mach-omap1/irq.c that member gets set to

static int omap_wake_irq(unsigned int irq, unsigned int enable)

this is from 2.6.17-rc4 so it's likely in some level of flux either in
the generic irq patch or the omap tree ..

Daniel 

