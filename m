Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbTDIL7o (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 07:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbTDIL7o (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 07:59:44 -0400
Received: from prosun.first.gmd.de ([194.95.168.2]:15890 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S263016AbTDIL7n (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 07:59:43 -0400
Subject: Re: 2.4.21pre6 (__ide_dma_test_irq) called while not waiting
From: Soeren Sonnenburg <kernel@nn7.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1049885242.9897.7.camel@dhcp22.swansea.linux.org.uk>
References: <1049879881.2774.40.camel@fortknox>
	 <1049885242.9897.7.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1049890280.9942.2.camel@calculon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 09 Apr 2003 14:11:20 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-09 at 12:47, Alan Cox wrote:
> On Mer, 2003-04-09 at 10:18, Soeren Sonnenburg wrote:
> > hdi: 4 bytes in FIFO
> > hdi: timeout waiting for DMA
> > hdi: (__ide_dma_test_irq) called while not waiting
> > hdi: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
> > 
> > hdk: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
> 
> This looks like a shared IRQ occurred while a command was being
> sent. The IDE layer apparently tested for the IRQ before it 
> was ready to do so as part of finding out what is going on. The
> -ac tree (and pre7) may possibly have fixed it with the command
> delay stuff that Ross Biro figured out

ok, so I will upgrade to pre7 ASAP and let you know about the result.

thanks.

Soeren.

