Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318709AbSG0Gpb>; Sat, 27 Jul 2002 02:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318710AbSG0Gpb>; Sat, 27 Jul 2002 02:45:31 -0400
Received: from ja.mac.ssi.bg ([212.95.166.194]:15364 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S318709AbSG0Gpb>;
	Sat, 27 Jul 2002 02:45:31 -0400
Date: Sat, 27 Jul 2002 09:49:03 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: ja@u.domain.uli
To: Bhavesh_P_Davda <bhaveshd@earth.dr.avaya.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.18 IPv4/devinet enhancements for down'ing interfaces
Message-ID: <Pine.LNX.4.44.0207270943001.1170-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

Bhavesh_P_Davda wrote:

> However, a simple "ifconfig eth0 192.11.13.15 netmask 255.255.255.192 up",
> followed by an "ifconfig eth0 down" still leaves FIB rules in place for
> the 192.11.13.15 address, so that an ARP request that arrives on, say eth1
> for 192.11.13.15 would result in a response being generated from eth1 for
> the old 192.11.13.15 address that was on eth0, even though eth0 is down.
>
> There are a couple of ways that  one can get around this problem:

You can also solve it with ip:

ip addr del 192.11.13.15/26 dev eth0

ifconfig does not delete the last remaining primary address

Regards

--
Julian Anastasov <ja@ssi.bg>

