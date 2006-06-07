Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWFGMDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWFGMDL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 08:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWFGMDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 08:03:11 -0400
Received: from www.osadl.org ([213.239.205.134]:1745 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932222AbWFGMDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 08:03:10 -0400
Subject: Re: genirq: fasteoi change for retrigger
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060607083304.GA31202@elte.hu>
References: <1149660616.27572.138.camel@localhost.localdomain>
	 <20060607083304.GA31202@elte.hu>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 10:40:06 +0200
Message-Id: <1149669606.11983.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-07 at 10:33 +0200, Ingo Molnar wrote:
> * Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Hi Ingo, Thomas.
> > 
> > Would you be ok with a small change to the fasteoi handler that
> > 
> >  - If the interrupt happens while disabled, rather than just doing goto
> > out, also mark it pending
> >  - In the normal handling code path, clear pending.
> > 
> > That would allow some sort of soft-disable to work with fasteoi.
> > 
> > My issue here is on Cell. I have a very strange interrupt controller 
> > that can't mask interrupts.
> 
> sure, it looks reasonable to me. Thomas?

No objections.

	tglx


