Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265176AbUAJOsg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 09:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265177AbUAJOsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 09:48:36 -0500
Received: from yu82.neoplus.adsl.tpnet.pl ([80.54.140.82]:60832 "EHLO
	orbiter.attika.ath.cx") by vger.kernel.org with ESMTP
	id S265176AbUAJOse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 09:48:34 -0500
Date: Sat, 10 Jan 2004 15:48:31 +0100
From: Piotr Kaczuba <pepe@attika.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: tulip driver: errors instead TX packets?
Message-ID: <20040110144831.GA16080@orbiter.attika.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed	DelSp=Yes
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a ADMtek Centaur (3cSOHO100B-TX) running with the tulip driver  
on 2.6.1. I wonder if anyone has noticed that ifconfig shows the  
packets sent in the errors field instead of the TX packets field. At  
least, this is what I assume because it shows 0 TX packets and 11756  
errors.

Here's the ifconfig output for eth0, which is used for PPPoE:

eth0      Link encap:Ethernet  HWaddr 00:04:75:B1:E0:77
          inet6 addr: fe80::204:75ff:feb1:e077/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:9130 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:11756 dropped:0 overruns:0 carrier:23473
          collisions:0 txqueuelen:1000
          RX bytes:1723335 (1.6 MiB)  TX bytes:0 (0.0 b)
          Interrupt:10 Base address:0x5000

I had the same behaviour with 2.4 and the tulip driver from scyld.

This is what tulip-diag reports:

tulip-diag.c:v2.18 11/12/2003 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a 3Com 3cSOHO100B-TX (ADMtek Centaur) adapter at  
0xd000.
 Comet duplex is reported in the MII status registers.
 Transmit started, Receive started.
  The Rx process state is 'Waiting for packets'.
  The Tx process state is 'Idle'.
  The transmit threshold is 128.
  Comet MAC address registers b1750400 ffff77e0
  Comet multicast filter 8000000040001000.
 Use '-a' or '-aa' to show device registers,
     '-e' to show EEPROM contents, -ee for parsed contents,
  or '-m' or '-mm' to show MII management registers.

Is it okay for the TX process to be in idle state although there  
definitly is outgoing traffic?

Please CC any replies to me as I'am not subscribed.

Piotr Kaczuba
