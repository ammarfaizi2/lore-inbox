Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUHBWUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUHBWUi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 18:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUHBWUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 18:20:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:31878 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264265AbUHBWUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 18:20:35 -0400
Date: Tue, 3 Aug 2004 00:20:00 +0200
From: Andi Kleen <ak@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Anton Blanchard <anton@samba.org>, sfr@ozlabs.org,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] [ppc64] watch IOMMU virtual merging
Message-ID: <20040802222000.GM25951@wotan.suse.de>
References: <20040802164448.GN30253@krispykreme> <20040802170843.GI2334@holomorphy.com> <1091483151.7389.78.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091483151.7389.78.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 07:45:51AM +1000, Benjamin Herrenschmidt wrote:

[adding linux-scsi with full quote]
> 
> Actually, we could tune the ratio between large allocs and small allocs,
> the real problem is the failure case. We can't really afford to break
> down a physical segment at the iommu level because that would increase
> the size of the SG list which can't be dealt at the upper level (we don't
> know how much space has been allocated and the HW may have limitations on
> the number of entries).
> 
> What we really need is a way for drivers to return the BIO upstream and
> ask for a split in case of iommu allocation error, but I've been told that
> would be horribly complex...

Not very, according to James B. It just needs driver changes.
I would like to have it too. 

-Andi
