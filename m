Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269950AbTG1PPW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 11:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269981AbTG1PPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 11:15:22 -0400
Received: from pop.gmx.net ([213.165.64.20]:64221 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269950AbTG1PPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 11:15:19 -0400
Message-ID: <3F25419B.2050607@gmx.de>
Date: Mon, 28 Jul 2003 17:30:35 +0200
From: Alexander Rau <al.rau@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030715
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew de Quincey <adq_dvb@lidskialf.net>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI patch which fixes all my IRQ problems on nforce2
 -- linux-2.5.75-acpi-irqparams-final4.patch
References: <200307272305.12412.adq_dvb@lidskialf.net>
In-Reply-To: <200307272305.12412.adq_dvb@lidskialf.net>
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew de Quincey wrote:
> This is version final4 of the patch now. Improvement over version final3 is a fix 
> to IRQ allocation.. previously all PCI IRQs were allocated to IRQ11 on my Thinkpad.
> 
> This _may_ break ACPI IRQ routing on the Toshiba 5005-S504  (I hope I have 
> managed to support it though). Can someone check please? Quote from 
> pci_link.c:
>          * Note that we don't validate that the current IRQ (_CRS) exists
>          * within the possible IRQs (_PRS): we blindly assume that whatever
>          * IRQ a boot-enabled Link device is set to is the correct one.
>          * (Required to support systems such as the Toshiba 5005-S504.)
> 
> 

I tried to apply the patch to 2.6.0-test2 in hope that this resolves my 
oops during boottime on my thinkpad t40p.

Unfortunatly the compilation of the kernel fails with:

-----------------------------------------------------------------------------
   CC      drivers/acpi/pci_link.o
drivers/acpi/pci_link.c: In function `acpi_pci_link_allocate':
drivers/acpi/pci_link.c:451: `_dbg' undeclared (first use in this function)
drivers/acpi/pci_link.c:451: (Each undeclared identifier is reported 
only once
drivers/acpi/pci_link.c:451: for each function it appears in.)
make[2]: *** [drivers/acpi/pci_link.o] Error 1
make[1]: *** [drivers/acpi] Error 2
make: *** [drivers] Error 2
-----------------------------------------------------------------------------

Any ideas how to port your patch to the 2.6 series ?



Regards,

  Alexander Rau

