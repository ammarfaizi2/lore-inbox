Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132757AbRDQQqX>; Tue, 17 Apr 2001 12:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132758AbRDQQqO>; Tue, 17 Apr 2001 12:46:14 -0400
Received: from core.devicen.de ([62.159.186.206]:44050 "EHLO core.devicen.de")
	by vger.kernel.org with ESMTP id <S132757AbRDQQqD>;
	Tue, 17 Apr 2001 12:46:03 -0400
Date: Tue, 17 Apr 2001 18:45:52 +0200
From: Oliver Teuber <teuber@core.devicen.de>
To: jgarzik@mandrakesoft.com
Cc: linux-kernel@vger.kernel.org
Subject: epic100 error
Message-ID: <20010417184552.A6727@core.devicen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

my smc epic100 card does not work with the device driver from
linux-2.4.3-ac7. 

linux-2.2.19 works fine for me.

please take a look at my /var/log/messages ...

Apr 17 09:37:27 olibox kernel: epic100.c:v1.11 1/7/2001 Written by Donald Becker <becker@scyld.com>
Apr 17 09:37:27 olibox kernel:   http://www.scyld.com/network/epic100.html
Apr 17 09:37:27 olibox kernel:  (unofficial 2.4.x kernel port, version 1.1.6, January 11, 2001)
Apr 17 09:37:27 olibox kernel: PCI: Found IRQ 10 for device 00:09.0
Apr 17 09:37:27 olibox kernel: epic100(00:09.0): MII transceiver #3 control 3000 status 7809.
Apr 17 09:37:27 olibox kernel: epic100(00:09.0): Autonegotiation advertising 01e1 link partner 0001.
Apr 17 09:37:27 olibox kernel: eth0: SMSC EPIC/100 83c170 at 0xe800, IRQ 10, 00:e0:29:09:c9:f0.
Apr 17 09:37:27 olibox kernel: eth0: Setting full-duplex based on MII #3 link partner capability of 45e1.
Apr 17 09:37:27 olibox kernel: eth0: Too much work at interrupt, IntrStatus=0x008d0004.
Apr 17 09:37:55 olibox kernel: NETDEV WATCHDOG: eth0: transmit timed out
Apr 17 09:37:55 olibox kernel: eth0: Transmit timeout using MII device, Tx status 4003.
Apr 17 09:37:55 olibox kernel: eth0: Restarting the EPIC chip, Rx 1/1 Tx 2/12.
Apr 17 09:37:55 olibox kernel: eth0: epic_restart() done, cmd status 000a, ctl 0512 interrupt 240000.
Apr 17 09:37:56 olibox kernel: eth0: Setting half-duplex based on MII #3 link partner capability of 0001.                                                          

...

Apr 17 09:38:15 olibox kernel: NETDEV WATCHDOG: eth0: transmit timed out
Apr 17 09:38:15 olibox kernel: eth0: Transmit timeout using MII device, Tx status 000b.
Apr 17 09:38:15 olibox kernel: eth0: Restarting the EPIC chip, Rx 1/1 Tx 7/17.
Apr 17 09:38:15 olibox kernel: eth0: epic_restart() done, cmd status 000a, ctl 0512 interrupt 240000.
Apr 17 09:38:19 olibox kernel: NETDEV WATCHDOG: eth0: transmit timed out
Apr 17 09:38:19 olibox kernel: eth0: Transmit timeout using MII device, Tx status 000b.
Apr 17 09:38:19 olibox kernel: eth0: Restarting the EPIC chip, Rx 1/1 Tx 8/17.
Apr 17 09:38:19 olibox kernel: eth0: epic_restart() done, cmd status 000a, ctl 0512 interrupt 240000.
Apr 17 09:38:23 olibox kernel: NETDEV WATCHDOG: eth0: transmit timed out
Apr 17 09:38:23 olibox kernel: eth0: Transmit timeout using MII device, Tx status 000b.
Apr 17 09:38:23 olibox kernel: eth0: Restarting the EPIC chip, Rx 1/1 Tx 9/17.
Apr 17 09:38:23 olibox kernel: eth0: epic_restart() done, cmd status 000a, ctl 0512 interrupt 240000.
Apr 17 09:38:27 olibox kernel: NETDEV WATCHDOG: eth0: transmit timed out
Apr 17 09:38:27 olibox kernel: eth0: Transmit timeout using MII device, Tx status 000b.
Apr 17 09:38:27 olibox kernel: eth0: Restarting the EPIC chip, Rx 1/1 Tx 10/17.
Apr 17 09:38:27 olibox kernel: eth0: epic_restart() done, cmd status 000a, ctl 0512 interrupt 240000.
Apr 17 09:38:27 olibox kernel: eth0: Too much work at interrupt, IntrStatus=0x008d0004.
Apr 17 09:38:31 olibox kernel: NETDEV WATCHDOG: eth0: transmit timed out
Apr 17 09:38:31 olibox kernel: eth0: Transmit timeout using MII device, Tx status 000b.
Apr 17 09:38:31 olibox kernel: eth0: Restarting the EPIC chip, Rx 1/1 Tx 11/17.
Apr 17 09:38:31 olibox kernel: eth0: epic_restart() done, cmd status 000a, ctl 0512 interrupt 240000.                                                              

...

olibox:/var/log # cat /proc/interrupts
           CPU0
  0:    2068590          XT-PIC  timer
  1:      51210          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:     355790          XT-PIC  es1371
  8:          1          XT-PIC  rtc
 10:      95257          XT-PIC  eth0
 12:     625009          XT-PIC  PS/2 Mouse
 13:          1          XT-PIC  fpu
 14:     304339          XT-PIC  ide0
 15:          8          XT-PIC  ide1
NMI:          0                                                                                                                                                    

olibox:/var/log # lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev 06)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Apollo PRO] (rev 07)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
00:07.3 Host bridge: VIA Technologies, Inc.: Unknown device 3050
00:09.0 Ethernet controller: Standard Microsystems Corp [SMC] 83C170QF (rev 06)
00:0b.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
01:00.0 VGA compatible controller: nVidia Corporation Riva TnT2 [NV5] (rev 11)                                                                                     
 
00:09.0 Ethernet controller: Standard Microsystems Corp [SMC] 83C170QF (rev 06)
        Subsystem: Standard Microsystems Corp [SMC] EtherPower II 10/100
        Flags: bus master, fast devsel, latency 32, IRQ 10
        I/O ports at e800
        Memory at e1000000 (32-bit, non-prefetchable)
        Expansion ROM at e0000000 [disabled]
                                                                                                                                                                   

yours, oliver teuber


