Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262506AbSJRAvD>; Thu, 17 Oct 2002 20:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262525AbSJRAvD>; Thu, 17 Oct 2002 20:51:03 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:46351 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S262506AbSJRAvC>; Thu, 17 Oct 2002 20:51:02 -0400
Date: Fri, 18 Oct 2002 09:56:48 +0900 (JST)
Message-Id: <20021018.095648.21063407.yoshfuji@linux-ipv6.org>
To: vnuorval@morphine.tml.hut.fi
Cc: ajtuomin@morphine.tml.hut.fi, davem@redhat.com, kuznet@ms2.inr.ac.ru,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org, pekkas@netcore.fi,
       torvalds@transmeta.com, jagana@us.ibm.com, yoshfuji@linux-ipv6.org
Subject: Re: [PATCHSET] Mobile IPv6 for 2.5.43
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.GSO.4.44.0210180158330.18554-100000@morphine.tml.hut.fi>
References: <20021018.021802.87011078.yoshfuji@linux-ipv6.org>
	<Pine.GSO.4.44.0210180158330.18554-100000@morphine.tml.hut.fi>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.44.0210180158330.18554-100000@morphine.tml.hut.fi> (at Fri, 18 Oct 2002 02:52:48 +0300 (EEST)), Ville Nuorvala <vnuorval@morphine.tml.hut.fi> says:

> >   2. Please put outer address to hardware address in dev.
> 
> The reason I haven't done this is that MAX_ADDR_LEN is just 8. Does anyone
> have any objections against changing the value to 16?
> 
> >      Note: you need to modify SIOxxx ioctls too not to overrun!
> 
> Sorry, I'm not that familiar with ioctls, I just copied the basic
> functionality from sit.c. Could you explain it a bit more thoroughly, so
> even I with my thick skull understand what the problem is?

in net/core/dev.c, there're codes to copy between dev->dev_{addr,broadcast}
and ifr_hwaddr.sa_data (points sockaddr{} sized 16).

Well, we have code for it. :-)
Please look at 
   <http://www2.linux-ipv6.org/cvsweb/usagi/kernel/linux24/net/core/dev.c.diff?r1=1.1.1.12&r2=1.4>


BTW, why don't we have SIOCGIFHWBROADCAST??

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
