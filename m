Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263436AbUCYRpP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 12:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbUCYRpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 12:45:15 -0500
Received: from chaos.analogic.com ([204.178.40.224]:30080 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263436AbUCYRpF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 12:45:05 -0500
Date: Thu, 25 Mar 2004 12:45:20 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Marco Berizzi <pupilla@hotmail.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: proxy arp behaviour
In-Reply-To: <DAV6695HfqR77bieLYC00007982@hotmail.com>
Message-ID: <Pine.LNX.4.53.0403251238570.2717@chaos>
References: <DAV6695HfqR77bieLYC00007982@hotmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2004, Marco Berizzi wrote:

> Hello everybody,
>
> I would like some info about proxy arp behaviour.
> I have a firewall linux running kernel 2.4.25
> with 3 NIC. Proxy arp is enabled on two of them
> (eth0 and eth1).
>
> eth1 configuration is here:
>
> ifconfig eth1 10.77.77.1 broadcast 10.77.77.3 netmask 255.255.255.252
> ip route del 10.77.77.0/30 dev eth1
> ip route add 172.17.1.0/24 dev eth1
>
> echo 1 > /proc/sys/net/ipv4/conf/eth1/proxy_arp
>
> Hosts connected to eth1 are all 172.17.1.0/24.
> The linux box is now replying to arp requests
> that are sent by 172.17.1.0/24 hosts on the eth1
> network segment. Is this because ip on eth1 is
> 10.77.77.1?
>
> I think that linux should not reply to arp request
> for 172.17.1.0/24 because of:
>
> ip route add 172.17.1.0/24 dev eth1
>
> Is this a bug?

This problem comes up periodically and when it does there
results in a bunch of noise to show that "Linux works perfectly...",
but never with any resolution.

What needs to be answered by persons who know the network
code is how one "connects" a particular response to a
particular device.

This has become a FAQ and needs to have some written documentation
somewhere.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


