Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280995AbRKTS6n>; Tue, 20 Nov 2001 13:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281202AbRKTS6e>; Tue, 20 Nov 2001 13:58:34 -0500
Received: from [194.46.8.33] ([194.46.8.33]:25362 "EHLO angusbay.vnl.com")
	by vger.kernel.org with ESMTP id <S280995AbRKTS6X>;
	Tue, 20 Nov 2001 13:58:23 -0500
Date: Tue, 20 Nov 2001 19:03:16 +0000
From: Dale Amon <amon@vnl.com>
To: linux-kernel@vger.kernel.org
Subject: A return to PCI ordering problems...
Message-ID: <20011120190316.H19738@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I looked back on the thread from last year and thought
that this would be well in hand by now. Either that or
I've missed something obvious or I've got an overly
unfriendly BIOS.

In any case, here is the problem:

	NIC on motherboard, Realtek
	NIC on PCI card, Realtek
	Monolithic (no-module) kernel
	Motherboard must be set to eth0

The PCI search order always makes the PCI card 
eth0.

Tried various command line options:
	ethers=eth1,eth0
	ethers=eth0,eth1
	ether=x1,y1,eth1 ether=x2,y2,eth0
	ether=x1,y1,eth0 ether=x2,y2,eth1
	ether=0,0,eth0 ether=0,0,eth1
	ether=0,0,eth1 ether=0,0,eth0
	pci=reverse

In no case does the ordering get changed by the
command lines; in addtion, the pci=reverse does
not seem to be supported in 2.4.13. I see an 
error message for it in dmesg.

I also played with some of the other pci= options, but 
none of them seem to affect what is going on in a positive 
fashion.

I'm now at the point where I'm wondering if something
in the kernel PCI ordering is just not working quite
right.

-- 
------------------------------------------------------
    Nuke bin Laden:           Dale Amon, CEO/MD
  improve the global          Islandone Society
     gene pool.               www.islandone.org
------------------------------------------------------
