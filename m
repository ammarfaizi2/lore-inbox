Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318695AbSHAKSE>; Thu, 1 Aug 2002 06:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318696AbSHAKSE>; Thu, 1 Aug 2002 06:18:04 -0400
Received: from tuscan1.lnk.telstra.net ([139.130.53.165]:37900 "EHLO
	ns.ecomrenaissance.com") by vger.kernel.org with ESMTP
	id <S318695AbSHAKSE>; Thu, 1 Aug 2002 06:18:04 -0400
Message-Id: <v03110701b96eb942e5cb@[192.168.0.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 1 Aug 2002 20:21:31 +1000
To: linux-kernel@vger.kernel.org
From: Bruce <bruce@toorak.com>
Subject: 2.4.19-rc5 from 2.4.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem that has manifested itself since 2.4.19-rcx.

An ADSL driver (1483-2.4.16.o) for the DLINK dsl100d PCI ADSL modem
operational under 2.4.18 has been broken since 2.4.19,
specifically under rc3,rc4 and rc5. (Haven't tested rc2 or rc1)

It appears to get/interpret an incorrect hardware address from the card.

There is a constraint. The driver was originally compiled for ITEX/DLINK
under 2.4.16 and I don't have access to the source.

The only known location of this driver is

http://www.nzadsl.co.nz/software/other/Kernel-2.4.16.tar.gz

and it is not strictly a DLINK driver, more a creation for itex.

For reference I use
inmod -f ./1483-2.4.16.o vpi=[8][0] vci=35 framing=1

then

ifconfig eth1 up (yes there is an eth0 card) This fails with the message

SIOCSIFFLAGS: No such device.


Short of rolling back to 2.4.18 which isn't a problem, any advice anyone?

Cheers,
Bruce Stephens.
Melbourne, Australia.


