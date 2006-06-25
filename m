Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWFYPkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWFYPkK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 11:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWFYPkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 11:40:10 -0400
Received: from www.osadl.org ([213.239.205.134]:64166 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751320AbWFYPkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 11:40:09 -0400
Subject: Re: Problem with 2.6.17-mm2
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060625105512.GZ27143@charite.de>
References: <20060625103523.GY27143@charite.de>
	 <20060625034913.315755ae.akpm@osdl.org> <20060625105512.GZ27143@charite.de>
Content-Type: text/plain
Date: Sun, 25 Jun 2006 17:41:55 +0200
Message-Id: <1151250115.25491.384.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf,

On Sun, 2006-06-25 at 12:55 +0200, Ralf Hildebrandt wrote: 
> > > 1) A lot of "unexpected IRQ trap at vector X" for X=[09,07]
> > 
> > hm, ack_bad_irq().  That isn't supposed to happen.
> 
> Yet the box seems to work ok.

Can you please provide the boot log from 2.6.17 and one with the
following patch on top of 2.6.17-mm2 applied:
http://www.tglx.de/private/tglx/linux-2.6.17-mm2-revert-genirq.diff

It reverts the genirq changes. When the unexpected IRQ trap messages
persist, we know that it's unrelated to genirq. Otherwise, sigh

Thanks,

	tglx

P.S.: Greetings from Bene Spranger


