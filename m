Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVJOIFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVJOIFy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 04:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVJOIFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 04:05:54 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:52497 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750723AbVJOIFx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 04:05:53 -0400
Date: Sat, 15 Oct 2005 18:05:39 +1000
To: Suzanne Wood <suzannew@cs.pdx.edu>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] rcu in drivers/net/hamradio
Message-ID: <20051015080539.GA23174@gondor.apana.org.au>
References: <200510150757.j9F7vNv8006813@rastaban.cs.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510150757.j9F7vNv8006813@rastaban.cs.pdx.edu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2005 at 12:57:23AM -0700, Suzanne Wood wrote:
> 
> Another list_for_each_entry() in bpq_seq_start() in a marked rcu 
> read-side critical section becomes the rcu version.

Good catch.  You might want to add an rcu_dereference in bpq_seq_next
as well.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
