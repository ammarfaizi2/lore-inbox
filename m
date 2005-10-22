Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbVJVWBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbVJVWBf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 18:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbVJVWBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 18:01:35 -0400
Received: from aeimail.aei.ca ([206.123.6.84]:22215 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1751173AbVJVWBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 18:01:34 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Billionton bluetooth CF card: performance is 10KB/sec
Date: Sat, 22 Oct 2005 18:01:48 -0400
User-Agent: KMail/1.8.2
Cc: marcel@holtmann.org, maxk@qualcomm.com, bluez-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
References: <20051022173152.GA2573@elf.ucw.cz>
In-Reply-To: <20051022173152.GA2573@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510221801.49314.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 October 2005 13:31, Pavel Machek wrote:
> Hi!
> 
> Ping time is around 50msec, and that seems pretty much okay, but
> 10KB/sec seems like way too low.
> 
> I am limited to 10KB/sec both on linux-to-linux bnetp transfers and it
> limits my transfer rates using edge and n6230, too :-(.
> 
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
> 
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
> 
> I use this to set up billionton:
> 
> setserial /dev/ttyBT baud_base 921600
> hciattach -s 921600 /dev/ttyBT bcsp
> 
> root@amd:~# tcpspray -n 1 -b 1000000 10.1.0.3
> 
> Transmitted 1000000 bytes in 163.256781 seconds (5.982 kbytes/s)
> 
> (okay, this was little slower, I was far from other side). Most tests
> look like this:
> 
> root@amd:~# tcpspray -n 1 -b 1000000 10.1.0.3
> 
> Transmitted 1000000 bytes in 103.183640 seconds (9.464 kbytes/s)

Pavel,

I see about the same with a bluetooth usb adapter.  Suspect that is about what
you should see with bluetooth - its not designed for speed.  It would be really 
nice to be wrong though...

Ed Tomlinson
