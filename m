Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135860AbRDTLJo>; Fri, 20 Apr 2001 07:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135861AbRDTLJf>; Fri, 20 Apr 2001 07:09:35 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:51973 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S135860AbRDTLJZ> convert rfc822-to-8bit; Fri, 20 Apr 2001 07:09:25 -0400
From: s-jaschke@t-online.de (Stefan Jaschke)
Reply-To: stefan@jaschke-net.de
Organization: jaschke-net.de
To: Oliver Teuber <teuber@core.devicen.de>
Subject: Re: epic100 error
Date: Fri, 20 Apr 2001 13:09:15 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, epic@skyld.com
In-Reply-To: <20010417184552.A6727@core.devicen.de>
In-Reply-To: <20010417184552.A6727@core.devicen.de>
MIME-Version: 1.0
Message-Id: <01042013091501.07156@antares>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
it seems the epic100 driver broke between 2.4.2 and 2.4.3.
I reloaded the epic100 module with the parameter "debug=6".
Unfortunately, I cannot make much out of the log:

Apr 20 12:47:01 antares kernel: epic100.c:v1.11 1/7/2001 Written by Donald Becker <becker@scyld.com>
Apr 20 12:47:01 antares kernel:   http://www.scyld.com/network/epic100.html
Apr 20 12:47:01 antares kernel:  (unofficial 2.4.x kernel port, version 1.1.6, January 11, 2001)
Apr 20 12:47:01 antares kernel: epic100(00:08.0): EEPROM contents
Apr 20 12:47:01 antares kernel:  e000 2829 ec39 aa00 001d 1c08 10b8 a011 0000 0000 0000 0000 0000 0000 0000 0000
Apr 20 12:47:01 antares kernel:  0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
Apr 20 12:47:01 antares kernel:  0010 0000 1980 2100 0000 0000 0003 0000 0701 0000 0000 0000 4d53 3943 3334 5432
Apr 20 12:47:01 antares kernel:  2058 2020 0000 0000 0280 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
Apr 20 12:47:01 antares kernel: epic100(00:08.0): MII transceiver #3 control 3000 status 7809.
Apr 20 12:47:01 antares kernel: epic100(00:08.0): Autonegotiation advertising 01e1 link partner 0001.
Apr 20 12:47:01 antares kernel: eth0: SMSC EPIC/100 83c170 at 0xd800, IRQ 9, 00:e0:29:28:39:ec.
Apr 20 12:48:07 antares kernel: eth0: Setting half-duplex based on MII xcvr 3 register read of 0001.
Apr 20 12:48:07 antares kernel: eth0: epic_open() ioaddr d800 IRQ 9 status 0512 half-duplex.
Apr 20 12:48:10 antares kernel: eth0: Media monitor tick, Tx status 0000000b.
Apr 20 12:48:10 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 240000 RxStatus 1090021.
Apr 20 12:48:10 antares kernel: eth0: Setting full-duplex based on MII #3 link partner capability of 41e1.
Apr 20 12:48:15 antares kernel: eth0: Media monitor tick, Tx status 0000000b.
Apr 20 12:48:15 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 240000 RxStatus 1090021.
Apr 20 12:48:20 antares kernel: eth0: Media monitor tick, Tx status 0000400b.
Apr 20 12:48:20 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 240000 RxStatus 1090021.
Apr 20 12:48:25 antares kernel: eth0: Media monitor tick, Tx status 0000400b.
Apr 20 12:48:25 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 240000 RxStatus 1090021.
Apr 20 12:48:30 antares kernel: eth0: Media monitor tick, Tx status 0000400b.
Apr 20 12:48:30 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 240000 RxStatus 1090021.
Apr 20 12:48:35 antares kernel: eth0: Media monitor tick, Tx status 0000400b.
Apr 20 12:48:35 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 240000 RxStatus 1090021.
Apr 20 12:48:40 antares kernel: eth0: Media monitor tick, Tx status 0000400b.
Apr 20 12:48:40 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 240000 RxStatus 1090021.
Apr 20 12:48:45 antares kernel: eth0: Media monitor tick, Tx status 0000400b.
Apr 20 12:48:45 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 240000 RxStatus 1090021.
Apr 20 12:48:45 antares kernel: eth0: Interrupt, status=0x00250001 new intstat=0x00240000.
Apr 20 12:48:45 antares kernel:  In epic_rx(), entry 0 00601021.
Apr 20 12:48:45 antares kernel:   epic_rx() status was 00601021.
Apr 20 12:48:45 antares kernel: eth0: Interrupt, status=0x00240000 new intstat=0x00240000.
Apr 20 12:48:45 antares kernel: eth0: exiting interrupt, intr_status=0x240000.
Apr 20 12:48:46 antares kernel: eth0: Interrupt, status=0x008d0004 new intstat=0x008c0000.
Apr 20 12:48:46 antares last message repeated 32 times
Apr 20 12:48:46 antares kernel: eth0: Too much work at interrupt, IntrStatus=0x008d0004.
Apr 20 12:48:46 antares kernel: eth0: exiting interrupt, intr_status=0x8d0004.
Apr 20 12:48:50 antares kernel: eth0: Media monitor tick, Tx status 0000400b.
Apr 20 12:48:50 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 8c0000 RxStatus 6014a1.
Apr 20 12:48:55 antares kernel: eth0: Media monitor tick, Tx status 0000400b.
Apr 20 12:48:55 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 8c0000 RxStatus 6014a1.

I also noted that there are substantial differences between the original epic100.c at
http://www.scyld.com/network/epic100.html and the version included with 2.4.3.
Who did these changes?

Stefan J.
-- 
Stefan R. Jaschke <stefan@jaschke-net.de>
http://www.jaschke-net.de
