Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318212AbSGWWKI>; Tue, 23 Jul 2002 18:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318215AbSGWWKI>; Tue, 23 Jul 2002 18:10:08 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:48394 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318212AbSGWWKH>; Tue, 23 Jul 2002 18:10:07 -0400
Date: Tue, 23 Jul 2002 18:06:58 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Julian Anastasov <ja@ssi.bg>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG?] unwanted proxy arp in 2.4.19-pre10
In-Reply-To: <Pine.LNX.4.44.0207140955520.8340-100000@u.domain.uli>
Message-ID: <Pine.LNX.3.96.1020723172234.2194B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jul 2002, Julian Anastasov wrote:

> 	Start with fixing your picture (all hubs and wires, please).
> Linux ARP never sends 1 broadcasts through 2 devices, so it seems there is 
> a hub near Node_A (or Node_A is running bridging), I can't believe 230.1 
> and 230.4 are directly connected with cross cable. Make sure you have
> the needed host/subnet routes for each interface. Also, make
> sure tcpdump really shows the ARP replies, make the tests with
> arp -d IP ; ping -c 1 IP

The tests were made with a copy of tcpdump on every NIC of every machine
involved, with a hardware sniffer on each of the NICs. It was analyzed by
ISP network gurus, and it appears that it really does happen, and both
D-Link and Cisco switches don't like it when it does.

The problem was solved by substituting a more capable node.

Since I'm told by network people that current behaviour is the desired
behaviour, by definition there is no bug. By a mixture of diddling flags
in /proc/sys and hand routing every address through the desired NIC you
can make it work, so "no problem."

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

