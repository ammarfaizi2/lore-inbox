Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269530AbUJSVvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269530AbUJSVvq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 17:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269901AbUJSVtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 17:49:33 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:41736 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S269530AbUJSVgP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 17:36:15 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: rlrevell@joe-job.com (Lee Revell)
Subject: Re: tun.c patch to fix "smp_processor_id() in preemptible code"
Cc: vda@port.imtp.ilyichevsk.odessa.ua, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <1098210711.2148.69.camel@krustophenia.net>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CK1e6-0004F3-00@gondolin.me.apana.org.au>
Date: Wed, 20 Oct 2004 07:35:54 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
> 
> I looked at Robert Love's book and I am still unclear on the use of
> do_softirq above.  To reiterate the question:  why does netif_rx_ni have
> to manually flush any pending softirqs on the current proccessor after
> doing the rx?  Is this just a performance hack?

Yes it allows the packet to be processed immediately.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
