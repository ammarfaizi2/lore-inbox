Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263913AbUDFQsc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 12:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263914AbUDFQra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 12:47:30 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:58016 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S263895AbUDFQpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 12:45:54 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Ruud Linders <rkmp@xs4all.nl>
Subject: Re: 2.6.x kernels and ttyS45 for 6 serial ports ?
Date: Tue, 6 Apr 2004 10:45:51 -0600
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
References: <200404061037.23867.bjorn.helgaas@hp.com>
In-Reply-To: <200404061037.23867.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404061045.51958.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 April 2004 10:37 am, Bjorn Helgaas wrote:
> > The way this device numbering seems to work is that many device names
> > are reserved in include/asm/serial.h for devices like fourport/boca/hub6.
> > Anything else (=all PCI cards?) gets a number still unassigned.

I forgot to mention another patch along these lines:

    http://www.ussg.iu.edu/hypermail/linux/kernel/0402.1/0904.html

This gives you output like this:

 ttyS0 at MMIO 0xf8030000 (HCDP PCI 0000:e0:01.1, irq = 49) is a 16550A
 ttyS1 at MMIO 0xf8031000 (PCI 0000:e0:01.0, irq = 49) is a 16550A
 ttyS2 at MMIO 0xf8030010 (PCI 0000:e0:01.1, irq = 49) is a 16550A
 ttyS3 at MMIO 0xf8030038 (PCI 0000:e0:01.1, irq = 49) is a 16550A
 ttyS4 at MMIO 0xff5e0000 (ACPI SER0, irq = 67) is a 16550A
 
so you have a clue about what ports are on what cards.  There wasn't
any interest at the time, though.
