Return-Path: <linux-kernel-owner+w=401wt.eu-S932988AbXABIjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932988AbXABIjz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 03:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932986AbXABIjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 03:39:55 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:51111
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932985AbXABIjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 03:39:54 -0500
Date: Tue, 02 Jan 2007 00:39:53 -0800 (PST)
Message-Id: <20070102.003953.21925510.davem@davemloft.net>
To: bunk@stusta.de
Cc: samuel@sortiz.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/irda/: proper prototypes
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061218034626.GY10316@stusta.de>
References: <20061218034626.GY10316@stusta.de>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Mon, 18 Dec 2006 04:46:26 +0100

> This patch adds proper prototypes for some functions in
> include/net/irda/irda.h
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
 ...
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

Remind me why you remove the "extern" from "external" function
declarations all the time?

I don't like it, even if it's "correct", because it is inconsistent
with what we do in the entire rest of the networking code.
