Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264714AbSKDPx5>; Mon, 4 Nov 2002 10:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbSKDPx5>; Mon, 4 Nov 2002 10:53:57 -0500
Received: from mikonos.cyclades.com.br ([200.230.227.67]:20996 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id <S264714AbSKDPx4>; Mon, 4 Nov 2002 10:53:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Helio Fujimoto <fujima@cyclades.com>
Organization: Cyclades Brasil
To: linux-kernel@vger.kernel.org
Subject: Removing the route when Ethernet link goes down
Date: Mon, 4 Nov 2002 12:56:12 -0500
X-Mailer: KMail [version 1.2]
References: <200203191005.g2JA5Oq31884@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200203191005.g2JA5Oq31884@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Message-Id: <02110412561200.01022@fujima>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please answer this e-mail with copy to me, for I am not subscribed to the 
list.

I am debugging an Ethernet driver in the kernel 2.4.17, which is able to 
recognize when the Ethernet link is up or down. When the link is up, I am 
setting the bit IFF_RUNNING to the dev->flag parameter, and when it is down 
this bit is reset. Besides this, I am calling the routines netif_carrier_on 
and netif_carrier_off, respectively. This makes the interface status change 
(when I call ifconfig eth0).

However, the routing table doesn't change when link goes up or down, though 
they do change when I set the interface up and down. I couldn't find out what 
I could do to make the Ethernet driver work in this way, so that the routes 
to the Ethernet link would appear only if the interface was up and running. 
Do you have an easy (or maybe difficult) way to do this? Any routine, any 
magic?

Thanks in advance,

Helio Fujimoto.

