Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264292AbTEZF7i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 01:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbTEZF7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 01:59:38 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:8465 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S264292AbTEZF7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 01:59:36 -0400
Date: Mon, 26 May 2003 16:12:34 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] make icmp.c be more verbose on broadcast icmp errors
In-Reply-To: <Pine.LNX.4.51.0305231222450.8169@dns.toxicfilms.tv>
Message-ID: <Mutt.LNX.4.44.0305261611180.7870-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 May 2003, Maciej Soltysiak wrote:

>  		if (net_ratelimit())
>  			printk(KERN_WARNING "%u.%u.%u.%u sent an invalid ICMP "
> +					    "type %u, code %u "
>  					    "error to a broadcast.\n",
> -			       NIPQUAD(skb->nh.iph->saddr));
> +			       NIPQUAD(skb->nh.iph->saddr),
> +			       icmph->type, icmph->code);

>  			if (net_ratelimit())
> -				printk(KERN_WARNING "%u.%u.%u.%u sent an invalid ICMP error to a broadcast.\n",
> -			       	NIPQUAD(skb->nh.iph->saddr));
> +				printk(KERN_WARNING "%u.%u.%u.%u sent an invalid ICMP type %u, code %u error to a broadcast.\n",
> +			       	NIPQUAD(skb->nh.iph->saddr),
> +			       	icmph->type, icmph->code);


Perhaps make this a static inline, icmp_warn_invalid() or similar.


- James
-- 
James Morris
<jmorris@intercode.com.au>

