Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbTJAMYS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 08:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbTJAMYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 08:24:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11147 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262076AbTJAMYO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 08:24:14 -0400
Date: Wed, 1 Oct 2003 13:24:12 +0100
From: Matthew Wilcox <willy@debian.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, len.brown@intel.com
Subject: Re: [ACPI] ACPI blacklisting: move year blacklist into acpi/blacklist.c
Message-ID: <20031001122412.GJ24824@parcelfarce.linux.theplanet.co.uk>
References: <20031001101826.GA3503@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001101826.GA3503@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 12:18:26PM +0200, Pavel Machek wrote:
> AFAICS. It also adds some externs to include/linux/acpi.h, but I
> believe *way* more externs are needed. Please apply,

> --- /usr/src/tmp/linux/include/linux/acpi.h	2003-08-27 12:00:48.000000000 +0200
> +++ /usr/src/linux/include/linux/acpi.h	2003-10-01 11:53:51.000000000 +0200
> @@ -403,8 +403,8 @@
>  
>  struct pci_dev;
>  
> -int acpi_pci_irq_enable (struct pci_dev *dev);
> -int acpi_pci_irq_init (void);
> +extern int acpi_pci_irq_enable (struct pci_dev *dev);
> +extern int acpi_pci_irq_init (void);

Why do they need to be externs?  The comp.lang.c FAQ suggests they don't
have to be.

http://www.eskimo.com/~scs/C-faq/q1.11.html

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
