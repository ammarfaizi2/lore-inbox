Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267132AbSKMHuv>; Wed, 13 Nov 2002 02:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267133AbSKMHuu>; Wed, 13 Nov 2002 02:50:50 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:50705 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267132AbSKMHuu>;
	Wed, 13 Nov 2002 02:50:50 -0500
Date: Tue, 12 Nov 2002 23:52:23 -0800
From: Greg KH <greg@kroah.com>
To: Miles Bader <miles@gnu.org>
Cc: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>,
       Matthew Wilcox <willy@debian.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, andmike@us.ibm.com, hch@lst.de,
       linux-kernel@vger.kernel.org, mochel@osdl.org,
       parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device interface
Message-ID: <20021113075223.GZ2106@kroah.com>
References: <20021109060342.GA7798@kroah.com> <200211091533.gA9FXuW02017@localhost.localdomain> <20021113061310.GD2106@kroah.com> <buon0odsyh9.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buon0odsyh9.fsf@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 04:46:58PM +0900, Miles Bader wrote:
> Greg KH <greg@kroah.com> writes:
> > What is the real reason for needing this, pci_alloc_consistent()?  We
> > have talked about renaming that to dev_alloc_consistent() in the past,
> > which I think will work for you, right?
> 
> This this would end up [or have the ability to] invoking a bus-specific
> routine at some point, right?  [so that a truly PCI-specific definition
> could be still be had]

If that was needed, yes, we should not break that functionality.

Are there any existing archs that need more than just dma_mask moved to
struct device out of pci_dev?  Hm, ppc might need a bit more...

thanks,

greg k-h
