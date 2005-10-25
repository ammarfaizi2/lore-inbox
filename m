Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVJYIWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVJYIWy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 04:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbVJYIWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 04:22:53 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:29713 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S932087AbVJYIWx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 04:22:53 -0400
Date: Tue, 25 Oct 2005 17:22:54 +0900 (JST)
Message-Id: <20051025.172254.100422401.yoshfuji@linux-ipv6.org>
To: acme@ghostprotocols.net
Cc: yanzheng@21cn.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH]IPv6: fix refcnt of struct ip6_flowlabel
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <39e6f6c70510241135p18b018bo896b3565fa5ce87b@mail.gmail.com>
References: <435CCF7B.6030907@21cn.com>
	<39e6f6c70510241135p18b018bo896b3565fa5ce87b@mail.gmail.com>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <39e6f6c70510241135p18b018bo896b3565fa5ce87b@mail.gmail.com> (at Mon, 24 Oct 2005 16:35:33 -0200), Arnaldo Carvalho de Melo <acme@ghostprotocols.net> says:

> On 10/24/05, Yan Zheng <yanzheng@21cn.com> wrote:
> > Signed-off-by: Yan Zheng <yanzheng@21cn.com>
> >
> >
> > Index: net/ipv6/ip6_flowlabel.c
> > ===================================================================
> > --- linux-2.6.14-rc5/net/ipv6/ip6_flowlabel.c   2005-10-22 10:31:13.000000000 +0800
> > +++ linux/net/ipv6/ip6_flowlabel.c      2005-10-24 19:55:23.000000000 +0800
> > @@ -483,7 +483,7 @@
> >                                                 goto done;
> >                                         }
> >                                         fl1 = sfl->fl;
> > -                                       atomic_inc(&fl->users);
> > +                                       atomic_inc(&fl1->users);
> >                                         break;
> 
> Looks OK to me, Yoshifuji-san, ACK?

Acked-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

--yoshfuji
