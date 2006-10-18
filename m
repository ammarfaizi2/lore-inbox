Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWJRFc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWJRFc3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 01:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWJRFc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 01:32:29 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:44304 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1751404AbWJRFc2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 01:32:28 -0400
Message-ID: <4535BC68.40509@argo.co.il>
Date: Wed, 18 Oct 2006 07:32:24 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Ryan Richter <ryan@tau.solarneutrino.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Dr. David Alan Gilbert" <dave@treblig.org>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: DVD drive not recognized on Intel G965 (2.6.19-rc2)
References: <20061017222310.GA24891@tau.solarneutrino.net>
In-Reply-To: <20061017222310.GA24891@tau.solarneutrino.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Oct 2006 05:32:26.0759 (UTC) FILETIME=[CBE6A170:01C6F276]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Richter wrote:
>
> > > Try adding all-generic-ide to the kernel command line, and if that
> > > fails, post your lspci output.
> >
> I tried this and also the Marvell PATA driver you posted, and still
> nothing.
>
> Here's my lspci output and my current .config:
>
>
> 02:00.0 IDE interface: Marvell Technology Group Ltd. Unknown device 
> 6101 (rev b1) (prog-if 8f [Master SecP SecO PriP PriO])
>

My own lspci says:

  02:00.0 IDE interface: Marvell Technology Group Ltd. Unknown device 
6101 (rev b1)

and the DVD works:

  Unknown: IDE controller at PCI slot 0000:02:00.0
  ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 169
  Unknown: chipset revision 177
  Unknown: 100% native mode on irq 169
      ide0: BM-DMA at 0x2000-0x2007, BIOS settings: hda:DMA, hdb:DMA
      ide1: BM-DMA at 0x2008-0x200f, BIOS settings: hdc:DMA, hdd:DMA
  Probing IDE interface ide0...
  hda: HL-DT-ST DVDRAM GSA-H10A, ATAPI CD/DVD-ROM drive
  ide0 at 0x2018-0x201f,0x2026 on irq 169

Since  I'm running a Fedora kernel, you might want to look at their 
patchlist and .config.  I briefly ran mainline, but I can't remember if 
I accessed the drive while running that.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

