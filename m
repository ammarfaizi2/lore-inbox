Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264806AbTGBJVq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 05:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264810AbTGBJVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 05:21:46 -0400
Received: from 65-124-64-15.rdsl.ktc.com ([65.124.64.15]:12672 "EHLO
	csi.csimillwork.com") by vger.kernel.org with ESMTP id S264806AbTGBJVn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 05:21:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: dmeyer@dmeyer.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 IDE problems (lost interrupt, bad DMA status)
Date: Wed, 2 Jul 2003 06:34:42 -0400
User-Agent: KMail/1.4.3
References: <20030630224726.GA22579@jhereg.dmeyer.net>
In-Reply-To: <20030630224726.GA22579@jhereg.dmeyer.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307020634.42705.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone tell me what the -ac patches do with respect to this problem?  
Also, what functionality is lost when CONFIG_X86_IO_APIC is not set, and 
should it improve this hd timeout/lost interrupt problem?

Thanks!

On Monday 30 June 2003 06:47 pm, dmeyer@dmeyer.net wrote:
> In article <20030630221542.GA17416@alf.amelek.gda.pl> you write:
> > Hi,
> >
> > After upgrading the kernel from 2.4.20 to 2.4.21, sometimes I see
> > the following messages:
> >
> > hda: dma_timer_expiry: dma status == 0x24
> > hda: lost interrupt
> > hda: dma_intr: bad DMA status (dma_stat=30)
> > hda: dma_intr: status=0x50 { DriveReady SeekComplete }
> >
> > It happens especially when there is a lot of disk I/O (which stops
> > for a few seconds when these messages appear), with three different
> > disks (very unlikely they all decided to die at the same time...),
> > one old ATA33 (QUANTUM FIREBALL SE8.4A) and two newer ATA100 disks
> > (WDC WD300BB-32CCB0, ST340015A).  IDE controller: VIA VT82C686B
> > on a MSI MS-6368L motherboard.
> >
> > I don't remember seeing anything like that in any earlier 2.4.x
> > kernels.  Is this a known problem?  Is this anything dangerous -
> > should I disable UDMA for now to play it safe?
>
> I never saw any corruption when I had it.  I've seen this with stock
> kernels since 2.4.18 or so with ACPI and APIC enabled; with ac kernels
> I never get it (I'm suspecting the old ACPI in the stock kernels is
> the problem).
>
> So my suggestion is either turn off ACPI and/or APIC, or try
> 2.4.21-ac.

-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL 603-232-3115 FAX 603-625-5809 MOBILE 603-493-2386
www.briggsmedia.com
