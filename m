Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751508AbWFDPzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWFDPzq (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 11:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbWFDPzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 11:55:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37023 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751508AbWFDPzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 11:55:45 -0400
Subject: Re: [patch, -rc5-mm1] locking validator: special rule: 8390.c
	disable_irq()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Alan Cox <alan@redhat.com>,
        Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1149426961.27696.7.camel@localhost.localdomain>
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
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 04 Jun 2006 17:10:12 +0100
Message-Id: <1149437412.23209.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-06-04 am 09:16 -0400, ysgrifennodd Steven Rostedt:
> But I'm not sure if I fully understand this misrouting irq.  Is it to
> fix broken machines that trigger interrupts on the wrong line?  Or is

It is solely to deal with machines where IRQs turn up on the wrong line,
generally meaning broken ACPI IRQ tables. It has to be enabled as a boot
option.

Alan

