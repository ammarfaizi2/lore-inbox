Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbVHMQR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbVHMQR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 12:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbVHMQR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 12:17:56 -0400
Received: from nproxy.gmail.com ([64.233.182.198]:13546 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751350AbVHMQR4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 12:17:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NTcdL55n6pju8rcc6ydiuHuC5jfJIbk8DJCAfZjVrmGyAjFef2kXeIB6OtyFgFxCl8352Mi9vmV5bXmMA5Ix+HssWKF05HPJzUij6BIVk5a/YMQjg37GEYvDmJ6L7Q+LFi+wsl7Iu2i4jNcaLqGX3yLUgbc9P7WgRV9cyVmU7/I=
Message-ID: <84144f02050813091719c9c85a@mail.gmail.com>
Date: Sat, 13 Aug 2005 19:17:50 +0300
From: Pekka Enberg <penberg@gmail.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Reusing the slab allocator
Cc: lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Dave Airlie <airlied@linux.ie>, Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <9e473391050810092835b3ef27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e473391050810092835b3ef27@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/05, Jon Smirl <jonsmirl@gmail.com> wrote:
> We need a memory manager for the VRAM on video cards. The most common
> video cards have been 2MB and 512MB memory. Is it possible to reuse
> the kernel slab allocator for managing this memory?
> 
> There are a couple of other odd constraints.
> 1) Some objects need to be allocated on boundaries, like 64B or even
> 1KB divisible addresses.
> 2) It would be best if the allocation bookkeeping data structures were
> kept in system RAM. It may not be simple to access VRAM for read/write
> of bookkeeping info. VRAM  can require slow PCI cycles or need high
> mem mappings to access.
> 
> If possible I'd rather reuse an existing manager than write a new one.

Alternatively, take a look at vmem allocator described in Magazines
and Vmem: Extending the Slab Allocator to Many CPUs and Arbitrary
Resources by Bonwick. AFAIK the slab allocator in Solaris is built on
vmem.

                                   Pekka
