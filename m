Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129846AbRAaP0b>; Wed, 31 Jan 2001 10:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129774AbRAaP0V>; Wed, 31 Jan 2001 10:26:21 -0500
Received: from chmls05.mediaone.net ([24.147.1.143]:37872 "EHLO
	chmls05.mediaone.net") by vger.kernel.org with ESMTP
	id <S129846AbRAaP0N>; Wed, 31 Jan 2001 10:26:13 -0500
Date: Wed, 31 Jan 2001 10:26:06 -0500
Message-Id: <200101311526.f0VFQ6430271@mojo.chezrutt.com>
From: John Ruttenberg <rutt@chezrutt.com>
To: jgarzik@mandrakesoft.com, becker@scyld.com
cc: linux-kernel@vger.kernel.org
Subject: Problems with tulip driver with lite-on -- transmit timed out
Reply-to: rutt@chezrutt.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure exactly when this problem was introduced, but I'm pretty sure it
didn't exist in the 2.2.x kernels.  It does exist in the 2.4.0-test12, 2.4.0,
and 2.4.1 kernels.

Any high bandwidth sustained inward transfer seems to hang up the card after a
little while (< 1 minute with ftp, longer with nfs).  Once the card hangs,
the syslog has entries:

    NETDEV WATCHDOG: eth0: transmit timed out

cancelling the inward ftp and restarting the network unwedges the problem.

Here is what's in my /proc/pci for the nic:

    Bus  0, device  12, function  0:
       Ethernet controller: Lite-On Communications Inc LNE100TX (rev 32).
         IRQ 11.

There seems to have been some relevant LKML traffic on the topic, but I
couldn't decipher it in terms of what it means to me.

I'm not subscribed to lkml, so please cc me in replies.

Thanks in advance for any help.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
