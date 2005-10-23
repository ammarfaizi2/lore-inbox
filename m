Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVJWJcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVJWJcM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 05:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbVJWJcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 05:32:12 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:59009 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1750786AbVJWJcL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 05:32:11 -0400
Subject: Re: Billionton bluetooth CF card: performance is 10KB/sec
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: maxk@qualcomm.com, bluez-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051022173152.GA2573@elf.ucw.cz>
References: <20051022173152.GA2573@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 23 Oct 2005 11:32:21 +0200
Message-Id: <1130059941.11428.81.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> Ping time is around 50msec, and that seems pretty much okay, but
> 10KB/sec seems like way too low.
> 
> I am limited to 10KB/sec both on linux-to-linux bnetp transfers and it
> limits my transfer rates using edge and n6230, too :-(.

so you say that the Nokia 6230 has PAN Profile support and you don't
need any PPP crap to get Internet access? This would be the first phone
I have seen so far.

> Ping times during transfer:
> 
> 64 bytes from 10.1.0.3: icmp_seq=149 ttl=64 time=62.8 ms
> 64 bytes from 10.1.0.3: icmp_seq=150 ttl=64 time=64.2 ms
> 64 bytes from 10.1.0.3: icmp_seq=151 ttl=64 time=85.9 ms
> 64 bytes from 10.1.0.3: icmp_seq=152 ttl=64 time=80.3 ms
> 64 bytes from 10.1.0.3: icmp_seq=153 ttl=64 time=132.1 ms
> 64 bytes from 10.1.0.3: icmp_seq=154 ttl=64 time=64.8 ms
> 64 bytes from 10.1.0.3: icmp_seq=155 ttl=64 time=128.3 ms
> 64 bytes from 10.1.0.3: icmp_seq=156 ttl=64 time=116.3 ms
> 64 bytes from 10.1.0.3: icmp_seq=157 ttl=64 time=120.5 ms
> 64 bytes from 10.1.0.3: icmp_seq=158 ttl=64 time=240.2 ms
> 64 bytes from 10.1.0.3: icmp_seq=159 ttl=64 time=111.2 ms
> 64 bytes from 10.1.0.3: icmp_seq=160 ttl=64 time=382.1 ms
> 64 bytes from 10.1.0.3: icmp_seq=161 ttl=64 time=912.6 ms
> 64 bytes from 10.1.0.3: icmp_seq=162 ttl=64 time=1612.1 ms
> 64 bytes from 10.1.0.3: icmp_seq=163 ttl=64 time=4373.6 ms
> 64 bytes from 10.1.0.3: icmp_seq=164 ttl=64 time=5128.8 ms
> 64 bytes from 10.1.0.3: icmp_seq=165 ttl=64 time=7191.1 ms
> 64 bytes from 10.1.0.3: icmp_seq=166 ttl=64 time=9473.1 ms
> 64 bytes from 10.1.0.3: icmp_seq=167 ttl=64 time=8469.0 ms
> 64 bytes from 10.1.0.3: icmp_seq=168 ttl=64 time=10040.7 ms
> 64 bytes from 10.1.0.3: icmp_seq=169 ttl=64 time=9036.7 ms
> 64 bytes from 10.1.0.3: icmp_seq=170 ttl=64 time=10681.1 ms
> 64 bytes from 10.1.0.3: icmp_seq=171 ttl=64 time=9677.1 ms
> 64 bytes from 10.1.0.3: icmp_seq=172 ttl=64 time=8673.0 ms
> 64 bytes from 10.1.0.3: icmp_seq=173 ttl=64 time=10685.0 ms
> 64 bytes from 10.1.0.3: icmp_seq=174 ttl=64 time=9681.0 ms
> 64 bytes from 10.1.0.3: icmp_seq=175 ttl=64 time=8677.0 ms
> 64 bytes from 10.1.0.3: icmp_seq=176 ttl=64 time=11997.2 ms
> 64 bytes from 10.1.0.3: icmp_seq=177 ttl=64 time=10993.4 ms
> 64 bytes from 10.1.0.3: icmp_seq=178 ttl=64 time=9989.3 ms
> 64 bytes from 10.1.0.3: icmp_seq=179 ttl=64 time=13797.3 ms
> 64 bytes from 10.1.0.3: icmp_seq=180 ttl=64 time=12793.3 ms
> 64 bytes from 10.1.0.3: icmp_seq=181 ttl=64 time=11789.1 ms
> 64 bytes from 10.1.0.3: icmp_seq=182 ttl=64 time=10784.9 ms
> 64 bytes from 10.1.0.3: icmp_seq=183 ttl=64 time=9781.1 ms

The initial pings look good, the rest is very bad.

> Netdev watchdog complains a lot:
> 
> Oct 22 18:53:57 amd pand[2439]: Bluetooth PAN daemon version 2.19
> Oct 22 18:53:57 amd pand[2439]: Connecting to <won't tell you>
> Oct 22 18:53:58 amd pand[2439]: bnep0 connected
> Oct 22 18:54:37 amd kernel: usb 3-1: USB disconnect, address 2
> Oct 22 18:55:33 amd kernel: NETDEV WATCHDOG: bnep0: transmit timed out
> Oct 22 18:55:59 amd last message repeated 2 times
> Oct 22 18:56:51 amd last message repeated 5 times
> Oct 22 18:57:55 amd last message repeated 3 times
> Oct 22 18:59:03 amd last message repeated 7 times

The transmit timeouts shouldn't be there. The question is now which side
is at fault. The host or the phone?

Please do a "hcitool info <won't tell you>" as root so I can see which
what chip we are dealing. Also "hciconfig hci0 version" for your card
would help.

You can also use "hcidump -X -V" to analyze the traffic.

Regards

Marcel


