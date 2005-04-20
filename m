Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVDTMfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVDTMfT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 08:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVDTMfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 08:35:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:36757 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261571AbVDTMfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 08:35:13 -0400
Subject: Re: [RFC/PATCH] unregister_node() for hotplug use
From: Arjan van de Ven <arjan@infradead.org>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20050420210744.4013b3f8.tokunaga.keiich@jp.fujitsu.com>
References: <20050420210744.4013b3f8.tokunaga.keiich@jp.fujitsu.com>
Content-Type: text/plain
Date: Wed, 20 Apr 2005 14:35:10 +0200
Message-Id: <1114000510.6238.66.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> diff -puN drivers/base/node.c~numa_hp_base drivers/base/node.c
> --- linux-2.6.12-rc2-mm3/drivers/base/node.c~numa_hp_base	2005-04-14 20:49:37.000000000 +0900
> +++ linux-2.6.12-rc2-mm3-kei/drivers/base/node.c	2005-04-14 20:49:37.000000000 +0900
> @@ -136,7 +136,7 @@ static SYSDEV_ATTR(distance, S_IRUGO, no
>   
> +EXPORT_SYMBOL(register_node);
> +EXPORT_SYMBOL(unregister_node);
> +#endif /* CONFIG_HOTPLUG */
>  

please make these EXPORT_SYMBOL_GPL; the rest of sysfs is too and this
is very much deep kernel internals that are linux specific.


