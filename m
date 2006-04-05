Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWDEROZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWDEROZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 13:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWDEROZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 13:14:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35734 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751294AbWDEROY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 13:14:24 -0400
Date: Wed, 5 Apr 2006 10:11:11 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [2.6 patch] drivers/char/random.c: unexport
 secure_ipv6_port_ephemeral
Message-ID: <20060405101111.0edc161a@localhost.localdomain>
In-Reply-To: <20060405163610.GG8673@stusta.de>
References: <20060405163610.GG8673@stusta.de>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2006 18:36:10 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> This patch removes the unused EXPORT_SYMBOL(secure_ipv6_port_ephemeral).
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.17-rc1-mm1-full/drivers/char/random.c.old	2006-04-05 17:00:04.000000000 +0200
> +++ linux-2.6.17-rc1-mm1-full/drivers/char/random.c	2006-04-05 17:00:22.000000000 +0200
> @@ -1584,7 +1584,6 @@
>  
>  	return twothirdsMD4Transform(daddr, hash);
>  }
> -EXPORT_SYMBOL(secure_ipv6_port_ephemeral);
>  #endif
>  
>  #if defined(CONFIG_IP_DCCP) || defined(CONFIG_IP_DCCP_MODULE)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

NAK

If IPV6 is built as a module, then it is needed.
