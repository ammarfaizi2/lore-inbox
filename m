Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTGATa5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 15:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTGATa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 15:30:57 -0400
Received: from pa90.banino.sdi.tpnet.pl ([213.76.211.90]:1540 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP id S263354AbTGATa4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 15:30:56 -0400
Date: Tue, 1 Jul 2003 21:45:15 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21 IDE problems (lost interrupt, bad DMA status)
Message-ID: <20030701194515.GA1336@alf.amelek.gda.pl>
References: <20030630221542.GA17416@alf.amelek.gda.pl> <1057011399.17567.50.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057011399.17567.50.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 11:16:40PM +0100, Alan Cox wrote:
> On Llu, 2003-06-30 at 23:15, Marek Michalkiewicz wrote:
> > 
> > hda: dma_timer_expiry: dma status == 0x24
> > hda: lost interrupt
> > hda: dma_intr: bad DMA status (dma_stat=30)
> > hda: dma_intr: status=0x50 { DriveReady SeekComplete }
> 
> Does it happen if you disable local apic support ?

It seems that booting with "noapic" fixes it, or at least now it
is much more difficult to trigger.  Still testing...

Before upgrading to 2.4.21, I've been running 2.4.20 with APIC
enabled for a few months, and there were no such IDE errors.

BTW, "noapic" fixes the "power button not working if ACPI is alone
on its own IRQ" problem (present in both 2.4.20 and 2.4.21) too.

Thanks,
Marek

