Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbTF3WdQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 18:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbTF3WdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 18:33:16 -0400
Received: from w240.z209220232.was-dc.dsl.cnc.net ([209.220.232.240]:38331
	"EHLO yendi.dmeyer.net") by vger.kernel.org with ESMTP
	id S265971AbTF3WdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 18:33:06 -0400
Date: Mon, 30 Jun 2003 18:47:26 -0400
From: dmeyer@dmeyer.net
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 IDE problems (lost interrupt, bad DMA status)
Message-ID: <20030630224726.GA22579@jhereg.dmeyer.net>
Reply-To: dmeyer@dmeyer.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030630221542.GA17416@alf.amelek.gda.pl>
User-Agent: Mutt/1.4.1i
X-Newsgroups: local.linux.kernel
Organization: dmeyer.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030630221542.GA17416@alf.amelek.gda.pl> you write:
> Hi,
> 
> After upgrading the kernel from 2.4.20 to 2.4.21, sometimes I see
> the following messages:
> 
> hda: dma_timer_expiry: dma status == 0x24
> hda: lost interrupt
> hda: dma_intr: bad DMA status (dma_stat=30)
> hda: dma_intr: status=0x50 { DriveReady SeekComplete }
> 
> It happens especially when there is a lot of disk I/O (which stops
> for a few seconds when these messages appear), with three different
> disks (very unlikely they all decided to die at the same time...),
> one old ATA33 (QUANTUM FIREBALL SE8.4A) and two newer ATA100 disks
> (WDC WD300BB-32CCB0, ST340015A).  IDE controller: VIA VT82C686B
> on a MSI MS-6368L motherboard.
> 
> I don't remember seeing anything like that in any earlier 2.4.x
> kernels.  Is this a known problem?  Is this anything dangerous -
> should I disable UDMA for now to play it safe?

I never saw any corruption when I had it.  I've seen this with stock
kernels since 2.4.18 or so with ACPI and APIC enabled; with ac kernels
I never get it (I'm suspecting the old ACPI in the stock kernels is
the problem).

So my suggestion is either turn off ACPI and/or APIC, or try
2.4.21-ac.

-- 
Dave Meyer
dmeyer@dmeyer.net
