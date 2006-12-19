Return-Path: <linux-kernel-owner+w=401wt.eu-S933049AbWLSW3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933049AbWLSW3s (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 17:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932985AbWLSW3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 17:29:47 -0500
Received: from smtp20.orange.fr ([80.12.242.27]:39610 "EHLO smtp20.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932980AbWLSW3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 17:29:46 -0500
X-ME-UUID: 20061219222944380.5CEA21C0008C@mwinf2007.orange.fr
Date: Wed, 20 Dec 2006 00:29:43 +0200
From: Samuel Ortiz <samuel@sortiz.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [2.6 patch] net/irda/: proper prototypes
Message-ID: <20061219222942.GA4274@sortiz.org>
Reply-To: Samuel Ortiz <samuel@sortiz.org>
References: <20061218034626.GY10316@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061218034626.GY10316@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Mon, Dec 18, 2006 at 04:46:26AM +0100, Adrian Bunk wrote:
> This patch adds proper prototypes for some functions in
> include/net/irda/irda.h
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
looks good to me, thanks.

Signed-off-by: Samuel Ortiz <samuel@sortiz.org>

Cheers,
Samuel.

> 
> ---
> 
>  include/net/irda/irda.h |   15 +++++++++++++++
>  net/irda/irmod.c        |   13 -------------
>  2 files changed, 15 insertions(+), 13 deletions(-)
> 
> --- linux-2.6.20-rc1-mm1/include/net/irda/irda.h.old	2006-12-18 02:49:02.000000000 +0100
> +++ linux-2.6.20-rc1-mm1/include/net/irda/irda.h	2006-12-18 02:58:02.000000000 +0100
> @@ -113,4 +113,19 @@
>  #define IAS_IRCOMM_ID 0x2343
>  #define IAS_IRLPT_ID  0x9876
>  
> +struct net_device;
> +struct packet_type;
> +
> +void irda_proc_register(void);
> +void irda_proc_unregister(void);
> +
> +int irda_sysctl_register(void);
> +void irda_sysctl_unregister(void);
> +
> +int irsock_init(void);
> +void irsock_cleanup(void);
> +
> +int irlap_driver_rcv(struct sk_buff *skb, struct net_device *dev,
> +		     struct packet_type *ptype, struct net_device *orig_dev);
> +
>  #endif /* NET_IRDA_H */
> --- linux-2.6.20-rc1-mm1/net/irda/irmod.c.old	2006-12-18 02:52:18.000000000 +0100
> +++ linux-2.6.20-rc1-mm1/net/irda/irmod.c	2006-12-18 02:53:59.000000000 +0100
> @@ -42,19 +42,6 @@
>  #include <net/irda/irttp.h>		/* irttp_init */
>  #include <net/irda/irda_device.h>	/* irda_device_init */
>  
> -/* irproc.c */
> -extern void irda_proc_register(void);
> -extern void irda_proc_unregister(void);
> -/* irsysctl.c */
> -extern int  irda_sysctl_register(void);
> -extern void irda_sysctl_unregister(void);
> -/* af_irda.c */
> -extern int  irsock_init(void);
> -extern void irsock_cleanup(void);
> -/* irlap_frame.c */
> -extern int  irlap_driver_rcv(struct sk_buff *, struct net_device *, 
> -			     struct packet_type *, struct net_device *);
> -
>  /*
>   * Module parameters
>   */
> 
