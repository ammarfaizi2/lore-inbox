Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264216AbRFODr6>; Thu, 14 Jun 2001 23:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264217AbRFODrs>; Thu, 14 Jun 2001 23:47:48 -0400
Received: from dsl254-119-131.nyc1.dsl.speakeasy.net ([216.254.119.131]:41742
	"EHLO lcremeans.homeip.net") by vger.kernel.org with ESMTP
	id <S264216AbRFODrj>; Thu, 14 Jun 2001 23:47:39 -0400
Date: Thu, 14 Jun 2001 23:48:05 -0400
From: Lee Cremeans <lee@lcremeans.homeip.net>
To: linux-kernel@vger.kernel.org
Subject: Intel PRO/16 sudden latency problems
Message-ID: <20010614234805.A36211@lcremeans.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-OS: FreeBSD 3.0-STABLE
Organization: My room? Are you crazy? :)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using an old Inel EtherExpress Pro/10 ISA (i82595-based) to connect my
testbox (AMD K6-3 400, VIA MVP3 chipset, running Debian woody with kernel
2.4.5) to my home LAN, which connects to the net through 608/128 kbit ADSL.
The problem I'm seeing is after long periods of sustained activity, the
eepro driver seems to go wonky -- sites that I can usually get the full
62KB/s download rates from, suddenly drop to below modem speed, and when I
ping my default gateway (my Duron 800 running FreeBSD 4.3-STABLE), I get
ping times of around 1s each, with relative little deviance. Resetting the
card using "ifdown eth0" then "ifup eth0" fixes things, at least
temporarily. 

I've also noticed that if I give the driver the IRQ and port address as
parameters, sometimes the driver will detect the card multiple times (I've
seen as many as 8 device entries in some cases); if I autodetect the
parameters, it detects the card just once, which is correct for my setup.
Either way, the driver seems to lose its mind after a few minues of
downloads. For what it's worth, the card works fine in every other OS I've
tested (Windows 2000 Pro, FreeBSD 4.3-STABLE, DOS with Intel's packet
driver).

-lee
