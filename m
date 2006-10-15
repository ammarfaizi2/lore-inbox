Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWJONzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWJONzG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 09:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWJONzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 09:55:06 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64670 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964838AbWJONzB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 09:55:01 -0400
Subject: Re: [Bulk] Re: [PATCH 1/2] [PCI] Check that MWI bit really did get
	set
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Brownell <david-b@pacbell.net>
Cc: matthew@wil.cx, akpm@osdl.org, val_henson@linux.intel.com,
       netdev@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, gregkh@suse.de
In-Reply-To: <20061015070809.978C714552@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <1160161519800-git-send-email-matthew@wil.cx>
	 <20061013214135.8fbc9f04.akpm@osdl.org>
	 <20061014140249.GL11633@parisc-linux.org>
	 <20061014134855.b66d7e65.akpm@osdl.org>
	 <20061015032000.GP11633@parisc-linux.org>
	 <20061015070809.978C714552@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 15 Oct 2006 15:21:22 +0100
Message-Id: <1160922082.5732.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-10-15 am 00:08 -0700, ysgrifennodd David Brownell:
> Since it's not an error, there should be no such printk ... which
> is exactly how it's coded above.

The underlying bug is that someone marked pci_set_mwi must-check, that's
wrong for most of the drivers that use it. If you remove the must check
annotation from it then the problem and a thousand other spurious
warnings go away.
