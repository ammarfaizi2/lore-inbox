Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbULHH5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbULHH5n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 02:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbULHH5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 02:57:43 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:39182 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S262056AbULHH52
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 02:57:28 -0500
Date: Wed, 08 Dec 2004 16:58:50 +0900 (JST)
Message-Id: <20041208.165850.97660819.yoshfuji@linux-ipv6.org>
To: davem@davemloft.net
Cc: shemminger@osdl.org, mitch@sfgoth.com, kernel@linuxace.com,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] fix select() for SOCK_RAW sockets (ipv6)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20041207104815.3f7a4684.davem@davemloft.net>
References: <20041208.023530.26430801.yoshfuji@linux-ipv6.org>
	<20041207100140.781f4c00@dxpl.pdx.osdl.net>
	<20041207104815.3f7a4684.davem@davemloft.net>
Organization: USAGI Project
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

In article <20041207104815.3f7a4684.davem@davemloft.net> (at Tue, 7 Dec 2004 10:48:15 -0800), "David S. Miller" <davem@davemloft.net> says:

> On Tue, 7 Dec 2004 10:01:40 -0800
> Stephen Hemminger <shemminger@osdl.org> wrote:
> 
> > > Probably, we need to do the same for ipv6, don't we?
> > 
> > diff -Nru a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> > --- a/net/ipv6/af_inet6.c	2004-12-07 10:02:50 -08:00
> > +++ b/net/ipv6/af_inet6.c	2004-12-07 10:02:50 -08:00
> > @@ -513,6 +513,27 @@
> 
> We didn't do the "UDP select() fix" on ipv6 because we don't
> have the delayed checksumming optimization there.  So the
> ipv6 side really doesn't need this change.

Ok, thanks for the explanation.

--yoshfuji @ Strasbourg

