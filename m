Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030463AbVKXD4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030463AbVKXD4C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 22:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbVKXD4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 22:56:02 -0500
Received: from mtaout2.012.net.il ([84.95.2.4]:4822 "EHLO mtaout2.012.net.il")
	by vger.kernel.org with ESMTP id S1030463AbVKXD4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 22:56:00 -0500
Date: Thu, 24 Nov 2005 05:55:44 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: [PATCH 0/3] move swiotlb.h header file to common code
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@lst.de>, Andi Kleen <ak@suse.de>,
       Tony Luck <tony.luck@intel.com>
Message-id: <20051124035544.GA5913@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset does two things:

- creates an asm-generic/swiotlb.h header file and makes x86-64 and
IA64 both use it.

- makes swiotlb use 'enum dma_direction_dir' instead of 'int dir',
which is the right thing to according to the the DMA API, and updates
x86-64 and  ia64 accordingly. The code should be completely
equivalent. Compile tested on x86-64 and IA64.

This is the first step towards having a common IOMMU
infrastructure. Unfortunatly applying any of the patches require the
other two. It was posted to lkml a few days ago and there were no
comments.

Please apply.

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

