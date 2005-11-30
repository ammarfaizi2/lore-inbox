Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbVK3QXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbVK3QXk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 11:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbVK3QXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 11:23:40 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57355 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751444AbVK3QXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 11:23:32 -0500
Date: Wed, 30 Nov 2005 16:23:27 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Franck <vagabon.xyz@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [NET] Remove ARM dependency for dm9000 driver
Message-ID: <20051130162327.GC1053@flint.arm.linux.org.uk>
Mail-Followup-To: Franck <vagabon.xyz@gmail.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <cda58cb80511300821y72f3354av@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80511300821y72f3354av@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2005 at 05:21:35PM +0100, Franck wrote:
> Hi,
> 
> What about this patch which removes ARM dependency for dm9000 ethernet
> controller driver ?
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index f15f909..4af63dd 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -856,7 +856,7 @@ config SMC9194
> 
>  config DM9000
>  	tristate "DM9000 support"
> -	depends on ARM && NET_ETHERNET
> +	depends on NET_ETHERNET
>  	select CRC32
>  	select MII
>  	---help---
> 
> My platform based on MIPS cpu used it...

Maybe that should be (ARM || MIPS) && NET_ETHERNET ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
