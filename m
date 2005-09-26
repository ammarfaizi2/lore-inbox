Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbVIZVzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbVIZVzX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 17:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVIZVzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 17:55:23 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:14601 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932333AbVIZVzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 17:55:21 -0400
Date: Mon, 26 Sep 2005 17:54:50 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       ak@suse.de, tony.luck@intel.com, Asit.K.Mallick@intel.com,
       gregkh@suse.de
Subject: Re: [patch 2.6.14-rc2 0/5] swiotlb maintenance and x86_64 dma_sync_single_range_for_{cpu,device}
Message-ID: <20050926215447.GB5640@tuxdriver.com>
Mail-Followup-To: Matthew Wilcox <matthew@wil.cx>,
	linux-kernel@vger.kernel.org, discuss@x86-64.org,
	linux-ia64@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
	ak@suse.de, tony.luck@intel.com, Asit.K.Mallick@intel.com,
	gregkh@suse.de
References: <B8E391BBE9FE384DAA4C5C003888BE6F04795ED2@scsmsx401.amr.corp.intel.com> <09262005170119.15628@bilbo.tuxdriver.com> <20050926213326.GF1459@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050926213326.GF1459@parisc-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 03:33:26PM -0600, Matthew Wilcox wrote:
> On Mon, Sep 26, 2005 at 05:01:19PM -0400, John W. Linville wrote:
> > In this round, the new location for swiotlb is driver/pci/swiotlb.c.
> > This is the result of discussions on lkml pointing-out that swiotlb is
> > closely related to PCI.
> 
> Uh?  It implements DMA services, which aren't limited to PCI at all.
> Despite the file including <linux.pci.h> and <asm/pci.h> (which should
> probably both be removed), there's not a single PCI-related function in
> this file.  You originally moved it to lib/ which made much more sense.

Well, now, this is a quandry isn't it...  Actually, I'm inclined to
agree with you.

Tony, et al., care to restate your reasoning for moving it under
drivers/pci?

John
-- 
John W. Linville
linville@tuxdriver.com
