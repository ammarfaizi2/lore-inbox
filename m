Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751588AbWAaWG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbWAaWG4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 17:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbWAaWG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 17:06:56 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:45327 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751585AbWAaWGy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 17:06:54 -0500
Date: Wed, 1 Feb 2006 09:06:40 +1100
To: Ingo Molnar <mingo@elte.hu>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [lock validator] inet6_destroy_sock(): soft-safe -> soft-unsafe lock dependency
Message-ID: <20060131220640.GA4428@gondor.apana.org.au>
References: <20060127001807.GA17179@elte.hu> <E1F2IcV-0007Iq-00@gondolin.me.apana.org.au> <20060128152204.GA13940@elte.hu> <20060131102758.GA31460@gondor.apana.org.au> <20060131212432.GA18812@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131212432.GA18812@elte.hu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 10:24:32PM +0100, Ingo Molnar wrote:
> 
> just to make sure - is the trace below a safe use of sk_dst_lock too?  
> Here sk_dst_lock seems to be taken in real softirq context.

You're right this does look suspicious.  Let me take a closer look...
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
