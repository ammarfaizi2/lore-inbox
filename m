Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVFNNCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVFNNCs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 09:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVFNNCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 09:02:47 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:32766 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261226AbVFNNCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 09:02:45 -0400
Date: Tue, 14 Jun 2005 22:02:27 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc6] add vr41xx gpio support
Message-Id: <20050614220227.755b0fe3.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20050613151940.24ac347d.akpm@osdl.org>
References: <20050612032827.31ac649a.yuasa@hh.iij4u.or.jp>
	<20050613151940.24ac347d.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Mon, 13 Jun 2005 15:19:40 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Yoichi Yuasa <yuasa@hh.iij4u.or.jp> wrote:
> >
> > This patch had added vr41xx gpio support.
> 
> 
> > --- git5-orig/drivers/char/Kconfig	Tue Jun  7 00:22:29 2005
> > +++ git5/drivers/char/Kconfig	Sun Jun 12 02:37:20 2005
> > @@ -929,6 +929,10 @@
> >  
> >  	  If compiled as a module, it will be called scx200_gpio.
> >  
> > +config GPIO_VR41XX
> > +	tristate "NEC VR4100 series General-purpose I/O Unit support"
> > +	depends CPU_VR41XX
> > +
> 
> Does that even work?  We normally use "depends on".  I'll change it.

Oh, thanks.

> > +EXPORT_SYMBOL_GPL(vr41xx_set_irq_trigger);
> > +EXPORT_SYMBOL_GPL(vr41xx_set_irq_level);
> > +EXPORT_SYMBOL_GPL(vr41xx_gpio_get_pin);
> > +EXPORT_SYMBOL_GPL(vr41xx_gpio_set_pin);
> > +EXPORT_SYMBOL_GPL(vr41xx_gpio_set_direction);
> > +EXPORT_SYMBOL_GPL(vr41xx_gpio_pullupdown);
> 
> Why are these symbols exported?

I'm going to send patches that use this symbol.

Yoichi
