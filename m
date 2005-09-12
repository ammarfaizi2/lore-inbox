Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbVILOxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbVILOxQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbVILOxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:53:16 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:58630 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751217AbVILOxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:53:14 -0400
Date: Mon, 12 Sep 2005 10:48:47 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org
Cc: ak@suse.de, tony.luck@intel.com, Asit.K.Mallick@intel.com
Subject: [patch 2.6.13 0/6] swiotlb maintenance and x86_64 dma_sync_single_range_for_{cpu,device}
Message-ID: <09122005104847.30871@bilbo.tuxdriver.com>
In-Reply-To: <20050830180912.GE18998@tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Conduct some maintenance of the swiotlb code:

	-- Move the code from arch/ia64/lib to lib

	-- Cleanup some cruft (code duplication)

	-- Add support for syncing sub-ranges of mappings

	-- Add support for syncing DMA_BIDIRECTIONAL mappings

	-- Comment fixup & change record

Also, tack-on an x86_64 implementation of dma_sync_single_range_for_cpu
and dma_sync_single_range_for _device.  This makes use of the new
swiotlb sync sub-range support.

Patches to follow...
