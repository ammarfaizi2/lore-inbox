Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWJFLP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWJFLP0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 07:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWJFLPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 07:15:25 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:62104 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750705AbWJFLPY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 07:15:24 -0400
Message-ID: <45263ABC.4050604@garzik.org>
Date: Fri, 06 Oct 2006 07:15:08 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than	passing
 to IRQ handlers
References: <20061002132116.2663d7a3.akpm@osdl.org>	 <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>	 <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>	 <18975.1160058127@warthog.cambridge.redhat.com>	 <4525A8D8.9050504@garzik.org> <1160133932.1607.68.camel@localhost.localdomain>
In-Reply-To: <1160133932.1607.68.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Iau, 2006-10-05 am 20:52 -0400, ysgrifennodd Jeff Garzik:
>> The overwhelming majority of irq handlers don't use the 'irq' argument 
>> either...  the driver-supplied pointer is what drivers use, exclusively, 
>> to differentiate between different instances.
>>
>> If we are going to break all the irq handlers, I'd suggest going ahead 
>> and removing that one too.
> 
> NAK to that, it will mess up a lot of older drivers which still use the
> irq field and also those who want it to print

Look at the pt_regs change -- the irq change is similar:

The information does not go away, it is merely available via another avenue.

	Jeff



