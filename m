Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263686AbRFCUaa>; Sun, 3 Jun 2001 16:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263753AbRFCUNh>; Sun, 3 Jun 2001 16:13:37 -0400
Received: from node1357e.a2000.nl ([24.132.53.126]:5380 "HELO
	badaboom.luckyhands.nl") by vger.kernel.org with SMTP
	id <S263746AbRFCTrP>; Sun, 3 Jun 2001 15:47:15 -0400
Date: Sun, 3 Jun 2001 19:46:10 +0200
From: Jasper Jans <jjans@badaboom.luckyhands.nl>
To: linux-kernel@vger.kernel.org
Cc: jjans@badaboom.luckyhands.nl
Subject: Tulip and eepro100 problems
Message-ID: <20010603194610.A1935@badaboom.luckyhands.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

First of all.. please include jjans@badaboom.luckyhands.nl in your
replies since my regular mail account in which I get the list mails
is not functional at the moment.

I've just installed a fresh linux system.
Default Mandrake 8.0 kernel (2.4.3-20mdksmp) and the plain vanilla
2.4.5 kernel both give me this same behaviour.

LNE100TX card in my system gets initialized just fine - however no
matter what I do it will not send any data. Not if I run it via a
10 Mbit hub neither via a cross cable at 100 Mbit.
At the other side there is a LNE100TX card in a Win2k Pro system.

There is an Intel onboard card in this system as well using the
eepro100 driver. This card seems to function fine when used via
the 10 Mbit hub - however once I connect it via a cross cable and
it switches from 10 Mbit half duplex to 100 Mbit full duplex it
stops responding completely as well.

I've seen some emails in the archives about the tulip driver being
broken for some people - however the mails I saw mentioned 2.4.4
and above. I've tried both the 2.4.5 vanilla and the mandrake
2.4.3-20 (both compiled with smp support).

The log file shows:
Jun  3 18:07:50 badaboom kernel: eth0: DC21041 at 0xf480 (PCI bus 0,
device 11), h/w address 00:00:c5:0c:f1:82,
Jun  3 18:07:50 badaboom kernel:       and requires IRQ16 (provided by
PCI BIOS).
Jun  3 18:07:50 badaboom kernel: de4x5.c:V0.546 2001/02/22
davies@maniac.ultranet.com
Jun  3 18:07:50 badaboom kernel: eth0: media is TP.
Jun  3 18:07:50 badaboom kernel: eepro100.c:v1.09j-t 9/29/99 Donald
Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
Jun  3 18:07:50 badaboom kernel: eepro100.c: $Revision: 1.36 $
2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and ot
hers
Jun  3 18:07:50 badaboom kernel: eth1: Intel Corporation 82557 [Ethernet
Pro 100], 00:A0:C9:49:BC:D0, IRQ 18.
Jun  3 18:07:50 badaboom kernel:   Receiver lock-up bug exists --
enabling work-around.
Jun  3 18:07:50 badaboom kernel:   Board assembly 645520-034, Physical
connectors present: RJ45
Jun  3 18:07:50 badaboom kernel:   Primary interface chip DP83840 PHY
#1.
Jun  3 18:07:50 badaboom kernel:   DP83840 specific setup, setting
register 23 to 8462.
Jun  3 18:07:50 badaboom kernel:   General self-test: passed.
Jun  3 18:07:50 badaboom kernel:   Serial sub-system self-test: passed.
Jun  3 18:07:50 badaboom kernel:   Internal registers self-test: passed.
Jun  3 18:07:50 badaboom kernel:   ROM checksum self-test: passed
(0x49caa8d6).
Jun  3 18:07:50 badaboom kernel:   Receiver lock-up workaround
activated.
Jun  3 18:07:50 badaboom kernel: Linux Tulip driver version 0.9.15-pre2
(May 16, 2001)
Jun  3 18:07:50 badaboom kernel: PCI: Unable to reserve I/O region
#1:80@f480 for device 00:0b.0
Jun  3 18:07:50 badaboom kernel: Trying to free nonexistent resource
<ffbee800-ffbee87f>
Jun  3 18:07:50 badaboom kernel: tulip1:  MII transceiver #1 config 3100
status 7809 advertising 01e1.
Jun  3 18:07:50 badaboom kernel: eth2: Lite-On 82c168 PNIC rev 32 at
0xf800, 00:C0:F0:3E:70:57, IRQ 19.

Anyone any ideas on how to get this to work?

Thanks,
Jasper

