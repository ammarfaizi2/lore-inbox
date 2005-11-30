Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVK3V0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVK3V0n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 16:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVK3V0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 16:26:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62925 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750778AbVK3V0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 16:26:42 -0500
Date: Wed, 30 Nov 2005 13:27:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Franck <vagabon.xyz@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] Add MIPS dependency for dm9000 driver
Message-Id: <20051130132757.36e1cca0.akpm@osdl.org>
In-Reply-To: <cda58cb80511300918i7df1c60au@mail.gmail.com>
References: <cda58cb80511300918i7df1c60au@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Franck <vagabon.xyz@gmail.com> wrote:
>
> The attached patch adds MIPS dependency for dm9000 ethernet
> controller. Indeed this controller is used by some embedded platforms
> based on MIPS CPUs.
> 
> Signed-Off-By: Franck Bui-Huu <franck.bui@gmail.com>
> ---
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index f15f909..1b00169 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -856,7 +856,7 @@ config SMC9194
> 
>  config DM9000
>  	tristate "DM9000 support"
> -	depends on ARM && NET_ETHERNET
> +	depends on (ARM || MIPS) && NET_ETHERNET
>  	select CRC32
>  	select MII

Is there any reason why we cannot enable this driver on all architectures?

It's moderately important for quality and maintainability reasons that it
be included in the x86 build, at least..
