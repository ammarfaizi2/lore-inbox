Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262346AbSJQXrJ>; Thu, 17 Oct 2002 19:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262349AbSJQXrJ>; Thu, 17 Oct 2002 19:47:09 -0400
Received: from tml.hut.fi ([130.233.44.1]:9741 "EHLO tml-gw.tml.hut.fi")
	by vger.kernel.org with ESMTP id <S262346AbSJQXrG>;
	Thu, 17 Oct 2002 19:47:06 -0400
Date: Fri, 18 Oct 2002 02:52:48 +0300 (EEST)
From: Ville Nuorvala <vnuorval@morphine.tml.hut.fi>
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
cc: ajtuomin@morphine.tml.hut.fi, <davem@redhat.com>, <kuznet@ms2.inr.ac.ru>,
       <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>,
       <pekkas@netcore.fi>, <torvalds@transmeta.com>, <jagana@us.ibm.com>
Subject: Re: [PATCHSET] Mobile IPv6 for 2.5.43
In-Reply-To: <20021018.021802.87011078.yoshfuji@linux-ipv6.org>
Message-ID: <Pine.GSO.4.44.0210180158330.18554-100000@morphine.tml.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Oct 2002, YOSHIFUJI Hideaki / [iso-2022-jp] 吉藤英明 wrote:

> In article <20021017162624.GC16370@morphine.tml.hut.fi> (at Thu, 17 Oct 2002 19:26:25 +0300), Antti Tuominen <ajtuomin@morphine.tml.hut.fi> says:
>
> [ipv6_tunnel]
>
> I think this is almost ok.
>
>   1. I believe s/ARPHRD_IPV6_IPV6_TUNNEL/ARPHRD_TUNNEL6/.

Ok by me! The comment of course says IPIP6 tunnel at the moment, but the
constant itself doesn't appear to be used anywhere.

>   2. Please put outer address to hardware address in dev.

The reason I haven't done this is that MAX_ADDR_LEN is just 8. Does anyone
have any objections against changing the value to 16?

>      Note: you need to modify SIOxxx ioctls too not to overrun!

Sorry, I'm not that familiar with ioctls, I just copied the basic
functionality from sit.c. Could you explain it a bit more thoroughly, so
even I with my thick skull understand what the problem is?


-Ville

--
Ville Nuorvala
Research Assistant, Institute of Digital Communications,
Helsinki University of Technology
email: vnuorval@tml.hut.fi, phone: +358 (0)9 451 5257


