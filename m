Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129718AbRAXV70>; Wed, 24 Jan 2001 16:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132894AbRAXV7R>; Wed, 24 Jan 2001 16:59:17 -0500
Received: from web11602.mail.yahoo.com ([216.136.172.54]:8455 "HELO
	web11602.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129718AbRAXV7G>; Wed, 24 Jan 2001 16:59:06 -0500
Message-ID: <20010124215905.19584.qmail@web11602.mail.yahoo.com>
Date: Wed, 24 Jan 2001 13:59:05 -0800 (PST)
From: Tom <freyason@yahoo.com>
Subject: eepro100 problems with embedded Intel PRO/100 VM NIC
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The eepro100 driver appears to have timeout problems with the
Intel PRO/100 VM network card. I have such a card embedded in
my work machine.

The NIC has a 82562-equivalent controller chip. 
The eepro100 driver does correctly initialize the network card and
network traffic does work for a time until I start receiving the
following messages:


Jan 24 14:53:08 morpheus kernel: eepro100: wait_for_cmd_done timeout!
Jan 24 14:53:42 morpheus last message repeated 12 times
Jan 24 14:53:53 morpheus last message repeated 5 times
Jan 24 14:53:55 morpheus kernel: mtrr: 0x44000000,0x2000000 overlaps
existing 0x44000000,0x400000
Jan 24 14:54:29 morpheus kernel: eepro100: wait_for_cmd_done timeout!
Jan 24 14:54:46 morpheus last message repeated 7 times

/proc/pci reports the NIC as such:

  Bus  2, device   8, function  0:
    Ethernet controller: Intel Unknown device (rev 1).
      Vendor id=8086. Device id=2449.
      Medium devsel.  Fast back-to-back capable.  IRQ 10.  Master
Capable.  Late
ncy=66.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0x40100000 [0x40100000].
      I/O at 0x1400 [0x1401].

What is strange is the mtrr error. I do run X with /dev/agpgart without
any problems, but network will stop working after a while.

Intel had released the drivers for the Intel PRO/100 VM card for 2.2
series kernel, but I would really rather run 2.4 to take adcvantage of
all the new hardware support.

If you need more information or wish to reply back, please reply to my
e-mail address rather than the list.

Thanks!

Tom

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - Buy the things you want at great prices. 
http://auctions.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
