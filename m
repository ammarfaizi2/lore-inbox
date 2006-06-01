Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWFAPjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWFAPjh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 11:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbWFAPjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 11:39:36 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48529 "EHLO
	out.lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030205AbWFAPjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 11:39:36 -0400
Subject: Re: Query: No IDE DMA for IBM 365X with PIIX chipset?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <j9bi729h2u4dcn9da7na3t1d8ckk477d9b@4ax.com>
References: <j9bi729h2u4dcn9da7na3t1d8ckk477d9b@4ax.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 01 Jun 2006 14:50:12 +0100
Message-Id: <1149169812.12932.20.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2006-05-28 at 15:29 +1000, Grant Coady wrote:
> PIIXa: chipset revision 2
> PIIXa: not 100% native mode: will probe irqs later
> PIIXa: neither IDE port enabled (BIOS)

It thinks the chip has not been activated, and then falls back to the
legacy driver. Could be incorrect enable checks or other problems.

> 00:01.0 ISA bridge: Intel Corporation 82371FB PIIX ISA [Triton I] (rev 02)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
> 00: 86 80 2e 12 07 00 80 02 02 00 01 06 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

82371FB, whee thats prehistoric 8)

I don't actually have any support for the 371FB PIIX in either driver as
I've not been able to find a source for the data sheet to the chip. It
may work if added to the drivers/scsi/pata_oldpiix identifiers in the
2.6.17rc5-mm kernel. Would be useful to know as I don't know anyone else
with that chip any more 8)

Alan

