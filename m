Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWJKLST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWJKLST (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 07:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWJKLST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 07:18:19 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:40875 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964816AbWJKLSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 07:18:18 -0400
Date: Wed, 11 Oct 2006 13:16:56 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Al Viro <viro@ftp.linux.org.uk>
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use %p for pointers
In-Reply-To: <E1GXPU5-0007Ss-HU@ZenIV.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0610111316120.26779@yvahk01.tjqt.qr>
References: <E1GXPU5-0007Ss-HU@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>diff --git a/drivers/sbus/char/uctrl.c b/drivers/sbus/char/uctrl.c
>index ddc0681..b30372f 100644
>--- a/drivers/sbus/char/uctrl.c
>+++ b/drivers/sbus/char/uctrl.c
>@@ -400,7 +400,7 @@ static int __init ts102_uctrl_init(void)
> 	}
> 
> 	driver->regs->uctrl_intr = UCTRL_INTR_RXNE_REQ|UCTRL_INTR_RXNE_MSK;
>-	printk("uctrl: 0x%x (irq %d)\n", driver->regs, driver->irq);
>+	printk("uctrl: 0x%p (irq %d)\n", driver->regs, driver->irq);

So what's the difference, except that %p will evaluate to (nil) or 
(null) when the argument is 0 [this is the case with glibc]?
That would print 0x(nil).


	-`J'
-- 
