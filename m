Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261850AbSKCNVc>; Sun, 3 Nov 2002 08:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261856AbSKCNVc>; Sun, 3 Nov 2002 08:21:32 -0500
Received: from mail02.axelero.hu ([195.228.240.77]:38076 "EHLO addu.axelero.hu")
	by vger.kernel.org with ESMTP id <S261850AbSKCNV0>;
	Sun, 3 Nov 2002 08:21:26 -0500
Date: Sun, 03 Nov 2002 15:27:42 +0100
From: Andras Kis-Szabo <kisza@securityaudit.hu>
Subject: Re: [PATCH] IPv6: Functions Clean-up
In-reply-to: <20021103.221658.52523847.yoshfuji@linux-ipv6.org>
To: YOSHIFUJI Hideaki / =?UTF-8?Q?=E5=90=89=E8=97=A4=E8=8B=B1?=
	 =?UTF-8?Q?=E6=98=8E?= <yoshfuji@linux-ipv6.org>
Cc: linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>,
       Netfilter Devel <netfilter-devel@lists.netfilter.org>,
       "David S. Miller" <davem@redhat.com>, kuznet@ms2.inr.ac.ru,
       usagi@linux-ipv6.org
Message-id: <1036333662.12980.27.camel@arwen>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.0.8
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <20021103.115427.104445233.yoshfuji@linux-ipv6.org>
 <1036328414.1048.3.camel@arwen>
 <20021103.221658.52523847.yoshfuji@linux-ipv6.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> /*
>  * Taken from net/ipv6/ip6_output.c
>  * We should use the one there, but is defined static
>  * so we put this just here and let the things as
>  * they are now.
>  *
>  * If that one is modified, this one should be modified too.
>  */
> 
> So, the reason why the copy of route6_me_harder() 
> lives there is because net/ipv6/ip6_output.c has not been 
> exported it.
Ok, ok! I have not got problems with this any more! :)
It is even worse that the route6_me_harder() depends on the
CONFIG_NETFILTER option, so this function comes from the Netfilter. In
this case it is an unwanted code-duplication :(
 
> Is this something to do with parser of extension headers?
> Parser of extension headers is different thing, isn't it?
Yes, it is a different thing with different code.
 
Regards,

kisza

-- 
    Andras Kis-Szabo       Security Development, Design and Audit
-------------------------/        Zorp, NetFilter and IPv6
 kisza@SecurityAudit.hu /------------------------------------------->

