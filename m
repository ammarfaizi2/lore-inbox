Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287488AbSAEEOn>; Fri, 4 Jan 2002 23:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287502AbSAEEOd>; Fri, 4 Jan 2002 23:14:33 -0500
Received: from mx3.sac.fedex.com ([199.81.208.11]:54539 "EHLO
	mx3.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S287494AbSAEEO1>; Fri, 4 Jan 2002 23:14:27 -0500
Date: Sat, 5 Jan 2002 12:14:19 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Chua <jchua@fedex.com>
Subject: eepro100 slow after reboot
Message-ID: <Pine.LNX.4.43.0201051205410.14260-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/05/2002
 12:14:23 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/05/2002
 12:14:25 PM,
	Serialize complete at 01/05/2002 12:14:25 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linux 2.4.x to 2.4.18pre1 on both HP LH6000r and LH4r has the same
problem with the eepro100. Network (rcp) became very slow after warn
reboot.

I've tried both with "modprobe eepro100" (10BT) and "modprobe eepro100
options=0x30" (100BT) and each time after a warm reboot, the network came
to a crawl. The only way is to cold reset by power off/on the system.

Here's the card ("modprobe eepro100 options=0x30") ...

eth0: OEM i82557/i82558 10/100 Ethernet, 00:30:6E:01:A8:8D, IRQ 18.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 506495-096, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  Forcing 100Mbs full-duplex operation.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.


Thanks,
Jeff
[ jchua@fedex.com ]

