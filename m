Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbTILXFO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 19:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbTILXFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 19:05:14 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:62944 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261873AbTILXFJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 19:05:09 -0400
Date: Fri, 12 Sep 2003 18:05:04 -0500
Subject: Re: (kconfig) IDE DMA dependencies
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <1063405576.5783.13.camel@dhcp23.swansea.linux.org.uk>
Message-Id: <8B61CFDE-E575-11D7-AC00-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, Sep 12, 2003, at 17:26 US/Central, Alan Cox wrote:

> On Gwe, 2003-09-12 at 22:36, Hollis Blanchard wrote:
>> I noticed this when my linker couldn't find ide_setup_dma() last 
>> night.
>> It looks like most of the drivers/ide/pci/ drivers use ide_setup_dma()
>> in their .init_dma() function. ide_setup_dma() is defined in
>
> It should be falling out as a stub function I think. In the non DMA
> case it should never get invoked anyway

drivers/built-in.o(.text+0x39f90): In function `init_dma_generic':
drivers/ide/pci/generic.c:77: undefined reference to `ide_setup_dma'
drivers/built-in.o(.text+0x4a7e8): In function `ide_hwif_setup_dma':
drivers/ide/setup-pci.c:511: undefined reference to `ide_setup_dma'

Even if it is stubbed correctly though, don't we want DMA (i.e. it's 
safe) with most of those drivers?

-- 
Hollis Blanchard
IBM Linux Technology Center

