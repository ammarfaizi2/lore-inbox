Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281478AbRLNXTl>; Fri, 14 Dec 2001 18:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281217AbRLNXTW>; Fri, 14 Dec 2001 18:19:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3333 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S280817AbRLNXTS>;
	Fri, 14 Dec 2001 18:19:18 -0500
Message-ID: <3C1A88F3.CE62FB23@mandrakesoft.com>
Date: Fri, 14 Dec 2001 18:19:15 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: kaos@ocs.com.au, Linux-Kernel list <linux-kernel@vger.kernel.org>,
        quintela@mandrakesoft.com
Subject: Re: modules.pcimap and 8139's
In-Reply-To: <3C1A7CA1.D6C119DC@mandrakesoft.com> <20011214151034.A16902@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> 
> On Fri, Dec 14, 2001 at 05:26:41PM -0500, Jeff Garzik wrote:
> > Various tools need to pick "8139cp.c" instead of "8139too.c" based on
> > PCI revision, which is not in modules.pcimap nor struct pci-device-id.
> > grep for 'pci_rev' in both those files to see the PCI revision checks
> > hand-coded currently in the drivers.
> >
> > What is the preferred -2.4- solution?
> >
> > a) append pci rev and mask to the end of each modules.pcimap line, and
> > update struct pci_device_id?
> > b) create new file modules.pci_rev?
> > c) other?
> 
> d) ignore it :)
> 
> linux-hotplug should try to run modprobe on every module that matches in
> the modules.pcimap table.  That way the modules can fight it out for who
> really wants to control the device (I am assuming that the different
> modules know about the pci revision, right?)
> 
> modules.pcimap is used to narrow the choices, not necessarily pick the
> "only" choice.

that's ok with me...  8139cp should come first and then error out.  Then
(I hope!) 8139too is tried.  If that works, all is cool.

But quintela was having a problem with this very thing not working for
him...

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
