Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUASOK3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 09:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbUASOK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 09:10:29 -0500
Received: from linux-bt.org ([217.160.111.169]:43472 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S265127AbUASOKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 09:10:09 -0500
Subject: Re: Problem with CONFIG_SYSCTL disabled
From: Marcel Holtmann <marcel@holtmann.org>
To: YOSHIFUJI Hideaki / =?UTF-8?Q?=E5=90=89=E8=97=A4=E8=8B=B1?=
	 =?UTF-8?Q?=E6=98=8E?= <yoshfuji@linux-ipv6.org>
Cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040119.224603.71004956.yoshfuji@linux-ipv6.org>
References: <1074519043.6070.93.camel@pegasus>
	 <20040119.224603.71004956.yoshfuji@linux-ipv6.org>
Content-Type: text/plain
Message-Id: <1074521369.6070.99.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 19 Jan 2004 15:09:29 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > 	In file included from drivers/net/net_init.c:53:
> > 	include/net/neighbour.h:216: error: parse error before "proc_handler"
> > 	include/net/neighbour.h:216: warning: function declaration isn't a prototype
> 
> ===== include/net/neighbour.h 1.5 vs edited =====
> --- 1.5/include/net/neighbour.h	Thu Jan 15 17:58:09 2004
> +++ edited/include/net/neighbour.h	Mon Jan 19 22:42:24 2004
> @@ -47,9 +47,7 @@
>  #include <linux/skbuff.h>
>  
>  #include <linux/err.h>
> -#ifdef CONFIG_SYSCTL
>  #include <linux/sysctl.h>
> -#endif
>  
>  #define NUD_IN_TIMER	(NUD_INCOMPLETE|NUD_DELAY|NUD_PROBE)
>  #define NUD_VALID	(NUD_PERMANENT|NUD_NOARP|NUD_REACHABLE|NUD_PROBE|NUD_STALE|NUD_DELAY)

so it is not needed to wrap the inclusion of linux/sysctl.h around
#ifdef's, but why is it done so many times?

	net/core/neighbour.c
	net/ipv4/devinet.c
	net/ipv4/arp.c
	net/ipv4/route.c
	net/ipv4/netfilter/ip_conntrack_standalone.c
	net/ipv6/route.c
	net/ipv6/addrconf.c
	net/ipv6/ndisc.c
	net/ipv6/icmp.c
	net/appletalk/sysctl_net_atalk.c
	net/bridge/br_netfilter.c

Regards

Marcel


