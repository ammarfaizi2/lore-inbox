Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267363AbSLNC5K>; Fri, 13 Dec 2002 21:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267393AbSLNC5K>; Fri, 13 Dec 2002 21:57:10 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:52944
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267363AbSLNC5I>; Fri, 13 Dec 2002 21:57:08 -0500
Subject: Re: 2.5.5[01]]: Xircom Cardbus broken (PCI resource collisions)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, Valdis.Kletnieks@vt.edu,
       Petr Konecny <pekon@informatics.muni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DFA2F19.3000004@pobox.com>
References: <200212131345.gBDDjw27002677@turing-police.cc.vt.edu>
	<200212131633.gBDGX0617899@anxur.fi.muni.cz>
	<200212131718.gBDHIw27008173@turing-police.cc.vt.edu>
	<20021213173656.GC1633@suse.de>  <3DFA2F19.3000004@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Dec 2002 03:43:19 +0000
Message-Id: <1039837399.25286.117.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-13 at 19:03, Jeff Garzik wrote:
> Dave Jones wrote:
> > It's my understanding that pci_enable_device() *must* be called
> > before we fiddle with dev->resource, dev->irq and the like.
> 
> 
> True and correct, but -- this particular case is inside the cardbus 
> core, where it presumeably might have a better idea of when it is best 
> to call pci_enable_device (or perhaps even not at all, and twiddle the 
> bits itself).

We can use enable_device_bars() to skip the ROM but do the rest, then
fix the ROM up 8)

