Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318378AbSGYI6k>; Thu, 25 Jul 2002 04:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318374AbSGYI5M>; Thu, 25 Jul 2002 04:57:12 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:16586 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318373AbSGYI5I>;
	Thu, 25 Jul 2002 04:57:08 -0400
Date: Thu, 25 Jul 2002 17:27:30 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: zhengchuanbo <zhengcb@netpower.com.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: about the performance of netfilter
Message-Id: <20020725172730.52214df0.rusty@rustcorp.com.au>
In-Reply-To: <200207242128878.SM00796@zhengcb>
References: <200207242128878.SM00796@zhengcb>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002 21:24:56 +0800
zhengchuanbo <zhengcb@netpower.com.cn> wrote:

> 
> we use a linux router. i just tested the performance of the router. when the kernel  is build without netfilter support,the throughput of 64bytes frame is about 45%. when i build the kernel with netfilter (only the ip_filter module),the throughput dropped to 24%, without any rules.
> so is there some way to improve the performance? i just want some simple packet filter. is netfilter no so good on the performance compare to ipchains due to the improved functionality?
> please cc.  thanks.

There are several stages.
1) CONFIG_NETFILTER=n
2) CONFIG_NETFILTER=y
3) CONFIG_NETFILTER=y CONFIG_IP_NF_TABLES=m, ip_tables.o loaded
4) iptables rules inserted.

Make sure you do not have CONFIG_NETFILTER_DEBUG or CONFIG_IP_NF_CONNTRACK
on!

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
