Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbWGFKoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbWGFKoR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 06:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965187AbWGFKoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 06:44:17 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:33496 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S965185AbWGFKoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 06:44:16 -0400
Date: Thu, 6 Jul 2006 12:43:15 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
Message-ID: <20060706124315.2188c700@cad-250-152.norway.atmel.com>
In-Reply-To: <1152179893.3084.26.camel@laptopd505.fenrus.org>
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
	<20060706021906.1af7ffa3.akpm@osdl.org>
	<1152179893.3084.26.camel@laptopd505.fenrus.org>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2006 11:58:13 +0200
Arjan van de Ven <arjan@infradead.org> wrote:

> 
> > 
> > - do you really need __udivdi3() and friends?  We struggle hard to
> > avoid the necessity on x86 and you should be able to leverage that
> > advantage.
> > 
> > - What are these for?
> > 
> > 	+EXPORT_SYMBOL(register_dma_controller);
> > 	+EXPORT_SYMBOL(find_dma_controller);
> > 
> > 	+EXPORT_SYMBOL(clk_get);
> > 	+EXPORT_SYMBOL(clk_put);
> > 	+EXPORT_SYMBOL(clk_enable);
> > 	+EXPORT_SYMBOL(clk_disable);
> > 	+EXPORT_SYMBOL(clk_get_rate);
> > 	+EXPORT_SYMBOL(clk_round_rate);
> > 	+EXPORT_SYMBOL(clk_set_rate);
> > 	+EXPORT_SYMBOL(clk_set_parent);
> > 	+EXPORT_SYMBOL(clk_get_parent);
> 
> probably wants to be _GPL exports anyway

If so, ARM should probably be converted as well. On SH, they are
actually _GPL exports.

I'll convert dma_controller stuff anyway.

Håvard
