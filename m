Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315630AbSGNHa1>; Sun, 14 Jul 2002 03:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315631AbSGNHa0>; Sun, 14 Jul 2002 03:30:26 -0400
Received: from ja.mac.ssi.bg ([212.95.166.194]:4869 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S315630AbSGNHa0>;
	Sun, 14 Jul 2002 03:30:26 -0400
Date: Sun, 14 Jul 2002 10:34:15 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: ja@u.domain.uli
To: Bill Davidsen <davidsen@tmr.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG?] unwanted proxy arp in 2.4.19-pre10
Message-ID: <Pine.LNX.4.44.0207140955520.8340-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

Bill Davidsen wrote:

> 1, setting default, and setting 'all." The current settings, just the NICs
> in question, are producing two arp-replies with settings:

	As Alan already said, you need only arp_filter and I see
that you have the right settings in Node_B.

> eth0/arp_filter
> 1
> eth1/arp_filter
> 1

	Start with fixing your picture (all hubs and wires, please).
Linux ARP never sends 1 broadcasts through 2 devices, so it seems there is 
a hub near Node_A (or Node_A is running bridging), I can't believe 230.1 
and 230.4 are directly connected with cross cable. Make sure you have
the needed host/subnet routes for each interface. Also, make
sure tcpdump really shows the ARP replies, make the tests with
arp -d IP ; ping -c 1 IP

Regards

--
Julian Anastasov <ja@ssi.bg>

