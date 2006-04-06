Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWDFRjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWDFRjA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 13:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWDFRjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 13:39:00 -0400
Received: from xenotime.net ([66.160.160.81]:14236 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751284AbWDFRi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 13:38:59 -0400
Date: Thu, 6 Apr 2006 10:41:13 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Greg KH <greg@kroah.com>
Cc: anton@samba.org, akpm@osdl.org, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix pciehp driver on non ACPI systems
Message-Id: <20060406104113.08311cdc.rdunlap@xenotime.net>
In-Reply-To: <20060406160527.GA2965@kroah.com>
References: <20060406101731.GA9989@krispykreme>
	<20060406160527.GA2965@kroah.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Apr 2006 09:05:27 -0700 Greg KH wrote:

> On Thu, Apr 06, 2006 at 08:17:31PM +1000, Anton Blanchard wrote:
> > 
> > Wrap some ACPI specific headers. ACPI hasnt taken over the whole world yet.
> > 
> > Signed-off-by: Anton Blanchard <anton@samba.org>
> > ---
> > 
> > Index: kernel/drivers/pci/hotplug/pciehp_hpc.c
> > ===================================================================
> > --- kernel.orig/drivers/pci/hotplug/pciehp_hpc.c	2006-04-06 05:01:32.000000000 -0500
> > +++ kernel/drivers/pci/hotplug/pciehp_hpc.c	2006-04-06 05:09:48.501122395 -0500
> > @@ -38,10 +38,14 @@
> >  
> >  #include "../pci.h"
> >  #include "pciehp.h"
> > +
> > +#ifdef CONFIG_ACPI
> >  #include <acpi/acpi.h>
> >  #include <acpi/acpi_bus.h>
> >  #include <acpi/actypes.h>
> >  #include <linux/pci-acpi.h>
> > +#endif
> 
> Shouldn't the ACPI headers handle it if CONFIG_ACPI is not enabled?  All
> other header files work that way, and we shouldn't have to add this to
> the .c files.

maybe the C file could just #include <linux/acpi.h> ?

---
~Randy
