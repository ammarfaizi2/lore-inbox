Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbTJTVxe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 17:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbTJTVxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 17:53:34 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:57313 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262834AbTJTVtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 17:49:36 -0400
Date: Mon, 20 Oct 2003 23:49:27 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Francois Romieu <romieu@fr.zoreil.com>, Donald Becker <becker@scyld.com>,
       linux-net@vger.kernel.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.4.22 and SMC EtherPower II 9432
Message-ID: <20031020214927.GV23191@fs.tum.de>
References: <20031020205933.GS23191@fs.tum.de> <20031020233045.A14712@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031020233045.A14712@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 20, 2003 at 11:30:45PM +0200, Francois Romieu wrote:
> Adrian Bunk <bunk@fs.tum.de> :
> [...]
> > on two different machines the ethernet card works with kernel 2.2.20 but 
> > not with kernel 2.4.22 (both contain machines contain the same card).
> 
> Could you display the registers with the utility available at
> <URL:ftp://ftp.scyld.com/pub/diag/epic-diag.c> ?

(kernel 2.2.20)

# epic-diag -aa -ee -mm
epic-diag.c:v2.01 1/6/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a SMSC EPIC/100 83c170 adapter at 0xb000.
The EPIC/100 chip appears to be active, so some registers will not be 
read.
To see all register values use the '-f' flag.
EPIC chip registers at 0xb000
 0x000: 00000008 00240000 000013bf 00000712 00004831 00000061 00000000 00000000
 0x020: 00000000 00000000 00000000 00007589 00000610 0000782d 00003816 00003c60
 0x040: 0000e000 00003d29 00006fe4 00006700 0000ffff 0000ffff 0000ffff 0000ffff
 0x060: 0000000c ******** ******** ******** 00003c7f 00002003 ******** ********
 0x080: ******** 0048b810 ******** ******** ******** ******** ******** ********
 0x0A0: ******** 005a0801 ******** ******** 005a0bfd ******** ******** ********
 0x0C0: ******** 0048baa0 ******** ******** ******** ******** ******** 0048b900
 0x0E0: ******** ******** ******** ******** ******** ******** ******** ********
 No interrupt sources are pending.
 Rx state is 'Running', Tx state is 'Idle'.
  Transmitter: slot time 512 bits, full-duplex mode.
  Last transmit OK, 0 collisions.
  Receiver control is 000c, multicast mode.
  The last Rx frame was 90 bytes, status 1.
EEPROM contents (size: 64x16):
  e000 3d29 6fe4 6700 0001 1c08 10b8 a014
  0000 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  0010 0000 1980 2100 0000 0000 0003 0000
  0701 0000 0000 0000 4d53 3943 3334 5432
  2058 2020 0000 0000 0280 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
 The word-wide EEPROM checksum is 0x536a.
Parsing the EEPROM of a EPIC/100:
 Station Address 00:E0:29:3D:E4:6F.
 Board name 'SMC9432TX   ', revision 0.
  Calculated checksum is 00, correct.
 Subsystem ID Vendor/Device 10b8/a014.
 MII PHY found at address 3.
 MII PHY #3 transceiver registers:
   3000 782d 0181 4401 01e1 45e1 0001 ffff
   ffff ffff ffff ffff ffff ffff ffff ffff
   0040 0018 ffff ffff ffff ffff ffff ffff
   ffff ffff ffff 003e ffff 0048 0000 1dd8.
 MII PHY #3 transceiver registers:
   3000 782d 0181 4401 01e1 45e1 0001 ffff
   ffff ffff ffff ffff ffff ffff ffff ffff
   0040 0018 ffff ffff ffff ffff ffff ffff
   ffff ffff ffff 003e ffff 0048 0000 1dd8.
 Basic mode control register 0x3000: Auto-negotiation enabled.
 Basic mode status register 0x782d ... 782d.
   Link status: established.
   Capable of  100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Able to perform Auto-negotiation, negotiation complete.
 Vendor ID is 00:60:51:--:--:--, model 0 rev. 1.
   Vendor/Part: Quality Semiconductor (unknown type).
 I'm advertising 01e1: 100baseTx-FD 100baseTx 10baseT-FD 10baseT
   Advertising no additional info pages.
   IEEE 802.3 CSMA/CD protocol.
 Link partner capability is 45e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Negotiation  completed.
Monitoring the MII transceiver status.
23:44:07.609  Baseline value of MII BMSR (basic mode status register) is 782d.


> Ueimor

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

