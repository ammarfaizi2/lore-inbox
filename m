Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVD3KjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVD3KjI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 06:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVD3KjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 06:39:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:37775 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261184AbVD3KjD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 06:39:03 -0400
Date: Sat, 30 Apr 2005 03:38:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org
Subject: Re: 2.6.12-rc3-mm1
Message-Id: <20050430033818.06b94e26.akpm@osdl.org>
In-Reply-To: <42735E42.9050901@ens-lyon.org>
References: <20050429231653.32d2f091.akpm@osdl.org>
	<42735E42.9050901@ens-lyon.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
>
> Andrew Morton a écrit :
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm1/
> 
>  Hi Andrew,
> 
>  dmesg is flooded with these messages when lo is up.
>  I don't remember having ever seen this before.
>  My .config is attached.
>  Any idea ?
> 
>  Thanks,
>  Brice
> 
> 
> 
>  PROTO=6 127.0.0.1:53809 127.0.0.1:631 L=52 S=0x00 I=41505 F=0x4000 T=64
>  ip_local_deliver: bad loopback skb: PRE_ROUTING LOCAL_IN
>  skb: pf=2 (unowned) dev=lo len=274
>  PROTO=6 127.0.0.1:631 127.0.0.1:53809 L=274 S=0x00 I=15075 F=0x4000 T=64
>  ip_local_deliver: bad loopback skb: PRE_ROUTING LOCAL_IN
>  skb: pf=2 (unowned) dev=lo len=52
>  PROTO=6 127.0.0.1:53809 127.0.0.1:631 L=52 S=0x00 I=41507 F=0x4000 T=64
>  ip_local_deliver: bad loopback skb: PRE_ROUTING LOCAL_IN
>  skb: pf=2 (unowned) dev=lo len=69

Beats me.  Someone broke netfilter ;)

Turning off CONFIG_NETFILTER_DEBUG should shut the warnings up.
