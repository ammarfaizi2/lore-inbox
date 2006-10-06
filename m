Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWJFPUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWJFPUh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 11:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWJFPUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 11:20:37 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:52895 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751489AbWJFPUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 11:20:35 -0400
Message-ID: <45267440.1000806@garzik.org>
Date: Fri, 06 Oct 2006 11:20:32 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       torvalds@osdl.org, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH, RAW] IRQ: Maintain irq number globally rather than passing
 to IRQ handlers
References: <20061002132116.2663d7a3.akpm@osdl.org> <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> <18975.1160058127@warthog.cambridge.redhat.com> <4525A8D8.9050504@garzik.org> <1160133932.1607.68.camel@localhost.localdomain> <45263ABC.4050604@garzik.org> <20061006111156.GA19678@elte.hu> <45263D9C.9030200@garzik.org> <452673AC.1080602@garzik.org>
In-Reply-To: <452673AC.1080602@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Here is the raw, un-split-up first pass of the irq argument removal 
> patch (500K):    http://gtf.org/garzik/misc/patch.irq-remove

A couple more notes:

* Builds on x86 and x86-64, including !CONFIG_SMP (which turns on 
several drivers most never see)

* Is missing the EXPORT_SYMBOL(), just like dhowell's pt_regs stuff is now

