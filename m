Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129187AbQKQVal>; Fri, 17 Nov 2000 16:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129199AbQKQVab>; Fri, 17 Nov 2000 16:30:31 -0500
Received: from battlejitney.wdhq.scyld.com ([216.254.93.178]:26609 "EHLO
	vaio.greennet") by vger.kernel.org with ESMTP id <S129187AbQKQVaT>;
	Fri, 17 Nov 2000 16:30:19 -0500
Date: Fri, 17 Nov 2000 16:07:07 -0500 (EST)
From: Donald Becker <becker@scyld.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: duplicate entries in rtl8129 driver
In-Reply-To: <200011172047.MAA03712@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.10.10011171559361.820-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2000, Adam J. Richter wrote:

> 	Both linux-2.4.0-test12-pre6/drivers/net/rtl8129.c and
> Don Becker's version at ftp.sycld.com appear to have identical
> PCI device ID and vendor ID values for these two cards:
> 
> 		SMC1211TX EZCard 10/100 (RealTek RTL8139)
> 		Accton MPX5030 (RealTek RTL8139)
> 
> 	So, I do not see how the latter entry in pci_tbl is ever
> matched.  I think the result would be that users of either card
> will be told that they have an SMC1211TX EZCard 10/100.  I suggest
> deleting the latter entry and combine its label into the previous
> one, so it will be described as:
> 
> 	SMC1211TX EZCard 10/100 or Accton MPX5030 (RealTek RTL8139)

They are distinguished by the PCI subsystem ID, which was truncated from the
list.

Note that Accton is really SMC.  They purchased part of SMC several years
ago, including the brand name.  The chip part of the old SMC is now named
SMsC, and they still make the EPIC Ethernet chip.

I do have a long list of subsystem IDs, but using multiple names for a
one-chip board with no design options is just confusing.  (Vs. the 21143
chip, which has at least 70 different driver-visible board design
variations.)

Bottom line: Yes, it's redundant.  But there was a reason.

Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
