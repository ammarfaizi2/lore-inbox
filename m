Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWJOV0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWJOV0I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 17:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWJOV0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 17:26:08 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37804 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750997AbWJOV0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 17:26:05 -0400
Subject: Re: [Bulk] Re: [PATCH 1/2] [PCI] Check that MWI bit really did get
	set
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, David Brownell <david-b@pacbell.net>,
       val_henson@linux.intel.com, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
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
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 15 Oct 2006 22:52:15 +0100
Message-Id: <1160949135.5732.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-10-15 am 10:45 -0700, ysgrifennodd Andrew Morton:
> If the drivers doesn't care and if it makes no difference to performance
> then just delete the call to pci_set_mwi().
> 
> But if MWI _does_ make a difference to performance then we should tell
> someone that it isn't working rather than silently misbehaving?

It isn't misbehaving it just isn't available. MWI is rather different to
say pci_set_master() in that it makes a lot of sense for many drivers to
ask for it but not care about the results. Something like pci_set_master
failing is a big problem and has to be handled (although as we often
don't use BIOS PCI services we see fake success in some cases).

MWI is an "extra cheese" option not a "no pizza" case

Alan

