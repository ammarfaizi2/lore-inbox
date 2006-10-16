Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbWJPKbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbWJPKbp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbWJPKbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:31:45 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54234 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030348AbWJPKbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:31:44 -0400
Subject: Re: [PATCH 1/2] [PCI] Check that MWI bit really did get set
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, David Brownell <david-b@pacbell.net>,
       matthew@wil.cx, val_henson@linux.intel.com, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
In-Reply-To: <20061015181044.ec414e4f.akpm@osdl.org>
References: <1160161519800-git-send-email-matthew@wil.cx>
	 <20061015191631.DE49D19FEC8@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	 <20061015123432.4c6b7f15.akpm@osdl.org>
	 <200610151545.59477.david-b@pacbell.net>
	 <20061015161834.f96a0761.akpm@osdl.org>
	 <1160956960.5732.99.camel@localhost.localdomain>
	 <20061015164402.f9b8b4d2.akpm@osdl.org>
	 <17714.54766.390707.532248@cargo.ozlabs.ibm.com>
	 <20061015181044.ec414e4f.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 11:58:15 +0100
Message-Id: <1160996295.24237.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-10-15 am 18:10 -0700, ysgrifennodd Andrew Morton:
> Question is, should pci_set_mwi() ever return -EFOO?  I guess it should, in
> the case where setting the line size didn't work out.

It does no harm, no driver will ever check anything but 0 v !0 because
the handling is no different in either case.

