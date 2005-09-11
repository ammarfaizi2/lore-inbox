Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932732AbVIKA2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932732AbVIKA2I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 20:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932731AbVIKA2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 20:28:07 -0400
Received: from colo.lackof.org ([198.49.126.79]:44184 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S932729AbVIKA2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 20:28:06 -0400
Date: Sat, 10 Sep 2005 18:34:09 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>,
       Jiri Slaby <jirislaby@gmail.com>, Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] include: pci_find_device remove (include/asm-i386/ide.h)
Message-ID: <20050911003409.GB25282@colo.lackof.org>
References: <200509102032.j8AKWxMC006246@localhost.localdomain> <4323482E.2090409@pobox.com> <20050910211932.GA13679@kroah.com> <432352A8.3010605@pobox.com> <20050910223333.GF4770@parisc-linux.org> <43236DAE.8000802@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43236DAE.8000802@pobox.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 07:35:10PM -0400, Jeff Garzik wrote:
> >Why not change it to query whether any IDE device is present, perhaps
> >using pci_get_class()?
> 
> Because that's not what the code is attempting to discover.

If ide_scan_pcibus() finds any pci device, it calls ide_scan_pcidev().
ide_scan_pcidev() only seems to handle PCI devices.
Are you saying there are PCI IDE devices out there that
don't advertise PCI_CLASS_STORAGE_IDE?

thanks,
grant
