Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284887AbRLMTLu>; Thu, 13 Dec 2001 14:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284857AbRLMTLl>; Thu, 13 Dec 2001 14:11:41 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:23334 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S284917AbRLMTL0> convert rfc822-to-8bit; Thu, 13 Dec 2001 14:11:26 -0500
Date: Thu, 13 Dec 2001 17:17:22 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: "David S. Miller" <davem@redhat.com>
cc: <andrea@suse.de>, <axboe@suse.de>, <gibbs@scsiguy.com>,
        <LB33JM16@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
In-Reply-To: <20011212.162603.28785873.davem@redhat.com>
Message-ID: <20011213165932.L1871-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Dec 2001, David S. Miller wrote:

>    From: Gérard Roudier <groudier@free.fr>
>    Date: Wed, 12 Dec 2001 21:24:59 +0100 (CET)
>
>    A N% loss for the 99% case in order to support the 1% is close to N%
>    loss. So, each time we bloat or complexify the code with no relevance for
>    the average case, the overall difference cannot be a win.
>
> Do you know, you can use this N% loss to implement handling of the
> very problem you have wrt. sym53c8xx hw bugs? :-)

What hw bugs ? :-)

The driver is very fortunate. Based on DELs, only a few known hw bugs have
had to be worked-around by sym drivers. In fact, you can avoid most bugs,
by taking into account usual bugs in PCI hw. When I have made sym53c8xx
from ncr53c8xx, I had some clues in mind.

The 16MB/32MB boundary I pointed out can only affect sym53c896 rev. 1, and
only in not very likely situations. In plan to resurrect the work-around
in Linux sym_glue.c if pci_map_sg() will not want to handle the issue.

So, on paper, you were talking about a single unlikely to happen hw bug.
:-)

> To be honest all the machinery to handle the problems you have
> described are there today, even with IOMMU's present.  The generic
> block layer today knows when IOMMU is being used, it knows what kind
> of coalescing can and will be done by the IOMMU support code (via
> DMA_CHUNK_SIZE), and therefore it is capable of adhering to any
> restrictions you care to describe to the block layer.

Will look into all these great things over the week-end and let you all
know my remarks if any.

> It's only a matter of coding on Jens's part :-)

Jen's seems to be a great and very courageous coder, so let me trust him
not to miss anything important. :)

Thanks for your reply,
  Gérard.

PS: Don't take the wrong way my statements against Sun stuff. In fact, I
    dislike almost everything that comes and came from them. :)


