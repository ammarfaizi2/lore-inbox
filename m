Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261747AbREQNu0>; Thu, 17 May 2001 09:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261749AbREQNuQ>; Thu, 17 May 2001 09:50:16 -0400
Received: from web13307.mail.yahoo.com ([216.136.175.43]:61198 "HELO
	web13307.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261747AbREQNuH>; Thu, 17 May 2001 09:50:07 -0400
Message-ID: <20010517135006.879.qmail@web13307.mail.yahoo.com>
Date: Thu, 17 May 2001 06:50:05 -0700 (PDT)
From: Michael Reed <michaelreed@yahoo.com>
Subject: com20020-pci IRQ problem
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a Contemporary Controls PCI20 card and am trying to use the latest
arcnet drivers under Mandrake 8.0 with a 2.4.4 kernel.  

I do the following:
insmod arcnet
insmod arc-rawmode
insmod com20020

which all load just fine.  However, when I do:

insmod com20020-pci

I get the following errors:
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters

In syslog I get:

May 17 09:39:08 collector kernel: arcnet: COM20020 PCI support
May 17 09:39:08 collector kernel: PCI: Found IRQ 10 for device 00:04.0


/proc/pci reports the following for the PCI20:

Bus  0, device   5, function  0:
   Network controller: Contemporary Controls CCSI PCI20-CXB ARCnet (rev
1).
     IRQ 10.
     Non-prefetchable 32 bit memory at 0x41000000 [0x4100007f].
     I/O at 0x2080 [0x20ff].
     I/O at 0x2400 [0x240f].

/proc/ioports reports for the PCI20:

2080-20ff : Contemporary Controls CCSI PCI20-CXB ARCnet
2400-240f : Contemporary Controls CCSI PCI20-CXB ARCnet
  2400-2408 : arcnet (COM20020)

/proc/interrupts registers nothing for 10 (but I assume this is normal because
the driver never correctly loads?)

I would appreciate any help in getting this module loaded.   There are no  irq
conflicts for IRQ 10, and I tried putting the card in different slots and on
other IRQs to no avail.

Thanks,
Mike

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
