Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267263AbUHSS4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267263AbUHSS4a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 14:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267258AbUHSS43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 14:56:29 -0400
Received: from the-village.bc.nu ([81.2.110.252]:1925 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267269AbUHSS4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 14:56:23 -0400
Subject: Re: 2.6.8.1-mm2 (nvidia breakage)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Michael Geithe <warpy@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408191051.11891.bjorn.helgaas@hp.com>
References: <20040819092654.27bb9adf.akpm@osdl.org>
	 <200408191051.11891.bjorn.helgaas@hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092938035.28370.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 19 Aug 2004 18:53:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-19 at 17:51, Bjorn Helgaas wrote:
> I assume this problem is with the Nvidia binary-only driver?  My guess
> is that the driver doesn't call pci_enable_device() before using
> pci_dev->irq.  I don't have source for that driver, so I can't verify
> this.

An obvious test would be for someone with an Nvidia to write a little
module that does nothing but pci_enable_device it. Load and unload that
then see what happens

