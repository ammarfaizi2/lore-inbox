Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263716AbUCVWLx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 17:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263721AbUCVWLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 17:11:53 -0500
Received: from mail005.syd.optusnet.com.au ([211.29.132.54]:31156 "EHLO
	mail005.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263716AbUCVWLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 17:11:46 -0500
Message-Id: <200403222211.i2MMBcu20944@mail005.syd.optusnet.com.au>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)
From: chakkerz_dev@optusnet.com.au
To: Eric Brunner-Williams in Portland Maine <brunner@nic-naa.net>
Cc: linux-kernel@vger.kernel.org
Date: Tue, 23 Mar 2004 09:11:38 +1100
Subject: T21 config wanted, 2.4 or 2.6, both USB mouse and eth0 (3c556
    MiniPCI)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


a T21 is a ThinkPad 21 i take it

now from what i can see here there are a few
t21s out there, with different CPUs in them
but the network card appears to be
consistently 3Com made, which one isn't all
that clear to me here. Just check the cat
/proc/pci and you should get something like this:

 Bus  6, device   0, function  0:
    Ethernet controller: Realtek
Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
(rev 16).
      IRQ 11.
      Master Capable.  Latency=64.  Min
Gnt=32.Max Lat=64.
      I/O at 0x4800 [0x48ff].
      Non-prefetchable 32 bit memory at
0x11000000 [0x110001ff].
(NOTE i've got a realtek PCMCIA card in this
notebook)

So under Device Drivers > Network Support 

You've got "Networking support" and "Network
device support" enabled

go into "Ethernet (10 or 100 MBti)" and
enable support for you card (as determined by
the cat /proc/pci) there is support for 3com
there.

good luck
  Christian Unger / Chakkerz
