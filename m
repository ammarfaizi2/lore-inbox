Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266661AbUHOMYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266661AbUHOMYa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 08:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUHOMY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 08:24:29 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:60362 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S266663AbUHOMWB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 08:22:01 -0400
Subject: Re: No DMA Since 2.6.8 Upgrade
From: Nicolas BENOIT <nbenoit@tuxfamily.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1092572509.385.9.camel@brioche.gwened>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 15 Aug 2004 14:21:50 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, so finally, it's not working...

Well it works for the hard drive, but cd drives have to be detected
through the IDE/ATAPI driver.
And I still can't change the DMA settings for them...


If I don't enable IDE/ATAPI support, I get this:

ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xFC08 irq 15
ata2: dev 0 cfg 49:0f00 82:0218 83:4000 84:4000 85:0218 86:0000 87:4000
88:041f
ata2: dev 0 ATAPI, max UDMA/66
ata2: dev 1 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000
88:0407
ata2: dev 1 ATAPI, max UDMA/33
ata2: dev 0 configured for UDMA/33
ata2: dev 1 configured for UDMA/33
scsi1 : ata_piix

And the drives aren't attached to any /dev/*** (even if I enable scsi
cdrom)


So on the one hand, I have my cd drives with hd* and using IDE/ATAPI
drivers and I can't change the DMA settings; and on the other hand, I
have two devices detected at boot time but not attached (so unusable).

Nicolas.

-- 
+-----------------------------------+
| Nicolas BENOIT                    |
| http://nbenoit.tuxfamily.org      |
|                                   |
|   .~.                             |
|   /V\          Gnu - Linux        |
|  // \\   http://www.slackware.com |
| /(   )\                           |
|  ^^-^^                            |
+-----------------------------------+

