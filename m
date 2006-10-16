Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbWJPAET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbWJPAET (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 20:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWJPAET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 20:04:19 -0400
Received: from ozlabs.org ([203.10.76.45]:36481 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030301AbWJPAES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 20:04:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17714.52121.962807.781244@cargo.ozlabs.ibm.com>
Date: Mon, 16 Oct 2006 10:00:25 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Brownell <david-b@pacbell.net>, val_henson@linux.intel.com,
       netdev@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [Bulk] Re: [PATCH 1/2] [PCI] Check that MWI bit really did get
 set
In-Reply-To: <20061015104544.5de31608.akpm@osdl.org>
References: <1160161519800-git-send-email-matthew@wil.cx>
	<20061013214135.8fbc9f04.akpm@osdl.org>
	<20061014140249.GL11633@parisc-linux.org>
	<20061014134855.b66d7e65.akpm@osdl.org>
	<20061015032000.GP11633@parisc-linux.org>
	<20061015070809.978C714552@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<1160922082.5732.51.camel@localhost.localdomain>
	<20061015135756.GD22289@parisc-linux.org>
	<20061015104544.5de31608.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> If the drivers doesn't care and if it makes no difference to performance
> then just delete the call to pci_set_mwi().
> 
> But if MWI _does_ make a difference to performance then we should tell
> someone that it isn't working rather than silently misbehaving?

That sounds like we need a printk inside pci_set_mwi then, rather than
adding a printk to every single caller.

Paul.
