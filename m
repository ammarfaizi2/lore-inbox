Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130791AbRCTVQn>; Tue, 20 Mar 2001 16:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130793AbRCTVQc>; Tue, 20 Mar 2001 16:16:32 -0500
Received: from umail.unify.com ([204.163.170.2]:50612 "EHLO umail.unify.com")
	by vger.kernel.org with ESMTP id <S130791AbRCTVQQ>;
	Tue, 20 Mar 2001 16:16:16 -0500
Message-ID: <419E5D46960FD211A2D5006008CAC79902E5C134@pcmailsrv1.sac.unify.com>
From: "Manuel A. McLure" <mmt@unify.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: NETDEV WATCHDOG: eth0: transmit timed out on LNE100TX 4.0, kernel
	 2.4.2-ac11 and earlier.
Date: Tue, 20 Mar 2001 13:14:59 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System:
AMD Athlon Thunderbird 900MHz
MSI K7T Pro (VIA KT133 chipset)
Network card: Linksys LNE100TX Rev. 4.0 (tulip)
Kernel: 2.2.18 (with 0.92 Scyld drivers), 2.4.0, 2.4.1, 2.4.2, 2.4.2-ac11

With all the above kernel revisions/drivers, my network card hangs at random
(sometimes within minutes, other times it takes days). To restart it I need
to do an ifdown/ifup cycle and it will work fine until the next hang. I
upgraded to 2.4.2-ac11 because of the documented tulip fixes, but after a
few days got this again. The error log shows:

Mar 16 18:37:00 ulthar kernel: NETDEV WATCHDOG: eth0: transmit timed out
Mar 16 18:37:00 ulthar kernel: eth0: Transmit timed out, status fc664010,
CSR12
00000000, resetting...

ad infinitum until I do ifdown/ifup. The status & CSR12 values are always
the same. My card is detected as follows by the kernel:

Mar 12 21:38:49 ulthar kernel: Linux Tulip driver version 0.9.14c (March 3,
2001
)
Mar 12 21:38:49 ulthar kernel: PCI: Found IRQ 11 for device 00:0a.0
Mar 12 21:38:49 ulthar kernel: IRQ routing conflict in pirq table for device
00:
07.2
Mar 12 21:38:49 ulthar kernel: IRQ routing conflict in pirq table for device
00:
07.3
Mar 12 21:38:49 ulthar kernel: PCI: The same IRQ used for device 00:0e.0
Mar 12 21:38:49 ulthar kernel: eth0: ADMtek Comet rev 17 at 0xdc00,
00:20:78:0D:
D2:E1, IRQ 11.

Any ideas on why this might be happening? 

--
Manuel A. McLure - Unify Corp. Technical Support <mmt@unify.com>
Space Ghost: "Hey, what happened to the-?" Moltar: "It's out." SG: "What
about-?" M: "It's fixed." SG: "Eh, good. Good."



