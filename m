Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbVJOMDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbVJOMDr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 08:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVJOMDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 08:03:47 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:28178 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751139AbVJOMDr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 08:03:47 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: suzannew@cs.pdx.edu (Suzanne Wood)
Subject: Re: [RFC][PATCH] rcu in drivers/net/hamradio
Cc: linux-kernel@vger.kernel.org, g4klx@g4klx.demon.co.uk, hch@infradead.org,
       jreuter@yaina.de, paulmck@us.ibm.com, suzannew@cs.pdx.edu,
       walpole@cs.pdx.edu
Organization: Core
In-Reply-To: <200510140804.j9E84nwG026920@rastaban.cs.pdx.edu>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EQkl4-0003gB-00@gondolin.me.apana.org.au>
Date: Sat, 15 Oct 2005 22:03:26 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suzanne Wood <suzannew@cs.pdx.edu> wrote:
> 
> (3) bpq_free_device() calls list_del_rcu() which, according 
> to list.h, requires synchronize_rcu() which can block or 
> call_rcu() or call_rcu_bh() which cannot block. 
> None of these is called anywhere in the directory drivers/net,
> so synchronize_irq() may address this.  
> (synchronize_sched() is called in drivers/net/sis190.c and 
> r8169.c with FIXME comment about synchronize_irq().)

The synchronisation is carried out by unregister_netdevice.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
