Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271747AbRIOCBH>; Fri, 14 Sep 2001 22:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271751AbRIOCA5>; Fri, 14 Sep 2001 22:00:57 -0400
Received: from pobox.ati.com ([209.50.91.129]:35993 "EHLO pobox.atitech.ca")
	by vger.kernel.org with ESMTP id <S271747AbRIOCAj>;
	Fri, 14 Sep 2001 22:00:39 -0400
Message-ID: <761E23C7F09AD51188990008C74C26141226@fgl00exh01.atitech.com>
From: "Alexander Stohr" <AlexanderS@ati.com>
To: <DevilKin@gmx.net>, <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Subject: re: AGP Bridge support for AMD 761
Date: Sat, 15 Sep 2001 03:58:59 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Content-Type: text/plain;	charset="iso-8859-1"
X-OriginalArrivalTime: 15 Sep 2001 02:02:00.0671 (UTC) FILETIME=[683D3EF0:01C13D8A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For diagnostics you should check outputs of "lspci -xxx -s 0:0".
(Sent this data to the list here, if you still fail with your attempt.)

First and second byte are the vendor id (AMD = 1022) in low high order.
Third and forth value form the low and the high part of the chips device id.


List of device ids:
  AMD 751 0x7006 (Irongate)
  AMD 761 0x700E (IGD4)
  AMD 762 0x700C

SMP versions not listed here, see 
http://www.yourvote.com/pci/pciread.asp?venid=0x1022 for more device IDs.

Kernel source from 2.4.9 shows up with support for the AMD 751.
Since follow up chips often do not change much, the 
  ===> "agp_try_unsupported=1" <===
option will cause the driver to apply the 751 code onto any other
chipset that has AMD as its vendor, as long as AGP registers 
are found for it. This should do the job for several versions, or 
crash rahter fast if the chipset is no longer compatible.

regards AlexS.

PS: i am not subscribed to this list.
PS2: i might read your answers via http://marc.theaimsgroup.com




