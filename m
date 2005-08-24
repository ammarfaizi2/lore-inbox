Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVHXQWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVHXQWi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbVHXQWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:22:37 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:53590 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751121AbVHXQWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:22:37 -0400
To: Al Viro <viro@www.linux.org.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (11/43) Kconfig fix (infiniband and PCI)
X-Message-Flag: Warning: May contain useful information
References: <E1E7gaT-00079k-Ax@parcelfarce.linux.theplanet.co.uk>
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 24 Aug 2005 09:22:27 -0700
In-Reply-To: <E1E7gaT-00079k-Ax@parcelfarce.linux.theplanet.co.uk> (Al
 Viro's message of "Tue, 23 Aug 2005 22:45:41 +0100")
Message-ID: <528xyr1f0c.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 24 Aug 2005 16:22:32.0344 (UTC) FILETIME=[078B9180:01C5A8C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Al> infiniband uses PCI helpers all over the place (including the
    Al> core parts) and won't build without PCI.

I don't think this is the right fix.  The only PCI helpers used in
code that is enabled with CONFIG_PCI=n are pci_unmap_addr_set() and
pci_unmap_addr().  And they're only used because no one has added
dma_unmap_addr_set() and dma_unmap_addr() -- the core code is properly
using the general dma_xxx API wherever possible.

There actually is non-PCI InfiniBand hardware coming, so we'll have to
fix this properly at some point.

 - R.
