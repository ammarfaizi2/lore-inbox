Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278137AbRJLVGN>; Fri, 12 Oct 2001 17:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278139AbRJLVGD>; Fri, 12 Oct 2001 17:06:03 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38672 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278137AbRJLVFz>; Fri, 12 Oct 2001 17:05:55 -0400
Subject: Re: DMA problem (?) w/2.4.6-xfs and Serverworks OSB4 Chipset
To: timm@fnal.gov (Steven Timm)
Date: Fri, 12 Oct 2001 22:12:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <Pine.LNX.4.31.0110121527330.22455-100000@snowball.fnal.gov> from "Steven Timm" at Oct 12, 2001 03:31:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15s9bI-0000Z7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am now running 2.4.9-0.18 kernel as found at Redhat's Rawhide
> which includes Alan's latest diagnostic patches, and am getting
> the message like this:
> 
> end_request: I/O error, dev 16:01 (hdc), sector 2487128
> Curious - OSB4 thinks the DMA is still running.
> OSB4 wait exit.
> hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2487198,
> sector=2487128
> 
> with the "Curious..." patch being the new diagnostics added by Alan.
> All the various failure modes which we see include this error
> message now.
> 
> What does this imply...is there any hope for a fix?

At the moment nope. Probably we should simply default to MWDMA not UDMA
on the OSB4.
