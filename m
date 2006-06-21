Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWFUUx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWFUUx3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 16:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWFUUx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 16:53:29 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:29346
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932467AbWFUUx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:53:28 -0400
Date: Wed, 21 Jun 2006 13:53:39 -0700 (PDT)
Message-Id: <20060621.135339.59831267.davem@davemloft.net>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: mm-commits@vger.kernel.org
Subject: Re: + netlink-remove-dead-code.patch added to -mm tree
From: David Miller <davem@davemloft.net>
In-Reply-To: <200606212033.k5LKXw9B003804@shell0.pdx.osdl.net>
References: <200606212033.k5LKXw9B003804@shell0.pdx.osdl.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: akpm@osdl.org
Date: Wed, 21 Jun 2006 13:33:58 -0700

> diff -puN net/netlink/af_netlink.c~netlink-remove-dead-code net/netlink/af_netlink.c
> --- a/net/netlink/af_netlink.c~netlink-remove-dead-code
> +++ a/net/netlink/af_netlink.c
> @@ -1380,9 +1380,6 @@ static int netlink_dump(struct sock *sk)
>  
>  	netlink_destroy_callback(cb);
>  	return 0;
> -
> -nlmsg_failure:
> -	return -ENOBUFS;
>  }
>  
>  int netlink_dump_start(struct sock *ssk, struct sk_buff *skb,

Andrew, please type make before you commit things like this
to your tree.  This breaks the build.

These code labels are referenced internally by the netlink packet
message macros, in this case the reference comes from
NLMSG_NEW_ANSWER().
