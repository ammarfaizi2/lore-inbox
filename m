Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268824AbRHFP6U>; Mon, 6 Aug 2001 11:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268823AbRHFP6I>; Mon, 6 Aug 2001 11:58:08 -0400
Received: from out1.prserv.net ([32.97.166.31]:32453 "EHLO prserv.net")
	by vger.kernel.org with ESMTP id <S268788AbRHFP55>;
	Mon, 6 Aug 2001 11:57:57 -0400
MIME-Version: 1.0
Message-Id: <3B6EBE89.000001.32428@be1.prserv.net>
Date: Mon, 6 Aug 2001 15:58:01 +0000 (CUT)
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_POLNQL80000000000000"
From: isnkrnl@attglobal.net
To: linux-kernel@vger.kernel.org
Subject: Problems with Natsemi.c (Netgear FA311) and Alpha?
X-Mailer: Web Mail v2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_POLNQL80000000000000
Content-Type: Text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

I just added an FA311 to my SX164 (kernel 2.4.7)
and there is a bug in it.  I plugged the ethernet
into a 64bit slot, which is okay as far as I can
tell, it seems to be recognized by the PCI
controller and I can get information about the PCI
device.  When I load the driver it panics during
the eepro_read();

Further investigation shows that it reads ioaddr
from the PCI registers and then it does an ioremap
of if it the address as reported by PCI is
something like 0x09978470 (give or take a few
bytes, I'm at work and forget the exact address) 
ioremap returns that same address instead of the
standard 0xfffffffc09978470 like my tulip card
uses...  Any ideas?  Does alpha use a different
ioremapper or something?  There is a slight chance
that it could be the hardware, I've seen a couple
IDE abnormalities but but other than that the
system has been a rock with mega-long uptime until
Saturday when I started mucking with it.

thanks,
Ian
--------------Boundary-00=_POLNQL80000000000000--
