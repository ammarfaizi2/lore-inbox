Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTILXPS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 19:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbTILXPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 19:15:17 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:7834 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261936AbTILXPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 19:15:14 -0400
Subject: Re: (kconfig) IDE DMA dependencies
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <8B61CFDE-E575-11D7-AC00-000A95A0560C@us.ibm.com>
References: <8B61CFDE-E575-11D7-AC00-000A95A0560C@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063408432.6736.0.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Sat, 13 Sep 2003 00:13:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-09-13 at 00:05, Hollis Blanchard wrote:
> drivers/built-in.o(.text+0x39f90): In function `init_dma_generic':
> drivers/ide/pci/generic.c:77: undefined reference to `ide_setup_dma'
> drivers/built-in.o(.text+0x4a7e8): In function `ide_hwif_setup_dma':
> drivers/ide/setup-pci.c:511: undefined reference to `ide_setup_dma'
> 
> Even if it is stubbed correctly though, don't we want DMA (i.e. it's 
> safe) with most of those drivers?

Thats up to the user. Removing the DMA support makes no real difference
for many devices (eg CF cards) but saves a chunk of RAM

