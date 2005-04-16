Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVDPCjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVDPCjP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 22:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262583AbVDPCjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 22:39:14 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45836 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261661AbVDPCix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 22:38:53 -0400
Date: Sat, 16 Apr 2005 04:38:52 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: Andrew Morton <akpm@osdl.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       acpi-devel@lists.sourceforge.ne
Subject: Re: [2.6 patch] drivers/serial/8250_acpi.c: fix a warning
Message-ID: <20050416023852.GI4831@stusta.de>
References: <20050415151053.GM5456@stusta.de> <E1DMTPC-000ASo-00.adobriyan-mail-ru@f13.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DMTPC-000ASo-00.adobriyan-mail-ru@f13.mail.ru>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 08:10:54PM +0400, Alexey Dobriyan wrote:
> On Fri, 15 Apr 2005 17:10:53 +0200, Adrian Bunk wrote:
> 
> > This patch fixes the following warning:
> 
> >   CC      drivers/serial/8250_acpi.o
> > drivers/serial/8250_acpi.c: In function `acpi_serial_ext_irq':
> > drivers/serial/8250_acpi.c:51: warning: implicit declaration of function `acpi_register_gsi'
> 
> > --- linux-2.6.12-rc2-mm1-full/drivers/serial/8250_acpi.c.old
> > +++ linux-2.6.12-rc2-mm1-full/drivers/serial/8250_acpi.c
> 
> > +#include <linux/config.h>
> 
> drivers/serial/8250_acpi.c doesn't use CONFIG_ symbols.

8250_acpi.c #include's <acpi/acpi_bus.h> which requires config.h .

In the Linux kernel, it's more common to put such header dependencies 
for header files into the C files, but if the ACPI people agree a patch 
to add the #include <linux/config.h> to acpi_bus.h is the other possble 
correct solution for this issue.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

