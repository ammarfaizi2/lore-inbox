Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbVH2UzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbVH2UzG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 16:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVH2UzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 16:55:06 -0400
Received: from mx1.suse.de ([195.135.220.2]:24497 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751043AbVH2UzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 16:55:05 -0400
From: Andi Kleen <ak@suse.de>
To: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [patch 2.6.13] x86_64: implement dma_sync_single_range_for_{cpu,device}
Date: Mon, 29 Aug 2005 22:54:53 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <20050829200916.GI3716@tuxdriver.com>
In-Reply-To: <20050829200916.GI3716@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508292254.53476.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 August 2005 22:09, John W. Linville wrote:
> Implement dma_sync_single_range_for_{cpu,device}, based on curent
> implementations of dma_sync_single_for_{cpu,device}.

Hmm, who or what needs that? It doesn't seem to be documented
in Documentation/DMA* and I also don't remember seeing any 
discussion of it.

If it's commonly used it might better to add new swiotlb_* 
functions that only copy the requested range.

-Andi


