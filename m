Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265803AbUAKIpj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 03:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265804AbUAKIpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 03:45:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:46317 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265803AbUAKIpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 03:45:38 -0500
Date: Sun, 11 Jan 2004 00:45:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [NETDEV] experimental net driver queue updated
Message-Id: <20040111004540.403ca854.akpm@osdl.org>
In-Reply-To: <4000C5A3.5070101@pobox.com>
References: <4000C5A3.5070101@pobox.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Patch:
>  http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.1-bk1-netdev2.patch.bz2

net/core/netpoll.c: In function `netpoll_setup':
net/core/netpoll.c:572: warning: too many arguments for format
net/core/netpoll.c:572: warning: too many arguments for format

--- 25/net/core/netpoll.c~netpoll-warning-fix	2004-01-11 00:43:24.000000000 -0800
+++ 25-akpm/net/core/netpoll.c	2004-01-11 00:43:50.000000000 -0800
@@ -569,7 +569,7 @@ int netpoll_setup(struct netpoll *np)
 		if (time_before(jiffies, atleast)) {
 			printk(KERN_NOTICE "%s: carrier detect appears flaky,"
 			       " waiting 10 seconds\n",
-			       np->name, np->dev_name);
+			       np->name);
 			while (time_before(jiffies, atmost))
 				cond_resched();
 		}

_

