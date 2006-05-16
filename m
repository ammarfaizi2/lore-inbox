Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWEPWdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWEPWdd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 18:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWEPWdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 18:33:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18896 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932200AbWEPWdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 18:33:33 -0400
Date: Tue, 16 May 2006 15:29:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Buesch <mb@bu3sch.de>
Cc: dsaxena@plexity.net, bcm43xx-dev@lists.berlios.de,
       linux-kernel@vger.kernel.org, vsu@altlinux.ru, mb@bu3sch.de
Subject: Re: [patch 6/9] Add VIA HW RNG driver
Message-Id: <20060516152943.587b462d.akpm@osdl.org>
In-Reply-To: <20060515145317.142226000@bu3sch.de>
References: <20060515145243.905923000@bu3sch.de>
	<20060515145317.142226000@bu3sch.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch <mb@bu3sch.de> wrote:
>
> Signed-off-by: Michael Buesch <mb@bu3sch.de>
> Index: hwrng/drivers/char/hw_random/Kconfig
> ===================================================================
> --- hwrng.orig/drivers/char/hw_random/Kconfig	2006-05-08 00:12:08.000000000 +0200
> +++ hwrng/drivers/char/hw_random/Kconfig	2006-05-08 00:12:20.000000000 +0200
> @@ -48,3 +48,16 @@
>  	  module will be called geode-rng.
>  
>  	  If unsure, say Y.
> +
> +config HW_RANDOM_VIA
> +	tristate "VIA HW Random Number Generator support"
> +	depends on HW_RANDOM && X86

Perhaps you want X86_32 here.

> +	if (!cpu_has_xstore)

Because this doesn't exist on x86_64.
