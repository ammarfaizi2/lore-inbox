Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269882AbUJSWFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269882AbUJSWFZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 18:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269942AbUJSV6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 17:58:24 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:10761 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S269932AbUJSVyS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 17:54:18 -0400
Date: Wed, 20 Oct 2004 07:54:01 +1000
To: Lee Revell <rlrevell@joe-job.com>
Cc: vda@port.imtp.ilyichevsk.odessa.ua,
       Linux Network Development <netdev@oss.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: tun.c patch to fix "smp_processor_id() in preemptible code"
Message-ID: <20041019215401.GA16427@gondor.apana.org.au>
References: <E1CK1e6-0004F3-00@gondolin.me.apana.org.au> <1098222676.23367.18.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098222676.23367.18.camel@krustophenia.net>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 05:51:17PM -0400, Lee Revell wrote:
> 
> Ok, here is the correct patch.  If this is really just a matter of
> performance, and not required for correctness, disabling preemption is
> broken, right?

No if you're doing this then you should get rid of netif_rx_ni()
altogether.  But before you do that please ask all the people who
call it.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
