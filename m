Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264422AbTLBXNV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 18:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbTLBXNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 18:13:21 -0500
Received: from scrat.hensema.net ([62.212.82.150]:5082 "EHLO scrat.hensema.net")
	by vger.kernel.org with ESMTP id S264422AbTLBXNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 18:13:15 -0500
From: Erik Hensema <erik@hensema.net>
Subject: 2.6.0-test11: crash in de2104x driver after promisc mode
Date: Tue, 2 Dec 2003 23:13:05 +0000 (UTC)
Message-ID: <slrnbsq741.37m.erik@bender.home.hensema.net>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Today I upgraded my home server to 2.6.0-test11. I'm experiencing the crash
reported in:
http://marc.theaimsgroup.com/?l=linux-kernel&m=106718982223037&w=2

Basically the box hangs when I put my eth0 into promiscious mode, or
shortly after it.

I was using the de2104x driver, but I switched to the de4x5 driver, which
works fine.

Hardware:

tulip-diag.c:v2.17 5/6/2003 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html

[eth0, uses de4x5:]

Index #1: Found a Digital DC21041 Tulip adapter at 0xbc00.
 Port selection is half-duplex.
 Transmit started, Receive started.
  The Rx process state is 'Waiting for packets'.
  The Tx process state is 'Idle'.
  The transmit unit is set to store-and-forward.
  The NWay status register is 000001c8.
    100baseTx link good.
    10baseT link good.
  Internal autonegotiation state is 'Autonegotiation disabled'.

[eth1, uses tulip:]

Index #2: Found a ADMtek AL985 Centaur-P adapter at 0xc000.
 Comet duplex is reported in the MII status registers.
 Transmit started, Receive started.
  The Rx process state is 'Waiting for packets'.
  The Tx process state is 'Idle'.
  The transmit threshold is 128.
  Comet MAC address registers 99bf5000 ffff75e1
  Comet multicast filter 8200000041000020.
 Use '-a' or '-aa' to show device registers,
     '-e' to show EEPROM contents, -ee for parsed contents,
  or '-m' or '-mm' to show MII management registers.


Another problem is that I can't reach ntpd over the network. Otherwise it
seems to work fine. I haven't investigated this at all yet, though.

-- 
Erik Hensema <erik@hensema.net>
