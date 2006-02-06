Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWBFQoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWBFQoz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 11:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWBFQoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 11:44:55 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17617 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932206AbWBFQoy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 11:44:54 -0500
Subject: libATA  PATA status report, new patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 06 Feb 2006 16:46:52 +0000
Message-Id: <1139244412.10437.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Main changes this time
- Initial driver code for PCMCIA
- Initial driver code for ISAPnP
- Legacy support including VLB driver bits (mostly to test non PCI
cases)
- Replace IRQ masking awareness in core with a ->data_xfer method
- Use ->data_xfer to move IRQ masking, VLB sync and other chip 
  whackiness back *outside* of the core libata code.
- Simplex DMA is now supported
- Remove PCI quirk junk for IDE stuff (its buggy in places and a mess)
- Teach core PCI code about the IDE legacy mess in the PCI spec
- Merge with other libata changes to 2.6.16-rc2
- ARTOP driver now knows how to init Macintosh cards
- Initial netcell driver bits
- CMD64x support (except 640)
- Initial incomplete Cypress Alpha IDE


With the exception of HPA and serialize support its now pretty close to
a straight replacement for drivers/ide on x86 systems (and boxes using
PCI devices only). There is other stuff that wants improving still like
error recovery on CRC, but its getting close.

Please remember that functionality equivalence, and much cleaner code
doesn't mean less bugs yet, there is a *lot* of testing and hammering on
the code needed before it is production ready for switching.

	http://zeniv.linux.org.uk/~alan/IDE

for 2.6.16-rc2 patches.

Alan


