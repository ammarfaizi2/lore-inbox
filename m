Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbVKKTKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbVKKTKY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbVKKTKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:10:24 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:41157 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751063AbVKKTKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:10:23 -0500
Subject: Re: sparc64: Oops in pci_alloc_consistent with cingergyT2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Guido Guenther <agx@sigxcpu.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051111153354.GA19838@bogon.ms20.nix>
References: <20051111153354.GA19838@bogon.ms20.nix>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 11 Nov 2005 19:41:20 +0000
Message-Id: <1131738080.3174.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-11-11 at 16:33 +0100, Guido Guenther wrote:
> cinergyt2->streambuf = pci_alloc_consistent(NULL,
>                                               STREAM_URB_COUNT*STREAM_BUF_SIZE,
>                                               &cinergyt2->streambuf_dmahandle);
> 
> dma_alloc_coherent doesn't seem to be implemented on sparc64, what would


The DMA channel in question is the PCI hub to which the device is
connected. So it should not be using NULL, it should be passing the pci
device id of the bus controller to whom it is attached

