Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268352AbTBNXmy>; Fri, 14 Feb 2003 18:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268473AbTBNXmg>; Fri, 14 Feb 2003 18:42:36 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:58382 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id <S268409AbTBNXkv>; Fri, 14 Feb 2003 18:40:51 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: neilb@cse.unsw.edu.au (Neil Brown), linux-kernel@vger.kernel.org
Subject: Re: Routing problem with udp, and a multihomed host in 2.4.20
In-Reply-To: <15948.13879.734412.313081@notabene.cse.unsw.edu.au>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.14-20020917 ("Chop Suey!") (UNIX) (Linux/2.4.20-686-smp (i686))
Message-Id: <E18jpaa-0007Rc-00@gondolin.me.apana.org.au>
Date: Sat, 15 Feb 2003 10:49:52 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> wrote:
> 
> It turns out that the problem occurs when send_msg is used to send a
> UDP packet, and the control information contains
>              struct in_pktinfo {
>                  unsigned int   ipi_ifindex;  /* Interface index */
>                  struct in_addr ipi_spec_dst; /* Local address */
>                  struct in_addr ipi_addr;     /* Header Destination address */
>              };
> specifying the address and interface of the message that we are
> replying to.

So your application is forcing the packet to go out on a specific
interface bypassing the routing table...
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
