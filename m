Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316579AbSHGAGR>; Tue, 6 Aug 2002 20:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316578AbSHGAGR>; Tue, 6 Aug 2002 20:06:17 -0400
Received: from ja.mac.ssi.bg ([212.95.166.194]:52229 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S316576AbSHGAGO>;
	Tue, 6 Aug 2002 20:06:14 -0400
Date: Wed, 7 Aug 2002 03:10:26 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: ja@u.domain.uli
To: Jacek Konieczny <jajcus@pld.org.pl>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: "new style" netdevice allocation patch for TUN driver (2.4.18
 kernel)
Message-ID: <Pine.LNX.4.44.0208070259450.17783-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

Jacek Konieczny wrote:

> I had a lot of problem with tun devices created with both openvpn and
> vtund. When I wanted to shut down my system when the devices were in
> use (eg. TCP connection established on tun0 interface), even if the
> tunneling daemon was killed, it stopped while trying to deconfigure
> network. And "unregister_netdevice: waiting for tun0 to become free"
> message was displayed again and again. I tried to resolve this problem
> using Google, but I have only found out, that this is behaviour of 2.4
> kernels, and that it is proper
...
> This is patch against 2.4.18 sources.

	Don't waste time, now when 2.4.19 is out can you try with it? It 
has fix for such problem if you have multipath routes with such devices, 
Alexey already forgot about it :) As for tun in kernel it looks correct, 
unregister_netdevice() under rtnl_lock, only that dev_close is redundant.

Regards

--
Julian Anastasov <ja@ssi.bg>

