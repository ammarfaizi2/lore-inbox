Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266130AbUBJSNZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUBJRyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:54:17 -0500
Received: from chaos.sr.unh.edu ([132.177.249.105]:47490 "EHLO
	chaos.sr.unh.edu") by vger.kernel.org with ESMTP id S266040AbUBJRDO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:03:14 -0500
Date: Tue, 10 Feb 2004 12:03:02 -0500 (EST)
From: Kai Germaschewski <kai.germaschewski@unh.edu>
X-X-Sender: kai@chaos.sr.unh.edu
To: Greg KH <greg@kroah.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, <kkeil@suse.de>,
       <isdn4linux@listserv.isdn4linux.de>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <20040210164612.GB27221@kroah.com>
Message-ID: <Pine.LNX.4.44.0402101200140.20690-100000@chaos.sr.unh.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004, Greg KH wrote:

> > | drivers/isdn/hardware/avm/b1isa.c: In function `b1isa_init':
> > | drivers/isdn/hardware/avm/b1isa.c:183: structure has no member named `irq_resource'
> 
> Ick, I don't really think we want users trying to override the irq
> number of their pci cards...

Well, in fact these are actually ISA cards, so nothing wrong with the user 
specifying the interrupts. This dates back to before the driver model, we 
were abusing struct pci_dev as a more general struct device to streamline 
support of PCI and ISA cards within the same code.

--Kai

