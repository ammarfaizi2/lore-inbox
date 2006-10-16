Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWJOXgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWJOXgk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 19:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWJOXgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 19:36:40 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36538 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932175AbWJOXgj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 19:36:39 -0400
Subject: Re: [PATCH 1/2] [PCI] Check that MWI bit really did get set
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, matthew@wil.cx,
       val_henson@linux.intel.com, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
In-Reply-To: <20061015161834.f96a0761.akpm@osdl.org>
References: <1160161519800-git-send-email-matthew@wil.cx>
	 <20061015191631.DE49D19FEC8@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	 <20061015123432.4c6b7f15.akpm@osdl.org>
	 <200610151545.59477.david-b@pacbell.net>
	 <20061015161834.f96a0761.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 01:02:40 +0100
Message-Id: <1160956960.5732.99.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-10-15 am 16:18 -0700, ysgrifennodd Andrew Morton:
> No.  If pci_set_mwi() detects an unexpected error then the driver should
> take some action: report it, recover from it, fail to load, etc.  If the
> driver fails to do any of this then it's a buggy driver.

Wrong and there are several drivers in the kernel that are proof of
this.

> You, the driver author _do not know_ what pci_set_mwi() does at present, on
> all platforms, nor do you know what it does in the future.  For you the

You don't care. It isn't an error for set_mwi to fail. In fact the only
reason set_mwi even needs to bother with a return code is that some
chips want you to set other config private to the device if it is
available and active.

Alan

