Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750729AbWFDQWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWFDQWZ (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 12:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWFDQWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 12:22:25 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:5821 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750729AbWFDQWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 12:22:24 -0400
Subject: Re: [patch, -rc5-mm1] locking validator: special rule: 8390.c
	disable_irq()
From: Steven Rostedt <rostedt@goodmis.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjan@infradead.org>, Alan Cox <alan@redhat.com>,
        Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1149437412.23209.3.camel@localhost.localdomain>
References: <20060531200236.GA31619@elte.hu>
	 <1149107500.3114.75.camel@laptopd505.fenrus.org>
	 <20060531214139.GA8196@devserv.devel.redhat.com>
	 <1149111838.3114.87.camel@laptopd505.fenrus.org>
	 <20060531214729.GA4059@elte.hu>
	 <1149112582.3114.91.camel@laptopd505.fenrus.org>
	 <1149345421.13993.81.camel@localhost.localdomain>
	 <20060603215323.GA13077@devserv.devel.redhat.com>
	 <1149374090.14408.4.camel@localhost.localdomain>
	 <1149413649.3109.92.camel@laptopd505.fenrus.org>
	 <1149426961.27696.7.camel@localhost.localdomain>
	 <1149437412.23209.3.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 04 Jun 2006 12:22:11 -0400
Message-Id: <1149438131.29652.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-04 at 17:10 +0100, Alan Cox wrote:
> Ar Sul, 2006-06-04 am 09:16 -0400, ysgrifennodd Steven Rostedt:
> > But I'm not sure if I fully understand this misrouting irq.  Is it to
> > fix broken machines that trigger interrupts on the wrong line?  Or is
> 
> It is solely to deal with machines where IRQs turn up on the wrong line,
> generally meaning broken ACPI IRQ tables. It has to be enabled as a boot
> option.

Thanks for the answer Alan.

But can't this machine still cause an interrupt storm if the interrupt
comes on a wrong line, and we don't call the handler for the interrupt
source because we are now honoring disable_irq?

-- Steve


