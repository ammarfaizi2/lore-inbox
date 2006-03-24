Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422985AbWCXChY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422985AbWCXChY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 21:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422984AbWCXChY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 21:37:24 -0500
Received: from bay109-dav12.bay109.hotmail.com ([64.4.19.84]:1004 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1422979AbWCXChX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 21:37:23 -0500
Message-ID: <BAY109-DAV122F44146DB217251703AEB3DF0@phx.gbl>
X-Originating-IP: [72.60.172.10]
X-Originating-Email: [zhaojingmin@hotmail.com]
From: "Jing Min Zhao" <zhaojingmin@hotmail.com>
To: "Adrian Bunk" <bunk@stusta.de>, "Jing Min Zhao" <zhaojignmin@hotmail.com>
Cc: <netdev@vger.kernel.org>, <netfilter-devel@lists.netfilter.org>,
       <linux-kernel@vger.kernel.org>
References: <20060324000916.GN22727@stusta.de>
Subject: Re: 2.6 patch] ip_conntrack_helper_h323.c: make get_h245_addr()static
Date: Thu, 23 Mar 2006 21:37:15 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-OriginalArrivalTime: 24 Mar 2006 02:37:20.0913 (UTC) FILETIME=[E001C010:01C64EEB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Adrian Bunk" <bunk@stusta.de>
To: "Jing Min Zhao" <zhaojignmin@hotmail.com>
Cc: <netdev@vger.kernel.org>; <netfilter-devel@lists.netfilter.org>; 
<linux-kernel@vger.kernel.org>
Sent: Thursday, March 23, 2006 7:09 PM
Subject: [RFC: 2.6 patch] ip_conntrack_helper_h323.c: make 
get_h245_addr()static

I'd like to keep it global. In the future we may need it.

Thanks

Jing Min Zhao

> This patch makes a needlessly global function static.
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> ---
>
> net/ipv4/netfilter/ip_conntrack_helper_h323.c |    5 ++---
> net/ipv4/netfilter/ip_nat_helper_h323.c       |    2 --
> 2 files changed, 2 insertions(+), 5 deletions(-)
>
> --- linux-2.6.16-mm1-full/net/ipv4/netfilter/ip_nat_helper_h323.c.old 
> 2006-03-23 23:13:59.000000000 +0100
> +++ linux-2.6.16-mm1-full/net/ipv4/netfilter/ip_nat_helper_h323.c 
> 2006-03-23 23:14:05.000000000 +0100
> @@ -49,8 +49,6 @@
> #define DEBUGP(format, args...)
> #endif
>
> -extern int get_h245_addr(unsigned char *data, H245_TransportAddress * 
> addr,
> - u_int32_t * ip, u_int16_t * port);
> extern int get_h225_addr(unsigned char *data, TransportAddress * addr,
>  u_int32_t * ip, u_int16_t * port);
> extern void ip_conntrack_h245_expect(struct ip_conntrack *new,
> ---  
> linux-2.6.16-mm1-full/net/ipv4/netfilter/ip_conntrack_helper_h323.c.old 
> 2006-03-23 23:14:21.000000000 +0100
> +++ linux-2.6.16-mm1-full/net/ipv4/netfilter/ip_conntrack_helper_h323.c 
> 2006-03-23 23:14:35.000000000 +0100
> @@ -222,8 +222,8 @@
> }
>
> /****************************************************************************/
> -int get_h245_addr(unsigned char *data, H245_TransportAddress * addr,
> -   u_int32_t * ip, u_int16_t * port)
> +static int get_h245_addr(unsigned char *data, H245_TransportAddress * 
> addr,
> + u_int32_t * ip, u_int16_t * port)
> {
>  unsigned char *p;
>
> @@ -1713,7 +1713,6 @@
> module_init(init);
> module_exit(fini);
>
> -EXPORT_SYMBOL(get_h245_addr);
> EXPORT_SYMBOL(get_h225_addr);
> EXPORT_SYMBOL(ip_conntrack_h245_expect);
> EXPORT_SYMBOL(ip_conntrack_q931_expect);
>
>
> 
