Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161478AbWJ0Ebr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161478AbWJ0Ebr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 00:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161485AbWJ0Ebr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 00:31:47 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:10504 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1161465AbWJ0Ebq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 00:31:46 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: lkml@newipnet.com (Carlos Velasco)
Subject: Re: Networking messed up, bad checksum, incorrect length
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Organization: Core
In-Reply-To: <4541852A.7020701@newipnet.com>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.net
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1GdJNf-0002xT-00@gondolin.me.apana.org.au>
Date: Fri, 27 Oct 2006 14:31:43 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Velasco <lkml@newipnet.com> wrote:
> 
>> netfilter will see the jumbo frames rather than the individual packets.
> 
> I wonder if this could affect the TCP stateful tracking of netfilter
> making the ACK drops I see.

It shouldn't if netfilter is behaving correctly.  The whole point of
TSO is that the packet is an otherwise valid TCP/IP packet.  The only
thing special about it is that it exceeds the MTU of the output device.

That's what allows us to implement TSO without touching all parts of
the networking stack.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
