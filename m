Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267497AbRG2CPh>; Sat, 28 Jul 2001 22:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267501AbRG2CPS>; Sat, 28 Jul 2001 22:15:18 -0400
Received: from femail43.sdc1.sfba.home.com ([24.254.60.37]:51401 "EHLO
	femail43.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S267497AbRG2CPR>; Sat, 28 Jul 2001 22:15:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steve Snyder <swsnyder@home.com>
Reply-To: swsnyder@home.com
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: What does "Neighbour table overflow" message indicate?
Date: Sat, 28 Jul 2001 21:15:11 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01072820231401.01125@mercury.snydernet.lan> <01072820534802.01125@mercury.snydernet.lan> <20010729135728.B3282@weta.f00f.org>
In-Reply-To: <20010729135728.B3282@weta.f00f.org>
MIME-Version: 1.0
Message-Id: <01072821151103.01125@mercury.snydernet.lan>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Saturday 28 July 2001 08:57 pm, Chris Wedgwood wrote:
> On Sat, Jul 28, 2001 at 08:53:48PM -0500, Steve Snyder wrote:
>
>     No, and no errors are shown for it either:
>
>     # ifconfig lo
>     lo        Link encap:Local Loopback
>               inet addr:127.0.0.1  Mask:255.0.0.0
>               UP LOOPBACK RUNNING  MTU:16436  Metric:1
>               RX packets:196907 errors:0 dropped:0 overruns:0 frame:0
>               TX packets:196907 errors:0 dropped:0 overruns:0 carrier:0
>               collisions:0 txqueuelen:0
>
>     All *seems* well.  Just that 30-second period of messages and then
>     silence.
>
>
> What is the machine doing?  What kind of network is it attached to and
> with how many hosts on it?

It is a server for a small LAN.  Interfaces: eth0=LAN, eth1=cable modem.  I 
believe that I was playing Quake3 (multi-player across internet) on one of 
the LAN's client machines when the message were logged.  No corresponding 
messages are seen in the client's (another RHL v7.1 box) system log, but 
then, it's not running iptables.

Further snooping shows the error msg text in file inux/net/ipv4/route.c:

    if (net_ratelimit())
        printk("Neighbour table overflow.\n");

The reference to "net_ratelimit" make me wonder if it is related to 
iptables.  I am using iptable, and have since kernel 2.4.1, but I've seen 
these messages before.  Hmmm.
