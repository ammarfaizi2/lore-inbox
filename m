Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270804AbTHAPF5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 11:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275119AbTHAPF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 11:05:57 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:48813 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S270804AbTHAPF4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 11:05:56 -0400
Date: Fri, 1 Aug 2003 17:05:39 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com, Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] Re: Firmware loading problem
Message-ID: <20030801150538.GA9731@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <1058885139.2757.27.camel@pegasus> <20030722145546.GC23593@ranty.pantax.net> <1058888301.2755.8.camel@pegasus> <20030726090458.GA16634@ranty.pantax.net> <20030727192111.GT1485@parcelfarce.linux.theplanet.co.uk> <20030727212134.GA9171@ranty.pantax.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030727212134.GA9171@ranty.pantax.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27, 2003 at 11:21:34PM +0200, Manuel Estrada Sainz wrote:
> On Sun, Jul 27, 2003 at 08:21:11PM +0100, Matthew Wilcox wrote:
> > On Sat, Jul 26, 2003 at 11:04:58AM +0200, Manuel Estrada Sainz wrote:
> > > 	- hopefully adapt drivers/pci/pci-sysfs.c to this changes
> > > 		- Please double check, I didn't look very carefully on
> > > 		  this.
> > 
> > Definitely wrong.  I was going to undo this change since I realised how
> > it doesn't work for you; but the change you made to the PCI code is wrong.
> > It ends up copying everything to offset 0 from the buf address. 
> 
>  Exactly, and that is what sysfs code expects (with the rest of the
>  patch), the buffer is just temporary storage, it doesn't really matter
>  what offset you use as long as you don't write further than
>  buffer+PAGE_SIZE and both sides of the issue agree.

 My fault, I was severely misguided here, Matthew is of course write.
 Now that I understand the issue a little deeper I'll try send a correct
 patch to get the issue done with.

 Have a nice day

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
