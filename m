Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVFMWW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVFMWW4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 18:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVFMWVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:21:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34958 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261515AbVFMWTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 18:19:03 -0400
Date: Mon, 13 Jun 2005 15:19:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc6] add vr41xx gpio support
Message-Id: <20050613151940.24ac347d.akpm@osdl.org>
In-Reply-To: <20050612032827.31ac649a.yuasa@hh.iij4u.or.jp>
References: <20050612032827.31ac649a.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yoichi Yuasa <yuasa@hh.iij4u.or.jp> wrote:
>
> This patch had added vr41xx gpio support.


> --- git5-orig/drivers/char/Kconfig	Tue Jun  7 00:22:29 2005
> +++ git5/drivers/char/Kconfig	Sun Jun 12 02:37:20 2005
> @@ -929,6 +929,10 @@
>  
>  	  If compiled as a module, it will be called scx200_gpio.
>  
> +config GPIO_VR41XX
> +	tristate "NEC VR4100 series General-purpose I/O Unit support"
> +	depends CPU_VR41XX
> +

Does that even work?  We normally use "depends on".  I'll change it.

> +EXPORT_SYMBOL_GPL(vr41xx_set_irq_trigger);
> +EXPORT_SYMBOL_GPL(vr41xx_set_irq_level);
> +EXPORT_SYMBOL_GPL(vr41xx_gpio_get_pin);
> +EXPORT_SYMBOL_GPL(vr41xx_gpio_set_pin);
> +EXPORT_SYMBOL_GPL(vr41xx_gpio_set_direction);
> +EXPORT_SYMBOL_GPL(vr41xx_gpio_pullupdown);

Why are these symbols exported?
