Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268421AbUHQU3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268421AbUHQU3m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 16:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268415AbUHQU2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 16:28:52 -0400
Received: from cmm219.neoplus.adsl.tpnet.pl ([83.31.140.219]:30980 "EHLO
	cnj25.neoplus.adsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S268416AbUHQU2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 16:28:25 -0400
Date: Tue, 17 Aug 2004 22:30:13 +0200
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: 2.6.8.1 - unresolved xfrm symbols in ip6_tunnel
Message-ID: <20040817203013.GA31993@satan.blackhosts>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just got:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.8.1; fi
WARNING: /lib/modules/2.6.8.1/kernel/net/ipv6/ip6_tunnel.ko needs unknown symbol xfrm6_tunnel_register
WARNING: /lib/modules/2.6.8.1/kernel/net/ipv6/ip6_tunnel.ko needs unknown symbol xfrm6_tunnel_deregister

with
CONFIG_IPV6_TUNNEL=m
and no XFRM (it wasn't selected by IPV6_TUNNEL and it's not possible to
select it standalone - XFRM is selected only by some options which
I don't use).

So I think that IPV6_TUNNEL should select or depend on XFRM...
or usage of the above symbols should depend on CONFIG_XFRM ||
CONFIG_XFRM_MODULE?


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
