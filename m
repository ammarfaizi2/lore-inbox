Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292409AbSB0Nx2>; Wed, 27 Feb 2002 08:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292464AbSB0NxT>; Wed, 27 Feb 2002 08:53:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:43395 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292339AbSB0NxG>;
	Wed, 27 Feb 2002 08:53:06 -0500
Date: Wed, 27 Feb 2002 05:51:02 -0800 (PST)
Message-Id: <20020227.055102.75257130.davem@redhat.com>
To: linux-kernel@vger.kernel.org
CC: jgarzik@mandrakesoft.com, linux-net@vger.kernel.org
Subject: [BETA-0.92] Third test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the usual place:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/TIGON3/tg3-0.92.patch.gz

Three changes of note:

[FEATURE] Yay, real HW acceleration hooks in the 802.1q VLAN layer.
	  Tigon3 takes advantage of it.
[BUG FIX] Let tg3_read_partno fail, some boards do not provide the
          information and it isn't critical to the operation of the
	  driver.
[BUG FIX] Minor bug in ETHTOOL_GREGS length handling.
[CLEANUP] Use netif_carrier_{ok,on,off}() to keep track of link state.

If people with real VLANs can try to get the HW acceleration stuff
working, I'd really appreciate it.  Especially the person who (GASP)
wanted us to put the tasteless NICE stuff into our driver. :-)

Adding support to the Acenic driver should be pretty easy and I'll
try to do that before catching some sleep.  Jeff could also probably
cook up something quick for the e1000.

As previously mentioned, I'm mainly interested in "works/doesn't work"
reports at this point.  And please accompany the:

eth1: Tigon3 [partno(BCM95700A6) rev 7102 PHY(5401)] (PCI:33MHz:64-bit) 10/100/1000BaseT Ethernet 00:04:76:2f:e2:d0

kernel log message with your failure/success reports (and any other
interesting messages our driver prints out :-).

The current goal is to be feature complete and have no probe failures
or known bugs in basic operation by 0.95, then fine tuning and
performance work will be done from 0.96 till 1.0  Sometime after 0.95
occurs I will push the driver to Marcelo and Linus.

Thanks in advance for the testing.
