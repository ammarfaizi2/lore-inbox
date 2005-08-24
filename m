Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbVHXRCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbVHXRCm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 13:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVHXRCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 13:02:42 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:45213 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751197AbVHXRCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 13:02:18 -0400
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Al Viro <viro@www.linux.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (11/43) Kconfig fix (infiniband and PCI)
X-Message-Flag: Warning: May contain useful information
References: <E1E7gaT-00079k-Ax@parcelfarce.linux.theplanet.co.uk>
	<528xyr1f0c.fsf@cisco.com>
	<20050824163134.GK9322@parcelfarce.linux.theplanet.co.uk>
	<20050824164133.GL9322@parcelfarce.linux.theplanet.co.uk>
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 24 Aug 2005 10:02:05 -0700
In-Reply-To: <20050824164133.GL9322@parcelfarce.linux.theplanet.co.uk> (Al
 Viro's message of "Wed, 24 Aug 2005 17:41:33 +0100")
Message-ID: <52u0hfz2sy.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 24 Aug 2005 17:02:06.0986 (UTC) FILETIME=[8EF12EA0:01C5A8CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Al> PS: note that it's not depends on PCI it's depends on PCI ||
    Al> BROKEN which a) documents that something is wrong b) leaves
    Al> all setups usable now intact c) prevents broken setups from
    Al> being picked.

Yes, I agree that this makes sense for now.

    Al> I certainly agree that proper fix is to switch to dma_... - no
    Al> arguments here.  BTW, another dubious thing is use of
    Al> DECLARE_PCI_UNMAP_ADDR() in infiniband core - it's fine in PCI
    Al> drivers (which is how it's used elsewhere), but not in generic
    Al> data structures.

Yes, I guess we want DECLARE_DMA_UNMAP_ADDR() as well.  If I can
untangle the maze of .h files well enough to see where
dma_unmap_addr() et al. belong, I'll post a patch adding them.

 - R.
