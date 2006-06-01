Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWFAJrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWFAJrE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 05:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWFAJrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 05:47:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41100 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964810AbWFAJrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 05:47:03 -0400
Date: Thu, 1 Jun 2006 05:46:43 -0400
From: Alan Cox <alan@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@infradead.org>, Alan Cox <alan@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm1] locking validator: special rule: 8390.c disable_irq()
Message-ID: <20060601094643.GA22110@devserv.devel.redhat.com>
References: <20060531200236.GA31619@elte.hu> <1149107500.3114.75.camel@laptopd505.fenrus.org> <20060531214139.GA8196@devserv.devel.redhat.com> <1149111838.3114.87.camel@laptopd505.fenrus.org> <20060531214729.GA4059@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060531214729.GA4059@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 11:47:29PM +0200, Ingo Molnar wrote:
> couldnt most of these problems be avoided by tracking whether a handler 
> _ever_ returned a success status? That means that irqpoll could safely 
> poll handlers for which we know that they somehow arent yet matched up 
> to any IRQ line?

But you may get random positive hits from this when a real IRQ for an
unrelated device happens to get delivered. We could poll enabled IRQs first
then disabled ones ?

