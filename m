Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267128AbSKMIIg>; Wed, 13 Nov 2002 03:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267134AbSKMIIg>; Wed, 13 Nov 2002 03:08:36 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:56081 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267128AbSKMIIf>;
	Wed, 13 Nov 2002 03:08:35 -0500
Date: Wed, 13 Nov 2002 00:10:08 -0800
From: Greg KH <greg@kroah.com>
To: Miles Bader <miles@gnu.org>
Cc: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>,
       Matthew Wilcox <willy@debian.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, andmike@us.ibm.com, hch@lst.de,
       linux-kernel@vger.kernel.org, mochel@osdl.org,
       parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device interface
Message-ID: <20021113081008.GC2106@kroah.com>
References: <20021109060342.GA7798@kroah.com> <200211091533.gA9FXuW02017@localhost.localdomain> <20021113061310.GD2106@kroah.com> <buon0odsyh9.fsf@mcspd15.ucom.lsi.nec.co.jp> <20021113075223.GZ2106@kroah.com> <buoisz1sxr4.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buoisz1sxr4.fsf@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 05:02:39PM +0900, Miles Bader wrote:
> Greg KH <greg@kroah.com> writes:
> > > This this would end up [or have the ability to] invoking a bus-specific
> > > routine at some point, right?  [so that a truly PCI-specific definition
> > > could be still be had]
> > 
> > If that was needed, yes, we should not break that functionality.
> > 
> > Are there any existing archs that need more than just dma_mask moved to
> > struct device out of pci_dev?  Hm, ppc might need a bit more...
> 
> I can't speak for `real machines,' but on my wierd embedded board,
> pci_alloc_consistent allocates from a special area of memory (not
> located at 0) that is the only shared memory between PCI devices and the
> CPU.  pci_alloc_consistent happens to fit this situation quite well, but
> I don't think a bitmask is enough to express the situation.

What does your pci_alloc_consistent() function need from the pci_dev
structure in order to do what you need it to do?  Anything other than
the dma_mask value?

thanks,

greg k-h
