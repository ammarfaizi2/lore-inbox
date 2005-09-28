Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbVI1Vwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbVI1Vwr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbVI1Vwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:52:47 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:28165 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751013AbVI1Vwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:52:44 -0400
Date: Wed, 28 Sep 2005 17:50:47 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Cc: ak@suse.de, tony.luck@intel.com, Asit.K.Mallick@intel.com, gregkh@suse.de
Subject: [patch 2.6.14-rc2 0/6] swiotlb maintenance and x86_64 dma_sync_single_range_for_{cpu,device}
Message-ID: <09282005175047.10096@bilbo.tuxdriver.com>
In-Reply-To: <12c511ca050926194784b63e5@mail.gmail.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Conduct some maintenance of the swiotlb code:

	-- Move the code from arch/ia64/lib/ to lib/

	-- Cleanup some cruft (code duplication)

	-- Add support for syncing sub-ranges of mappings

	-- Add support for syncing DMA_BIDIRECTIONAL mappings

	-- Comment fixup & change record

Also, tack-on an x86_64 implementation of dma_sync_single_range_for_cpu
and dma_sync_single_range_for _device.  This makes use of the new
swiotlb sync sub-range support.

In this (third) round, the new location for swiotlb is (again) lib/swiotlb.c.

This set does NOT include the PCI excision that Tony Luck started after the
last round of discussion.

Patches to follow...
