Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbTL1RJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 12:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbTL1RJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 12:09:29 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:25763 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S261735AbTL1RJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 12:09:26 -0500
Message-ID: <3FEF05B2.9184ABA0@sgi.com>
Date: Sun, 28 Dec 2003 10:32:51 -0600
From: Colin Ngam <cngam@sgi.com>
Organization: SGI
X-Mailer: Mozilla 4.79C-SGI [en] (X11; I; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Pat Gefre <pfg@sgi.com>, akpm@osdl.org, davidm@napali.hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updating our sn code in 2.6
References: <20031220122749.A5223@infradead.org> <Pine.SGI.3.96.1031222204757.20064A-100000@fsgi900.americas.sgi.com> <20031223090227.A5027@infradead.org> <3FE85533.E026DE86@sgi.com> <20031223165506.A8624@infradead.org> <3FEC8F0B.A8C30677@sgi.com> <20031228144415.B20391@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

Hi Christoph,

> On Fri, Dec 26, 2003 at 01:42:03PM -0600, Colin Ngam wrote:
> > Hi Christoph,
> >
> > Yes I agree.  However, keep in mind that we are following the ia32/ia64
> > way of getting platforms initialized, via ACPI etc.  What you see as
> > drivers code in sn/io will probably not exist anymore.  All initialization
> > and configuration will be done at the System BIOS level and information
> > passed down to the Linux Kernel via ACPI.  This will take away much
> > code in the kernel.
>
> Well, I've heard this a few times now and life would definitly be simpler

>
> if you're going down that route.  OTOH we all know talk is cheap and code
> speaks, and do you really expect SGI to invest money into doing that for
> the now almost legacy SHUB/PIC based Altixens?  Well, even if SGI does this

SHUB/PIC based Altixens are not Legacy in any form shape or manner.  I expect
these IO Chipsets to drive Altix for the foreseable near future ..

Please do not question my resolve to drive us towards this direction.  Things can
always change, but I am heading this direction.

>
> some day it won't really hurt us to get the code in shape first even if
> it's only use on MIPS IP27/IP35, wouldn't it?

Please, you can do what you want with the maintainer for the MIPs
architecture.  That is not a problem at all.  For ia64 Altix line, we want
to follow what's being done on other ia64 platform.  Is this not the
right approach?  You yourself had mentioned above that this is the
way to go?

>
>
> > We believe that all that will be left in sn/io directory maybe files dealing with
> > DMA mappings(IOMMU).
>
> That's one of the candidates that really should be shared with IP27 and the
> once someone does them the IP30 and IP35 ports.  Really, the basic dma mapping
> code is the same for Bridge/Xbridge/PIC/TIOCP so we should have one driver.
> And once all the IRIX I/O infrastructure depency is ripped out that part of
> pcibr is rather self-contained.  I can send you my latest variant of the
> dma mapping code if you want, but due tue all that stupid renaming of
> structure and macro names it won't compile in your tree.  See why I _really_
> _really_ dislike that silly renaming?  It breaks all those nice efforts
> for code-sharing without any gain.

This code sharing will not be possible when we do all of our initialization
in System BIOS, just like every other ia64 platform.  Moreover, the ia64
Altix line does not support Bridge/Xbridge chipsets and we do not want
to be burdened by these legacy code as we move forward with the ia64
product line.

Thanks.

colin

>
>
> Even IRIX TOT uses the 'old' names, so what is the point of renaming them?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

