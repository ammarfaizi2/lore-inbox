Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932737AbVIKAsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbVIKAsH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 20:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932738AbVIKAsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 20:48:07 -0400
Received: from mail.dvmed.net ([216.237.124.58]:64662 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932737AbVIKAsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 20:48:06 -0400
Message-ID: <43237EB8.90809@pobox.com>
Date: Sat, 10 Sep 2005 20:47:52 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Grundler <grundler@parisc-linux.org>
CC: Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>,
       Jiri Slaby <jirislaby@gmail.com>, Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] include: pci_find_device remove (include/asm-i386/ide.h)
References: <200509102032.j8AKWxMC006246@localhost.localdomain> <4323482E.2090409@pobox.com> <20050910211932.GA13679@kroah.com> <432352A8.3010605@pobox.com> <20050910223333.GF4770@parisc-linux.org> <43236DAE.8000802@pobox.com> <20050911003409.GB25282@colo.lackof.org>
In-Reply-To: <20050911003409.GB25282@colo.lackof.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
> On Sat, Sep 10, 2005 at 07:35:10PM -0400, Jeff Garzik wrote:
> 
>>>Why not change it to query whether any IDE device is present, perhaps
>>>using pci_get_class()?
>>
>>Because that's not what the code is attempting to discover.
> 
> 
> If ide_scan_pcibus() finds any pci device, it calls ide_scan_pcidev().
> ide_scan_pcidev() only seems to handle PCI devices.
> Are you saying there are PCI IDE devices out there that
> don't advertise PCI_CLASS_STORAGE_IDE?

The code is not searching for PCI devices.  The code is searching for... 
precisely what it is searching for:  presence of PCI in the system.

	Jeff



