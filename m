Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267137AbSKMIUB>; Wed, 13 Nov 2002 03:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267139AbSKMIUB>; Wed, 13 Nov 2002 03:20:01 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:31218 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267137AbSKMIUB>; Wed, 13 Nov 2002 03:20:01 -0500
To: Greg KH <greg@kroah.com>
Cc: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>,
       Matthew Wilcox <willy@debian.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, andmike@us.ibm.com, hch@lst.de,
       linux-kernel@vger.kernel.org, mochel@osdl.org,
       parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device interface
References: <20021109060342.GA7798@kroah.com>
	<200211091533.gA9FXuW02017@localhost.localdomain>
	<20021113061310.GD2106@kroah.com>
	<buon0odsyh9.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20021113075223.GZ2106@kroah.com>
	<buoisz1sxr4.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20021113081008.GC2106@kroah.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 13 Nov 2002 17:26:34 +0900
In-Reply-To: <20021113081008.GC2106@kroah.com>
Message-ID: <buoadkdswn9.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:
> > I can't speak for `real machines,' but on my wierd embedded board,
> > pci_alloc_consistent allocates from a special area of memory (not
> > located at 0) that is the only shared memory between PCI devices and the
> > CPU.  pci_alloc_consistent happens to fit this situation quite well, but
> > I don't think a bitmask is enough to express the situation.
> 
> What does your pci_alloc_consistent() function need from the pci_dev
> structure in order to do what you need it to do?  Anything other than
> the dma_mask value?

Currently, it ignores the pci_dev argument entirely (I've never had a
device that needed the mask, so I haven't bothered with it).  It just
allocates a block from the special memory region and returns the result.

-Miles
-- 
自らを空にして、心を開く時、道は開かれる
