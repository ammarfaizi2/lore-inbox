Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbTJTVBM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 17:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbTJTU77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 16:59:59 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:56547 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262782AbTJTU7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 16:59:43 -0400
Date: Mon, 20 Oct 2003 22:59:33 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Donald Becker <becker@scyld.com>, linux-net@vger.kernel.org,
       jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: Problem with 2.4.22 and SMC EtherPower II 9432
Message-ID: <20031020205933.GS23191@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on two different machines the ethernet card works with kernel 2.2.20 but 
not with kernel 2.4.22 (both contain machines contain the same card).

Card:

lspci:
00:0b.0 Ethernet controller: Standard Microsystems Corp [SMC] 83C170QF (rev 08)

cat /proc/pci:
  Bus  0, device  11, function  0:
    Ethernet controller: SMC 9432 TX (rev 8).
      Fast devsel.  Fast back-to-back capable.  IRQ 10.  Master Capable.  
Latency=32.  Min Gnt=8.Max Lat=28.
      I/O at 0xb000 [0xb001].
      Non-prefetchable 32 bit memory at 0xde800000 [0xde800000].


Kernel 2.2.20 (working):
kernel: eth0: SMSC EPIC/100 83c170 at 0xb000, IRQ 10, 00:e0:29:3d:e4:6f.
kernel: eth0: MII transceiver #3 control 3000 status 7809.
kernel: eth0:  Autonegotiation advertising 01e1 link partner 0001.
...
kernel: eth0: Setting full-duplex based on MII #3 link partner capability of 45e1.


kernel 2.4.22 (not working):
kernel: epic100.c:v1.11 1/7/2001 Written by Donald Becker 
<becker@scyld.com>
kernel:   http://www.scyld.com/network/epic100.html
kernel:   (unofficial 2.4.x kernel port, version 1.11+LK1.1.14, Aug 4, 
2002)
kernel: epic100(00:0b.0): MII transceiver #3 control 3000 status 7809.
kernel: epic100(00:0b.0): Autonegotiation advertising 01e1 link partner 
0001.
kernel: eth0: SMSC EPIC/100 83c170 at 0xb000, IRQ 10, 00:e0:29:3d:e4:6f.
...
kernel: eth0: Setting full-duplex based on MII #3 link partner capability of 45e1.
kernel: NETDEV WATCHDOG: eth0: transmit timed out
kernel: eth0: Transmit timeout using MII device, Tx status 4003.
kernel: eth0: Restarting the EPIC chip, Rx 1/1 Tx 2/12.
kernel: eth0: epic_restart() done, cmd status 000a, ctl 0512 interrupt 240000.
kernel: eth0: Setting half-duplex based on MII #3 link partner 
capability of 0001.
kernel: NETDEV WATCHDOG: eth0: transmit timed out
kernel: eth0: Transmit timeout using MII device, Tx status 0003.
kernel: eth0: Restarting the EPIC chip, Rx 1/1 Tx 3/12.
kernel: eth0: epic_restart() done, cmd status 000a, ctl 0512 interrupt 240000.
kernel: NETDEV WATCHDOG: eth0: transmit timed out
kernel: eth0: Transmit timeout using MII device, Tx status 000b.
kernel: eth0: Restarting the EPIC chip, Rx 1/1 Tx 4/12.
kernel: eth0: epic_restart() done, cmd status 000a, ctl 0512 interrupt 240000.
kernel: NETDEV WATCHDOG: eth0: transmit timed out
kernel: eth0: Transmit timeout using MII device, Tx status 000b.
kernel: eth0: Restarting the EPIC chip, Rx 1/1 Tx 5/12.
kernel: eth0: epic_restart() done, cmd status 000a, ctl 0512 interrupt 240000.
kernel: NETDEV WATCHDOG: eth0: transmit timed out
kernel: eth0: Transmit timeout using MII device, Tx status 000b.
kernel: eth0: Restarting the EPIC chip, Rx 1/1 Tx 6/12.
kernel: eth0: epic_restart() done, cmd status 000a, ctl 0512 interrupt 240000.
kernel: eth0: Too much work at interrupt, IntrStatus=0x008d0004.
kernel: NETDEV WATCHDOG: eth0: transmit timed out
kernel: eth0: Transmit timeout using MII device, Tx status 000b.
kernel: eth0: Restarting the EPIC chip, Rx 1/1 Tx 7/17.
kernel: eth0: epic_restart() done, cmd status 000a, ctl 0512 interrupt 240000.



Does anyone have an idea what's going wrong in 2.4.22?


TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

