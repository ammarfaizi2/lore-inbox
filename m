Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267360AbUHDRbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267360AbUHDRbX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 13:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267363AbUHDRbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 13:31:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:12229 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267360AbUHDRbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 13:31:19 -0400
Date: Wed, 4 Aug 2004 19:31:11 +0200
From: Jens Axboe <axboe@suse.de>
To: Andi Kleen <ak@muc.de>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: block layer sg, bsg
Message-ID: <20040804173111.GB5978@suse.de>
References: <2ppN4-1wi-11@gated-at.bofh.it> <2pvps-5xO-33@gated-at.bofh.it> <2pvz2-5Lf-19@gated-at.bofh.it> <2pwbQ-68b-43@gated-at.bofh.it> <m33c32ke3f.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m33c32ke3f.fsf@averell.firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04 2004, Andi Kleen wrote:
> "David S. Miller" <davem@redhat.com> writes:
> >
> > Or use a more portable well-defined type which does not change
> > size nor layout between 32-bit and 64-bit environments.
> 
> That is usually a mistake. People get the more subtle issues
> like long long handling wrong, and then it is impossible to fix it 
> anymore in a compat layer (examples are ipsec and iptables, which
> cannot be emulated on x86-64 because of that) 
> 
> So please never pass any structures with read/write/netlink.

Which basically brings us back to SG_IO, or (alternatively) SG_IO_WRITE
and SG_IO_READ ioctls. I doubt that is really worth it, however. There's
just not a huge need to do it.

-- 
Jens Axboe

