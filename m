Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbVKUVvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbVKUVvB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVKUVvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:51:00 -0500
Received: from mtaout3.012.net.il ([84.95.2.7]:14012 "EHLO mtaout3.012.net.il")
	by vger.kernel.org with ESMTP id S1751064AbVKUVvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:51:00 -0500
Date: Mon, 21 Nov 2005 23:50:48 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: [RFC PATCH 0/3] move swiotlb header file into common code
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Message-id: <20051121215048.GE22728@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset does two main things:

- creates an asm-generic/swiotlb.h header file and makes x86-64 and
IA64 both use it.

- make swiotlb use 'enum dma_direction_dir' instead of 'int dir',
which is the right thing to do in the DMA API, and updates x86-64 and
ia64 accordingly.

This is the first step towards having a common IOMMU
infrastructure. Unfortunatly applying any of the patches require the
other 2.

Compile tested on both x86-64 and IA64, I'll appreciate it if someone
knowledgable about IA64 could double check the IA64 bits.

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

