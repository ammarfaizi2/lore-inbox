Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbVAYXyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbVAYXyK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 18:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVAYXwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 18:52:13 -0500
Received: from gate.crashing.org ([63.228.1.57]:44489 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262243AbVAYXt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 18:49:58 -0500
Subject: Re: Problem with cpu_rest() change
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050125090131.GA4986@elte.hu>
References: <1106534442.5272.10.camel@gaston>
	 <20050125090131.GA4986@elte.hu>
Content-Type: text/plain
Date: Wed, 26 Jan 2005 10:49:12 +1100
Message-Id: <1106696952.6244.22.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 10:01 +0100, Ingo Molnar wrote:

> it can be bad for the idle task to hold the BKL and to have preemption
> enabled - in such a situation the scheduler will get confused if an
> interrupt triggers a forced preemption in that small window. But it's
> not necessary to keep IRQs disabled after the BKL has been dropped. In
> fact i think IRQ-disabling doesnt have to be done at all, the patch
> below ought to solve this scenario equally well, and should solve the
> PPC side-effects too.
> 
> Tested ontop of 2.6.11-rc2 on x86 PREEMPT+SMP and PREEMPT+!SMP (which
> IIRC were the config variants that triggered the original problem), on
> an SMP and on a UP system.

Excellent, thanks.

Ben.


