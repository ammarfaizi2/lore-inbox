Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269400AbTGJPxx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 11:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269412AbTGJPxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 11:53:53 -0400
Received: from netcore.fi ([193.94.160.1]:38160 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id S269400AbTGJPxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 11:53:50 -0400
Date: Thu, 10 Jul 2003 19:08:20 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
cc: cat@zip.com.au, <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
In-Reply-To: <20030711.005542.04973601.yoshfuji@linux-ipv6.org>
Message-ID: <Pine.LNX.4.44.0307101906160.18224-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jul 2003, YOSHIFUJI Hideaki / [iso-2022-jp] 吉藤英明 wrote:
> In article <20030710154302.GE1722@zip.com.au> (at Fri, 11 Jul 2003 01:43:03 +1000), CaT <cat@zip.com.au> says:
> 
> > With 2.4.21-pre2 I can get a nice tunnel going over my ppp connection
> > and as such get ipv6 connectivity. I think went to 2.4.21 and then to
> > 2.4.22-pre4 and bringing up the tunnel fails as follows:
> :
> > ip addr add 3ffe:8001:000c:ffff::37/127 dev sit1
> >  ip route add ::/0 via 3ffe:8001:000c:ffff::36 
> > RTNETLINK answers: Invalid argument
> 
> This is not bug, but rather misconfiguration;
> you cannot use prefix::, which is mandatory subnet routers 
> anycast address, as unicast address.

While technically correct, I'm still not sure if this is (pragmatically) 
the correct approach.  It's OK to set a default route to go to the 
subnet routers anycast address (so, setting a route to prefix:: should 
not give you EINVAL).

-- 
Pekka Savola                 "You each name yourselves king, yet the
Netcore Oy                    kingdom bleeds."
Systems. Networks. Security. -- George R.R. Martin: A Clash of Kings

