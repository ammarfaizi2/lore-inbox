Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVIZVC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVIZVC0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 17:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932065AbVIZVCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 17:02:24 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:60424 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932070AbVIZVCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 17:02:22 -0400
Date: Mon, 26 Sep 2005 17:01:19 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Cc: ak@suse.de, tony.luck@intel.com, Asit.K.Mallick@intel.com, gregkh@suse.de
Subject: [patch 2.6.14-rc2 0/5] swiotlb maintenance and x86_64 dma_sync_single_range_for_{cpu,device}
Message-ID: <09262005170119.15628@bilbo.tuxdriver.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F04795ED2@scsmsx401.amr.corp.intel.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Conduct some maintenance of the swiotlb code:

	-- Move the code from arch/ia64/lib to drivers/pci

	-- Cleanup some cruft (code duplication)

	-- Add support for syncing sub-ranges of mappings

	-- Add support for syncing DMA_BIDIRECTIONAL mappings

	-- Comment fixup & change record

Also, tack-on an x86_64 implementation of dma_sync_single_range_for_cpu
and dma_sync_single_range_for _device.  This makes use of the new
swiotlb sync sub-range support.

In this round, the new location for swiotlb is driver/pci/swiotlb.c.
This is the result of discussions on lkml pointing-out that swiotlb is
closely related to PCI.

Patches to follow...
