Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbUCYRRd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 12:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbUCYRQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 12:16:09 -0500
Received: from sea2-dav66.sea2.hotmail.com ([207.68.164.201]:24328 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263483AbUCYROP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 12:14:15 -0500
X-Originating-IP: [80.204.235.254]
X-Originating-Email: [pupilla@hotmail.com]
From: "Marco Berizzi" <pupilla@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: proxy arp behaviour
Date: Thu, 25 Mar 2004 18:14:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1123
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1123
Message-ID: <DAV6695HfqR77bieLYC00007982@hotmail.com>
X-OriginalArrivalTime: 25 Aug 2001 04:49:10.0421 (UTC) FILETIME=[47C2E450:01C12D21]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

I would like some info about proxy arp behaviour.
I have a firewall linux running kernel 2.4.25
with 3 NIC. Proxy arp is enabled on two of them
(eth0 and eth1).

eth1 configuration is here:

ifconfig eth1 10.77.77.1 broadcast 10.77.77.3 netmask 255.255.255.252
ip route del 10.77.77.0/30 dev eth1
ip route add 172.17.1.0/24 dev eth1

echo 1 > /proc/sys/net/ipv4/conf/eth1/proxy_arp

Hosts connected to eth1 are all 172.17.1.0/24.
The linux box is now replying to arp requests
that are sent by 172.17.1.0/24 hosts on the eth1
network segment. Is this because ip on eth1 is
10.77.77.1?

I think that linux should not reply to arp request
for 172.17.1.0/24 because of:

ip route add 172.17.1.0/24 dev eth1

Is this a bug?

TIA
