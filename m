Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267141AbSKMH4A>; Wed, 13 Nov 2002 02:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267142AbSKMH4A>; Wed, 13 Nov 2002 02:56:00 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:7049 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267141AbSKMHz7>; Wed, 13 Nov 2002 02:55:59 -0500
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
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 13 Nov 2002 17:02:39 +0900
In-Reply-To: <20021113075223.GZ2106@kroah.com>
Message-ID: <buoisz1sxr4.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:
> > This this would end up [or have the ability to] invoking a bus-specific
> > routine at some point, right?  [so that a truly PCI-specific definition
> > could be still be had]
> 
> If that was needed, yes, we should not break that functionality.
> 
> Are there any existing archs that need more than just dma_mask moved to
> struct device out of pci_dev?  Hm, ppc might need a bit more...

I can't speak for `real machines,' but on my wierd embedded board,
pci_alloc_consistent allocates from a special area of memory (not
located at 0) that is the only shared memory between PCI devices and the
CPU.  pci_alloc_consistent happens to fit this situation quite well, but
I don't think a bitmask is enough to express the situation.

-Miles
-- 
Ich bin ein Virus. Mach' mit und kopiere mich in Deine .signature.
