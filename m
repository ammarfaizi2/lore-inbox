Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262682AbVCKMR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbVCKMR4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 07:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVCKMR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 07:17:56 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:1297 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262682AbVCKMJX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 07:09:23 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: rmk+lkml@arm.linux.org.uk (Russell King)
Subject: Re: Netfilter ipt_hashlimit
Cc: linux-kernel@vger.kernel.org, netfilter@lists.netfilter.org,
       davem@davemloft.net
Organization: Core
In-Reply-To: <20050310222934.C1044@flint.arm.linux.org.uk>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1D9itD-00039G-00@gondolin.me.apana.org.au>
Date: Fri, 11 Mar 2005 23:05:11 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> With current-ish Linus 2.6 BK, I'm seeing this:
> 
> net/ipv4/netfilter/ipt_hashlimit.c:96: warning: type defaults to `int' in declaration of `DECLARE_LOCK'
> net/ipv4/netfilter/ipt_hashlimit.c:96: warning: parameter names (without types) in function declaration
> 
> Looks like ipt_hashlimit.c is missing an include?

Indeed.  It should include lockhelp.h directly.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
===== net/ipv4/netfilter/ipt_hashlimit.c 1.10 vs edited =====
--- 1.10/net/ipv4/netfilter/ipt_hashlimit.c	2005-03-11 07:06:22 +11:00
+++ edited/net/ipv4/netfilter/ipt_hashlimit.c	2005-03-11 22:56:24 +11:00
@@ -37,6 +37,7 @@
 
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/netfilter_ipv4/ipt_hashlimit.h>
+#include <linux/netfilter_ipv4/lockhelp.h>
 
 /* FIXME: this is just for IP_NF_ASSERRT */
 #include <linux/netfilter_ipv4/ip_conntrack.h>
