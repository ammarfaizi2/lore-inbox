Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132067AbRAaTMG>; Wed, 31 Jan 2001 14:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132063AbRAaTL4>; Wed, 31 Jan 2001 14:11:56 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:27147 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S130881AbRAaTLk>; Wed, 31 Jan 2001 14:11:40 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDFC0@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Martin Diehl'" <mdiehlcs@compuserve.de>,
        Robert Siemer <siemer@panorama.hadiko.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: RE: PCI IRQ routing problem in 2.4.0 (updated patch)
Date: Wed, 31 Jan 2001 11:11:09 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Martin Diehl [mailto:mdiehlcs@compuserve.de]
...
> Linus' patch helps you, because it makes us trusting the 
> device's config
> space over the routing table. Probably a good idea as long as BIOS'es
> wouldn't start to set wrong values in config space too...
...
> in fact vanilla 2.4.0 did believe what the bios states, 
> namely the broken
> routing table. It didn't believe however what the devices config space
> reports - which turned out to be correct.

The PIRQ (PCI IRQ Routing table) is a Windows 95/98 convention
(requirement).  It isn't used by NT or Windows 2000.
IOW, Linux needs to be well-prepared for handling interrupt
routing in the absence of the PIRQ table.
[http://www.microsoft.com/HWDEV/busbios/PCIIRQ.htm]

~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
