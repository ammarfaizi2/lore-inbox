Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161572AbWI2RDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161572AbWI2RDv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 13:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161759AbWI2RDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 13:03:48 -0400
Received: from xenotime.net ([66.160.160.81]:43951 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161753AbWI2RDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 13:03:46 -0400
Date: Fri, 29 Sep 2006 10:04:57 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-ide@vger.intel.com,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [patch 1/2] libata: _GTF support
Message-Id: <20060929100457.eaf0425e.rdunlap@xenotime.net>
In-Reply-To: <20060929095409.3656d7a9.kristen.c.accardi@intel.com>
References: <20060928182211.076258000@localhost.localdomain>
	<20060928112901.62ee8eba.kristen.c.accardi@intel.com>
	<20060929020707.GA22082@srcf.ucam.org>
	<20060929095409.3656d7a9.kristen.c.accardi@intel.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 09:54:09 -0700 Kristen Carlson Accardi wrote:

> On Fri, 29 Sep 2006 03:07:07 +0100
> Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> 
> > On Thu, Sep 28, 2006 at 11:29:01AM -0700, Kristen Carlson Accardi wrote:
> > 
> > I mentioned this to Randy a while back, but I can't remember what sort 
> > of resolution we came to. In any case:
> > 
> > > + * sata_get_dev_handle - finds acpi_handle and PCI device.function
> > 
> > I'm a bit uncomfortable that we seem to have two quite different ways of 
> > accomplishing much the same thing. On the PCI bus, we have a callback 
> > that gets triggered whenever a new PCI device is attached. At that 
> > point, we look for the associated ACPI object and put a pointer to that 
> > in the device structure. Then, whenever we want to make an ACPI call, we 
> > can simply refer to that.
> > 
> > This implementation seems to reimplement much of the same lookup code, 
> > but makes it libata specific. Wouldn't it be cleaner to implement it in 
> > a similar way to PCI? The only real downside is that you need to add a 
> > callback in the ata bus code. drivers/pci/pci-acpi.c/pci_acpi_init is 
> > the sort of thing required.
> > 
> > (Thinking ahead, would that make it easier to maintain links in sysfs 
> > between devices and acpi objects?)
> > 
> > -- 
> > Matthew Garrett | mjg59@srcf.ucam.org
> 
> This makes sense to me.  I'm happy to put together some patches for 
> commenting on if people think this is a good way to go.  It would be
> much cleaner in my opinion and we could get rid of a good chunk of code.

My belated memory of it is that I tried Matthew's suggestion
and it didn't work, but I have confidence in Kristen.  Go for it.

---
~Randy
