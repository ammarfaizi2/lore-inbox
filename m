Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbVJIAwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVJIAwI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 20:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVJIAwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 20:52:08 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:23325 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932202AbVJIAwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 20:52:06 -0400
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: tom.l.nguyen@intel.com, akpm <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Doc/MSI-HOWTO: cleanups
X-Message-Flag: Warning: May contain useful information
References: <20051008171753.2137fd82.rdunlap@xenotime.net>
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 08 Oct 2005 17:51:57 -0700
In-Reply-To: <20051008171753.2137fd82.rdunlap@xenotime.net> (Randy Dunlap's
 message of "Sat, 8 Oct 2005 17:17:53 -0700")
Message-ID: <521x2vldg2.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 09 Oct 2005 00:51:58.0644 (UTC) FILETIME=[A7118F40:01C5CC6B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This file can definitely use some rewriting, so thanks for doing this
work.  I'm just picking on some things I notice while reading your patch:

    >  	masking is an optional extension of MSI but a required
    >  	feature for MSI-X. Per-vector masking provides the kernel
    >  	the ability to mask/unmask MSI when servicing its software
    > -	interrupt service routing handler. If per-vector masking is
    > +	interrupt service routine handler. If per-vector masking is
    >  	not supported, then the device driver should provide the
    >  	hardware/software synchronization to ensure that the device
    >  	generates MSI when the driver wants it to do so.

If you're going to touch this at all, it should be rewritten so it
actually makes sense.  I would rewrite this sentence as either

    "...the ability to mask/unmask a single MSI while servicing its
     interrupt."

or

    "...the ability to mask/unmask a single MSI while running its
     interrupt service routine."

     > +With this new API, any existing device driver which wants to have
     > +MSI enabled on its device function must call this API to enable MSI.

"device function" (which is PCI jargonese) should probably just be
"device."  Also, perhaps "...a device driver that..." would read
better than "...any existing device driver which...."

    >  pre-assigned dev->irq with a new MSI vector. To avoid the conflict
    > -of new assigned vector with existing pre-assigned vector requires
    > +of the new assigned vector with existing pre-assigned vector requires
    >  a device driver to call this API before calling request_irq().

"...the conflict..." should probably be "...a conflict..."

    > +software system can set different pages for controlling accesses to the
    > +MSI-X structure. The implementation of the MSI patch requires the PCI

"...the MSI patch..." should probably be "...MSI support..."

Thanks,
  Roland
