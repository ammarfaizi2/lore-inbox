Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWGRPpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWGRPpL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 11:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWGRPpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 11:45:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25729 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932288AbWGRPpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 11:45:08 -0400
Date: Tue, 18 Jul 2006 11:44:30 -0400
From: Stephen Hemminger <shemminger@osdl.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       netdev@vger.kernel.org
Subject: Re: [RFC PATCH 32/33] Add the Xen virtual network device driver.
Message-ID: <20060718114430.73985431@localhost.localdomain>
In-Reply-To: <20060718091958.414414000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
	<20060718091958.414414000@sous-sol.org>
X-Mailer: Sylpheed-Claws 2.1.1 (GTK+ 2.8.17; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> diff -r eadc12b20f35 drivers/xen/netfront/netfront.c
> --- /dev/null	Thu Jan 01 00:00:00 1970 +0000
> +++ b/drivers/xen/netfront/netfront.c	Fri Jun 09 15:03:12 2006 -0400
> @@ -0,0 +1,1584 @@

> +static inline void init_skb_shinfo(struct sk_buff *skb)
> +{
> +	atomic_set(&(skb_shinfo(skb)->dataref), 1);
> +	skb_shinfo(skb)->nr_frags = 0;
> +	skb_shinfo(skb)->frag_list = NULL;
> +}

Shouldn't this move to skbuff.h?
