Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276600AbRJKRqR>; Thu, 11 Oct 2001 13:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276633AbRJKRqD>; Thu, 11 Oct 2001 13:46:03 -0400
Received: from techmonkeys.org ([24.72.12.135]:21694 "EHLO techmonkeys.org")
	by vger.kernel.org with ESMTP id <S276600AbRJKRpO>;
	Thu, 11 Oct 2001 13:45:14 -0400
Date: Thu, 11 Oct 2001 11:42:08 -0600
From: "Matthew S. Hallacy" <poptix@techmonkeys.org>
To: linux-kernel@vger.kernel.org
Subject: Re: eepro100.c bug on 10Mbit half duplex (kernels 2.4.5 / 2.4.10 / 2.4.11pre6 / 2.4.11 / 2.4.10ac11)
Message-ID: <20011011114208.N11846@techmonkeys.org>
In-Reply-To: <002001c15250$6fad3c50$020da8c0@nitemare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <002001c15250$6fad3c50$020da8c0@nitemare>; from robbert@radium.jvb.tudelft.nl on Thu, Oct 11, 2001 at 02:29:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 02:29:56PM +0200, Robbert Kouprie wrote:
> Hi all,
> 
> I can confirm that the known bug in the Intel EtherExpress Pro/100
> adapter is still not worked around in recent kernels. The bug only
> manifests itself when the card is operating on 10 Mbit half duplex. On
> 100 Mbit there are no problems. The problem is that after the device
> received certain amount of traffic (between 80 and 130 Mb in my tests)
> the device will lockup on new connections. Processes start to hang after
> this and logging in is impossible. The only solution is to reset the
> interface (using a previously logged in root session) and reboot the
> system.
[snip]

I currently have the equivalent of 8 of these in my system (Compaq NC3131,
quad ethernet..)

  Bus  2, device   4, function  0:
    Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 5).
                                           ^^^^
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
      Prefetchable 32 bit memory at 0xcb7ff000 [0xcb7fffff].
      I/O at 0x7c00 [0x7c1f].
      Non-prefetchable 32 bit memory at 0xcfe00000 [0xcfefffff].

it is the same chip, this particular interface is 10mbit/half duplex, and
all the interfaces transfer 1G+/day (some small files, some larger than 500 megs)
with no problems, I should note this:

eth0: OEM i82557/i82558 10/100 Ethernet, DE:AD:BA:BE:CA:FE, IRQ 10.
  Receiver lock-up bug exists -- enabling work-around.
  ^^^^^^^^^^^^^^^^^^^^
  Board assembly 009542-001, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
eth1: OEM i82557/i82558 10/100 Ethernet, DE:AD:BE:EF:CA:FE, IRQ 10.
  Receiver lock-up bug exists -- enabling work-around.
  ^^^^^^^^^^^^^^^^^^^^
  Board assembly 009542-001, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

etc etc, for every interface.

I'm up to 2.4.10, it's worked fine on 2.4.2, 2.4.4, 2.4.5-8, and 2.4.10 so far.
(I didn't use the kernels not mentioned)


			Good luck.
			-poptix
