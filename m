Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317400AbSHTWAC>; Tue, 20 Aug 2002 18:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317402AbSHTWAC>; Tue, 20 Aug 2002 18:00:02 -0400
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:7431 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S317400AbSHTWAA>; Tue, 20 Aug 2002 18:00:00 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200208202159.g7KLxrrM020439@wildsau.idv.uni.linz.at>
Subject: Re: need contact of via-rhine developers
In-Reply-To: <20020820175507.GA19273@k3.hellgate.ch> from Roger Luethi at "Aug 20, 2 07:55:08 pm"
To: rl@hellgate.ch (Roger Luethi)
Date: Tue, 20 Aug 2002 23:59:53 +0200 (MET DST)
Cc: kernel@wildsau.idv.uni.linz.at, rob.myers@gtri.gatech.edu,
       linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > thanks! that fixed the transmit-timeouts!

ouch, that was too soon. the new driver performs better, but not 100%
without timeouts.

> 
> Btw: The stalling you've seen, was that at 10 or 100 Mbps? Hub or Switch?

a 10 Mbps hub, half duplex connection. I tried with a Surecom and an Asante
hub. I also tried connection the two machines I've been testing with
with a crossover-cable, but things went worse then.

> With debug level 2 (and fixed driver), do you find Abort or Underrun errors
> in your log in situations where stalling occured with the old driver?

old driver, kernel 2.4.19, debug level 2:
  : via-rhine.c:v1.10-LK1.1.13  Nov-17-2001  Written by Donald Becker
  :   http://www.scyld.com/network/via-rhine.html
  : via-rhine: reset finished after 5 microseconds.
  : eth0: VIA VT6102 Rhine-II at 0xe800, 00:40:63:c0:b4:8c, IRQ 11.
  : eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 0021.
  : eth0: via_rhine_open() irq 11.
  : eth0: reset finished after 5 microseconds.
  : eth0: Transmit error, Tx status 00008100.
  : NETDEV WATCHDOG: eth0: transmit timed out
  : eth0: Transmit timed out, status 0000, PHY status 786d, resetting...
  : eth0: reset finished after 5 microseconds.


new driver with 2.4.19, debug level 2:
  : via-rhine.c:v1.10-LK1.1.14  May-3-2002  Written by Donald Becker
  :   http://www.scyld.com/network/via-rhine.html
  : via-rhine: reset finished after 5 microseconds.
  : eth0: VIA VT6102 Rhine-II at 0xe800, 00:40:63:c0:b4:8c, IRQ 11.
  : eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 0021.
  : eth0: via_rhine_open() irq 11.
  : eth0: reset finished after 5 microseconds.
  : eth0: no IPv6 routers present
  : eth0: Transmit error, Tx status 00008100.
  : eth0: Abort 2008, frame dropped.
  : eth0: Transmit error, Tx status 00008100.
  : eth0: Abort 2008, frame dropped.
  : NETDEV WATCHDOG: eth0: transmit timed out
  : eth0: Transmit timed out, status 0000, PHY status 786d, resetting...
  : eth0: reset finished after 5 microseconds.
  : eth0: Transmit error, Tx status 00008100.
  : eth0: Abort 2008, frame dropped.
  : eth0: Transmit error, Tx status 00008100.
  : eth0: Abort 2008, frame dropped.
  : eth0: Transmit error, Tx status 00008100.
  : eth0: Abort 2008, frame dropped.
  : eth0: Transmit error, Tx status 00008100.
  : eth0: Abort 2008, frame dropped.
  : eth0: Transmit error, Tx status 00008100.
  : eth0: Abort 2008, frame dropped.
  : eth0: Transmit error, Tx status 00008100.
  : eth0: Abort 2008, frame dropped.
  : eth0: Transmit error, Tx status 00008100.
  : eth0: Abort 2008, frame dropped.
  : eth0: Transmit error, Tx status 00008100.
  : eth0: Abort 2008, frame dropped.
  : NETDEV WATCHDOG: eth0: transmit timed out
  : eth0: Transmit timed out, status 0000, PHY status 786d, resetting...
  : eth0: reset finished after 5 microseconds.
  : eth0: Transmit error, Tx status 00008100.
  : eth0: Abort 2008, frame dropped.
  : NETDEV WATCHDOG: eth0: transmit timed out
  : eth0: Transmit timed out, status 0000, PHY status 786d, resetting...
  : eth0: reset finished after 5 microseconds.
  : NETDEV WATCHDOG: eth0: transmit timed out
  : eth0: Transmit timed out, status 0000, PHY status 786d, resetting...
  : eth0: reset finished after 5 microseconds.

shall we continue this via private email?

regards,
h.rosmanith

