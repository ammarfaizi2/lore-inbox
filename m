Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262642AbVCDIPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbVCDIPb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 03:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbVCDIPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 03:15:31 -0500
Received: from ip22-176.tor.istop.com ([66.11.176.22]:10646 "EHLO
	lapdance.christiehouse.net") by vger.kernel.org with ESMTP
	id S262619AbVCDIOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 03:14:19 -0500
Message-ID: <422817C3.2010307@waychison.com>
Date: Fri, 04 Mar 2005 03:09:39 -0500
From: Mike Waychison <mike@waychison.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] unexport complete_all
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I didn't find any possible modular usage in the kernel.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.11-rc5-mm1-full/kernel/sched.c.old	2005-03-04 01:04:28.000000000 +0100
> +++ linux-2.6.11-rc5-mm1-full/kernel/sched.c	2005-03-04 01:04:34.000000000 +0100
> @@ -3053,7 +3053,6 @@
>  			 0, 0, NULL);
>  	spin_unlock_irqrestore(&x->wait.lock, flags);
>  }
> -EXPORT_SYMBOL(complete_all);
>  
>  void fastcall __sched wait_for_completion(struct completion *x)
>  {
> -

This is a valid piece of API that is exported for future use.

Please stop blindly posting patches for unexports that make the APIs
half available.

--
Mike Waychison
