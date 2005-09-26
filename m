Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbVIZVdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbVIZVdh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 17:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVIZVdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 17:33:37 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:30358 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932327AbVIZVdg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 17:33:36 -0400
Date: Mon, 26 Sep 2005 15:33:26 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       ak@suse.de, tony.luck@intel.com, Asit.K.Mallick@intel.com,
       gregkh@suse.de
Subject: Re: [patch 2.6.14-rc2 0/5] swiotlb maintenance and x86_64 dma_sync_single_range_for_{cpu,device}
Message-ID: <20050926213326.GF1459@parisc-linux.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F04795ED2@scsmsx401.amr.corp.intel.com> <09262005170119.15628@bilbo.tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09262005170119.15628@bilbo.tuxdriver.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 05:01:19PM -0400, John W. Linville wrote:
> In this round, the new location for swiotlb is driver/pci/swiotlb.c.
> This is the result of discussions on lkml pointing-out that swiotlb is
> closely related to PCI.

Uh?  It implements DMA services, which aren't limited to PCI at all.
Despite the file including <linux.pci.h> and <asm/pci.h> (which should
probably both be removed), there's not a single PCI-related function in
this file.  You originally moved it to lib/ which made much more sense.
