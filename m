Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262393AbVHAGyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbVHAGyq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 02:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbVHAGw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 02:52:57 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:15560 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262393AbVHAGwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 02:52:34 -0400
Message-ID: <42EDB89D.30209@ens-lyon.fr>
Date: Mon, 01 Aug 2005 07:52:29 +0200
From: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050623)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4-mm1
References: <20050731020552.72623ad4.akpm@osdl.org>
In-Reply-To: <20050731020552.72623ad4.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I have this when I enable nfnetlink as a module :

net/built-in.o: In function `ip_ct_port_tuple_to_nfattr':
: undefined reference to `__nfa_fill'
net/built-in.o: In function `ip_ct_port_tuple_to_nfattr':
: undefined reference to `__nfa_fill'
net/built-in.o: In function `tcp_to_nfattr':
ip_conntrack_proto_tcp.c:(.text+0x5c557): undefined reference to
`__nfa_fill'
net/built-in.o: In function `icmp_tuple_to_nfattr':
ip_conntrack_proto_icmp.c:(.text+0x5e1e2): undefined reference to
`__nfa_fill'
ip_conntrack_proto_icmp.c:(.text+0x5e221): undefined reference to
`__nfa_fill'
net/built-in.o:ip_conntrack_proto_icmp.c:(.text+0x5e25c): more undefined
references to `__nfa_fill' follow

Relevant part of my .config :

CONFIG_IP_NF_CONNTRACK_NETLINK=m
CONFIG_NETFILTER_NETLINK=m
# CONFIG_NETFILTER_NETLINK_QUEUE is not set


I am sorry, but I don't have time to investigate it further.

Regards,
Alexandre
