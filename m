Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317260AbSFLQJS>; Wed, 12 Jun 2002 12:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317732AbSFLQJR>; Wed, 12 Jun 2002 12:09:17 -0400
Received: from earth.ayrnetworks.com ([64.166.72.139]:65226 "EHLO 
	ayrnetworks.com") by vger.kernel.org with ESMTP id <S317260AbSFLQJR>;
	Wed, 12 Jun 2002 12:09:17 -0400
Date: Wed, 12 Jun 2002 09:09:09 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: "David S. Miller" <davem@redhat.com>
Cc: paulus@samba.org, roland@topspin.com, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Message-ID: <20020612090909.A13154@ayrnetworks.com>
In-Reply-To: <15619.9534.521209.93822@nanango.paulus.ozlabs.org> <20020609.212705.00004924.davem@redhat.com> <20020610110740.B30336@ayrnetworks.com> <20020612.044759.115989376.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 04:47:59AM -0700, David S. Miller wrote:
>    From: William Jhun <wjhun@ayrnetworks.com>
>    Date: Mon, 10 Jun 2002 11:07:40 -0700
> 
>    On Sun, Jun 09, 2002 at 09:27:05PM -0700, David S. Miller wrote:
>    > I'm trying to specify this such that knowledge of cachelines and
>    > whatnot don't escape the arch specific code, ho hum...  Looks like
>    > that isn't possible.
>    
>    Perhaps provide macros in asm/pci.h that will:
>    
> You don't understand, I think.  I want to avoid the drivers doing
> any of the "align this, align that" stuff.  I want the allocation
> to do it for them, that way the code is in one place.

No, I do understand your point. And this does not bring "knowledge of
cachelines and whatnot" into the driver; those "macros" could similarly
be calls to arch-specific code that acts based on a pdev. I was simply
trying to think of a compromise between that and massively changing the
interface by which a driver obtains buffers. And I assume alloc_skb()
and others would need to change otherwise. How would you specify if your
skb data needs to be PCI DMA-able? What about net drivers not using DMA
at all?

Thanks,
Will
