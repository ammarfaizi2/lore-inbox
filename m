Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264241AbTLaKsg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 05:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTLaKsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 05:48:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:52714 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264241AbTLaKse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 05:48:34 -0500
Date: Wed, 31 Dec 2003 02:48:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       "David S. Miller" <davem@redhat.com>
Subject: Re: 2.6.0-rc1-mm1
Message-Id: <20031231024855.0aca5e52.akpm@osdl.org>
In-Reply-To: <20031231101907.GB16860@louise.pinerecords.com>
References: <20031231004725.535a89e4.akpm@osdl.org>
	<20031231101907.GB16860@louise.pinerecords.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe <szepe@pinerecords.com> wrote:
>
> In file included from include/linux/netfilter_bridge/ebtables.h:16,
>                  from net/bridge/netfilter/ebtables.c:25:
> include/linux/netfilter_bridge.h: In function `nf_bridge_maybe_copy_header':
> include/linux/netfilter_bridge.h:74: error: `ETH_P_8021Q' undeclared (first use in this function)

This problem also exists in 2.6.1-rc1.


diff -puN include/linux/netfilter_bridge.h~netfilter_bridge-compile-fix include/linux/netfilter_bridge.h
--- 25/include/linux/netfilter_bridge.h~netfilter_bridge-compile-fix	2003-12-31 02:46:14.000000000 -0800
+++ 25-akpm/include/linux/netfilter_bridge.h	2003-12-31 02:46:33.000000000 -0800
@@ -5,6 +5,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/if_ether.h>
 #include <linux/netfilter.h>
 #if defined(__KERNEL__) && defined(CONFIG_BRIDGE_NETFILTER)
 #include <asm/atomic.h>

_

