Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030360AbVI3Qdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbVI3Qdb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 12:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbVI3Qda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 12:33:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25296 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030360AbVI3Qda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 12:33:30 -0400
Date: Fri, 30 Sep 2005 09:33:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Brownell <david-b@pacbell.net>
cc: daniel.ritz@gmx.ch, rjw@sisk.pl, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, hugh@veritas.com, akpm@osdl.org
Subject: Re: [linux-usb-devel] Re: 2.6.13-mm2
In-Reply-To: <20050929000929.2CEACE372B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Message-ID: <Pine.LNX.4.64.0509300926590.3378@g5.osdl.org>
References: <20050908053042.6e05882f.akpm@osdl.org> <200509282334.58365.rjw@sisk.pl>
 <20050928220409.DE48BE3724@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
 <200509290032.26815.daniel.ritz@gmx.ch>
 <20050929000929.2CEACE372B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Sep 2005, David Brownell wrote:
> 
> You could try adding
> 
> 	ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
> 
> near the end of ohci_pci_suspend().  

Btw, wouldn't this make more sense in ohci_hub_suspend()? That would pair 
up with the resume, and there seems to be nothing PCI-specific about this?

There are other callers of suspend than just the PCI bus suspend.

Just wondering..

		Linus
