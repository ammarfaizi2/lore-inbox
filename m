Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265554AbRGCHUY>; Tue, 3 Jul 2001 03:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265570AbRGCHUO>; Tue, 3 Jul 2001 03:20:14 -0400
Received: from [216.101.162.242] ([216.101.162.242]:62922 "EHLO
	pizda.ninka.net") by vger.kernel.org with ESMTP id <S265554AbRGCHUI>;
	Tue, 3 Jul 2001 03:20:08 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15169.29154.670946.785981@pizda.ninka.net>
Date: Tue, 3 Jul 2001 00:18:58 -0700 (PDT)
To: mdaljeet@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: virt_to_bus and virt_to_phys on Apple G4 target
In-Reply-To: <CA256A7E.0020F52C.00@d73mta01.au.ibm.com>
In-Reply-To: <CA256A7E.0020F52C.00@d73mta01.au.ibm.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mdaljeet@in.ibm.com writes:
 > I am running linux 2.4.2 on Apple G4 machine. I think the 'PCI bus
 > addresses' and 'physical addresses' are same on this architecture. I
 > expected the two be different but according to asm/io.h 'virt_to_bus(addr)
 > = virt_to_phys(addr) + PCI_DRAM_OFFSET'. I printed the value of
 > 'PCI_DRAM_OFFSET' and that come out to be zero. Is this correct?
 > 
 > If I somehow get the physical address of a user space buffer in a module
 > and take this as a PCI bus address, will I be able to do DMA properly?

virt_to_bus() and bus_to_virt() are deprecated interfaces and should
not be used by anything new.  See Documentation/DMA-mapping.txt for
details.

Later,
David S. Miller
davem@redhat.com
