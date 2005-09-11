Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbVIKBSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVIKBSX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 21:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVIKBSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 21:18:23 -0400
Received: from colo.lackof.org ([198.49.126.79]:14745 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S964803AbVIKBSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 21:18:22 -0400
Date: Sat, 10 Sep 2005 19:24:24 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <matthew@wil.cx>,
       Greg KH <greg@kroah.com>, Jiri Slaby <jirislaby@gmail.com>,
       Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] include: pci_find_device remove (include/asm-i386/ide.h)
Message-ID: <20050911012424.GD25282@colo.lackof.org>
References: <200509102032.j8AKWxMC006246@localhost.localdomain> <4323482E.2090409@pobox.com> <20050910211932.GA13679@kroah.com> <432352A8.3010605@pobox.com> <20050910223333.GF4770@parisc-linux.org> <43236DAE.8000802@pobox.com> <20050911003409.GB25282@colo.lackof.org> <1126400817.30449.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126400817.30449.22.camel@localhost.localdomain>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2005 at 02:06:56AM +0100, Alan Cox wrote:
> On Sad, 2005-09-10 at 18:34 -0600, Grant Grundler wrote:
> > If ide_scan_pcibus() finds any pci device, it calls ide_scan_pcidev().
> > ide_scan_pcidev() only seems to handle PCI devices.
> > Are you saying there are PCI IDE devices out there that
> > don't advertise PCI_CLASS_STORAGE_IDE?
> 
> Lots of them. We also want to know if PCI is present so we can know
> whether to do the IDE tertiary scan which isn't safe on a PCI bus box.

ah ok. I'm not seeing where that happens.

Anyway, pci_present() could be as simple as "(pci_root_buses!=NULL)".

ide_system_bus_speed() in drivers/ide/ide.c might want this too.


BTW, I'm not convinced the current code does *exactly* what you want.
Hypothetically, we can have a PCI bus but no PCI devices.
Maybe no such system exists but I wouldn't bet on it.


thanks,
grant
