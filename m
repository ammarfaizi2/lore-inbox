Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUBOLMk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 06:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbUBOLMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 06:12:40 -0500
Received: from gate.crashing.org ([63.228.1.57]:1950 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261606AbUBOLMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 06:12:39 -0500
Subject: Re: Linux 2.6.3-rc3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Osterlund <petero2@telia.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m2k72o4nvk.fsf@p4.localdomain>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org>
	 <m2znbk4s8j.fsf@p4.localdomain> <1076838882.6957.48.camel@gaston>
	 <1076840755.6949.50.camel@gaston>  <m2k72o4nvk.fsf@p4.localdomain>
Content-Type: text/plain
Message-Id: <1076843487.6957.56.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 15 Feb 2004 22:11:28 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes, you can still build the old driver, but it doesn't work unless
> you also apply this patch:

Ah, I forgot the old fbdev init shit. Indeed, Linus, please apply
this patch.

> --- linux/drivers/video/fbmem.c.old	2004-02-15 11:47:26.000000000 +0100
> +++ linux/drivers/video/fbmem.c	2004-02-15 11:43:42.000000000 +0100
> @@ -222,6 +222,9 @@
>  #ifdef CONFIG_FB_RADEON
>  	{ "radeonfb", radeonfb_init, radeonfb_setup },
>  #endif
> +#ifdef CONFIG_FB_RADEON_OLD
> +	{ "radeonfb_old", radeonfb_init, radeonfb_setup },
> +#endif
>  #ifdef CONFIG_FB_CONTROL
>  	{ "controlfb", control_init, control_setup },
>  #endif
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

