Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316793AbSEVAGi>; Tue, 21 May 2002 20:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316794AbSEVAGh>; Tue, 21 May 2002 20:06:37 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:21230 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S316793AbSEVAGh>; Tue, 21 May 2002 20:06:37 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15594.57612.421887.407469@wombat.chubb.wattle.id.au>
Date: Wed, 22 May 2002 10:06:36 +1000
To: linux-kernel@vger.kernel.org, hermes@gibson.dropbear.id.au
Subject: Orinoco Wireless driver bugs in 2.5.17
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	I see two undesireable behaviours with the Orinoco drivers in
2.5.17.

1.  With a compaq WL110 in a WL210 PCI<->PCMCIA bridge, I see many 

    NETDEV WATCHDOG: eth1: transmit timed out
    Tx timeout! Resetting card. ALLOCFID=00c0, TXCOMPLFID=00bf, EVSTAT=808a

messages, and see no activity on any other stations.

2.  With a Netgear MA401, every now and then the card goes into bozo
mode, when iwconfig reports:

eth0      IEEE 802.11-DS  Nickname:"piggle"
          Mode:Managed  Frequency:42.9497GHz  Tx-Power=15 dBm   
          RTS thr:off   
          Link Quality:241  Signal level:136  Noise level:107
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:0   Missed beacon:0


Note the Frequency there.  A `cardctl reset' fixes the problem.

Peter C
