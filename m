Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263790AbUFKKk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263790AbUFKKk2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 06:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUFKKk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 06:40:28 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:49934 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263790AbUFKKk0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 06:40:26 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: vda@port.imtp.ilyichevsk.odessa.ua (Denis Vlasenko)
Subject: Re: UDP sockets bound to ANY send answers with wrong src ip address
Cc: yoshfuji@linux-ipv6.org, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       davem@redhat.com, pekkas@netcore.fi, jmorris@redhat.com,
       linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <200406111230.35481.vda@port.imtp.ilyichevsk.odessa.ua>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.net,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.25-1-686-smp (i686))
Message-Id: <E1BYjMY-0002CE-00@gondolin.me.apana.org.au>
Date: Fri, 11 Jun 2004 20:34:18 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
> 
> I looked into sendmsg(). Looks like ther is no way to
> indicate source ip.
> 
> Shall I use some other technique?

IP_PKTINFO works just as well there.  Look at the ip_cmsg_send call
in udp_sendmsg.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
