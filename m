Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935606AbWK1Feb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935606AbWK1Feb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 00:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935613AbWK1Feb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 00:34:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:23861 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S935606AbWK1Fe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 00:34:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rVXKCU4UJsWcEQjVN7fZNmlS2sg46FUToOhAmER4baMxgzMYxbvwp3Agb5OOsIpQCDhdQamdyTZfBhKHLp5cgnRlds5BGT/4BvzU+3155LIPXIcgtS/0VSUyj7CS3GW9YC1R7nJ0ZMtsJpTcFRYOeAubuI+jggm728EL9pqwU7A=
Message-ID: <21d7e9970611272134g72044fa8u5c5e47842e994fe3@mail.gmail.com>
Date: Tue, 28 Nov 2006 16:34:28 +1100
From: "Dave Airlie" <airlied@gmail.com>
To: "Jon Ringle" <jringle@vertical.com>
Subject: Re: Reserving a fixed physical address page of RAM.
Cc: "Robert Hancock" <hancockr@shaw.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <456BAEB0.5030800@vertical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <fa.LC2HgQx8572p2lwOKfUm6cxg95s@ifi.uio.no>
	 <456B8517.7040502@shaw.ca> <456BAEB0.5030800@vertical.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/06, Jon Ringle <jringle@vertical.com> wrote:
> Robert Hancock wrote:
> > Jon Ringle wrote:
> >> Hi,
> >>
> >> I need to reserve a page of memory at a specific area of RAM that will
> >> be used as a "shared memory" with another processor over PCI. How can I
> >> ensure that the this area of RAM gets reseved so that the Linux's memory
> >> management (kmalloc() and friends) don't use it?
> >>
> >> Some things that I've considered are iotable_init() and ioremap().
> >> However, I've seen these used for memory mapped IO devices which are
> >> outside of the RAM memory. Can I use them for reseving RAM too?
> >>
> >> I appreciate any advice in this regard.
> >
> > Sounds to me like dma_alloc_coherent is what you want..
> >
> It looks promising, however, I need to reserve a physical address area
> that is well known (so that the code running on the other processor
> knows where in PCI memory to write to). It appears that
> dma_alloc_coherent returns the address that it allocated. Instead I need
> something where I can tell it what physical address and range I want to use.
>

I've seen other projects just boot a 128M board with mem=120M and just
use the 8MB at 120 to talk to the other processor..

Dave.
