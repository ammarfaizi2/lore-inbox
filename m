Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWJFLC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWJFLC6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 07:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWJFLC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 07:02:58 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:3279 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751481AbWJFLC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 07:02:57 -0400
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than
	passing to IRQ handlers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <4525A8D8.9050504@garzik.org>
References: <20061002132116.2663d7a3.akpm@osdl.org>
	 <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
	 <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
	 <18975.1160058127@warthog.cambridge.redhat.com>
	 <4525A8D8.9050504@garzik.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Oct 2006 12:25:32 +0100
Message-Id: <1160133932.1607.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-05 am 20:52 -0400, ysgrifennodd Jeff Garzik:
> The overwhelming majority of irq handlers don't use the 'irq' argument 
> either...  the driver-supplied pointer is what drivers use, exclusively, 
> to differentiate between different instances.
> 
> If we are going to break all the irq handlers, I'd suggest going ahead 
> and removing that one too.

NAK to that, it will mess up a lot of older drivers which still use the
irq field and also those who want it to print

