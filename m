Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262969AbSJGKee>; Mon, 7 Oct 2002 06:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262970AbSJGKee>; Mon, 7 Oct 2002 06:34:34 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:13715 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S262969AbSJGKed>;
	Mon, 7 Oct 2002 06:34:33 -0400
Date: Mon, 7 Oct 2002 12:40:05 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200210071040.MAA18108@harpo.it.uu.se>
To: jgarzik@pobox.com, zwane@linuxpower.ca
Subject: Re: [PATCH][2.5][RFT] 3c509.c extra ethtool features
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Oct 2002 17:00:14 -0400 (EDT), Zwane Mwaikambo wrote:
>	If anyone has a 3c509 could they try;
>
>ethtool eth0
>ethtool -s eth0 port tp, bnc etc..
>ethtool eth0
>
>and see if all the returned stuff looks sane.

3c509-TPO, ca 1994 vintage, ethtool eth0 output:

Settings for eth0:
	Supported ports: [ TP AUI ]
	Supported link modes:   10baseT/Half 10baseT/Full 
	Supports auto-negotiation: No
	Advertised link modes:  Not reported
	Advertised auto-negotiation: No
	Speed: 10Mb/s
	Duplex: Half
	Port: Twisted Pair
	PHYAD: 0
	Transceiver: internal
	Auto-negotiation: off
	Current message level: 0x00000002 (2)
	Link detected: yes

So far so good (except it reports AUI although it has none).
Unfortunately, this simple query killed the link, and I had to
down/up eth0 to get it back.
Next I tried ethtool -s to change some settings (port, speed,
full duplex) and all returned errors. I kind of expected that.
Next I tried to rlogin to this box from another: complete kernel hang :-(

I may be able to test some more later this week, on a slightly newer
3c509(B?) TP/AUI combo NIC.

/Mikael
