Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbUCKVcp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 16:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbUCKVcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 16:32:45 -0500
Received: from main.gmane.org ([80.91.224.249]:9872 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261741AbUCKVci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 16:32:38 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Unable to set reading speed with newer DVD -reader.
Date: Thu, 11 Mar 2004 21:32:33 +0000 (UTC)
Message-ID: <slrnc51mnh.s2s.psavo@varg.dyndns.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a11a.mannikko1.ton.tut.fi
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
There is a problem with setting DVD reading speed. 
I found a thread[1] dealing with this, but there is only a scarse mention
about SET_STREAMING in <linux/cdrom.h>.

[1] http://groups.google.com/groups?threadm=20010627194127.H17905%40suse.de

Thanks.
- -
# uname -a
Linux tienel 2.6.4-rc1-mm2 #1 SMP Fri Mar 5 18:22:38 EET 2004 i686 GNU/Linux
- -
# # Without DVD-Video -disk in reader
# hdparm -E 4 /dev/dvd

/dev/dvd:
setting cdrom speed to 4

- -
# # With DVD-Video -disk in reader.
# hdparm -E 4 /dev/dvd

/dev/dvd:
setting cdrom speed to 4
 CDROM_SELECT_SPEED failed: Input/output error
- -
# tail /var/log/messages
...
Mar 11 23:11:07 tienel kernel: hdb: packet command error: status=0x51 { DriveReady SeekComplete Error }
Mar 11 23:11:07 tienel kernel: hdb: packet command error: error=0x54
Mar 11 23:11:07 tienel kernel: ATAPI device hdb:
Mar 11 23:11:07 tienel kernel:   Error: Illegal request -- (Sense key=0x05)
Mar 11 23:11:07 tienel kernel:   Invalid field in command packet -- (asc=0x24, ascq=0x00)
Mar 11 23:11:07 tienel kernel:   The failed "Set Speed" packet command was: 
Mar 11 23:11:07 tienel kernel:   "bb 00 02 c4 00 00 00 00 00 00 00 00 00 00 00 00 "
- -
# hdparm -I /dev/dvd

/dev/dvd:

ATAPI CD-ROM, with removable media
        Model Number:       SAMSUNG DVD-ROM SD-616E                 
        Serial Number:      
        Firmware Revision:  F502    
Standards:
        Used: ATAPI for CD-ROMs, SFF-8020i, r2.5
        Supported: CD-ROM ATAPI-2 
Configuration:
        DRQ response: 50us.
        Packet size: 12 bytes
Capabilities:
        LBA, IORDY(can be disabled)
        DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 udma2 (?)
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=120ns  IORDY flow control=120ns
- -


-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

