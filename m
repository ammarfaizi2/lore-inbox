Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbTLaK6v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 05:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264472AbTLaK6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 05:58:51 -0500
Received: from astra.telenet-ops.be ([195.130.132.58]:58517 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S264258AbTLaK6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 05:58:46 -0500
From: Bart De Schuymer <bdschuym@pandora.be>
To: Tomas Szepe <szepe@pinerecords.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-rc1-mm1
Date: Wed, 31 Dec 2003 11:58:50 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       "David S. Miller" <davem@redhat.com>
References: <20031231004725.535a89e4.akpm@osdl.org> <20031231024855.0aca5e52.akpm@osdl.org> <20031231104947.GC16860@louise.pinerecords.com>
In-Reply-To: <20031231104947.GC16860@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312311158.50471.bdschuym@pandora.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 December 2003 11:49, Tomas Szepe wrote:
> On Dec-31 2003, Wed, 02:48 -0800
>
> Andrew Morton <akpm@osdl.org> wrote:
> > Tomas Szepe <szepe@pinerecords.com> wrote:
> > > In file included from include/linux/netfilter_bridge/ebtables.h:16,
> > >                  from net/bridge/netfilter/ebtables.c:25:
> > > include/linux/netfilter_bridge.h: In function
> > > `nf_bridge_maybe_copy_header': include/linux/netfilter_bridge.h:74:
> > > error: `ETH_P_8021Q' undeclared (first use in this function)
> >
> > This problem also exists in 2.6.1-rc1.
>
> Andrew, are you quite sure this is the correct fix?

I've sent this fix to David Miller, please don't apply any other "fix":

cheers,
Bart

--- linux-2.6.0-bk3/include/linux/netfilter_bridge.h.earlier	2003-12-31 11:54:25.000000000 +0100
+++ linux-2.6.0-bk3/include/linux/netfilter_bridge.h	2003-12-31 11:54:47.000000000 +0100
@@ -8,10 +8,8 @@
 #include <linux/netfilter.h>
 #if defined(__KERNEL__) && defined(CONFIG_BRIDGE_NETFILTER)
 #include <asm/atomic.h>
-#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 #include <linux/if_ether.h>
 #endif
-#endif
 
 /* Bridge Hooks */
 /* After promisc drops, checksum checks. */

