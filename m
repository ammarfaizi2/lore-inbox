Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbTLZUTU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 15:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265228AbTLZUTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 15:19:20 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:36297 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S265224AbTLZUTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 15:19:09 -0500
Message-ID: <3FEC8F0B.A8C30677@sgi.com>
Date: Fri, 26 Dec 2003 13:42:03 -0600
From: Colin Ngam <cngam@sgi.com>
Organization: SGI
X-Mailer: Mozilla 4.79C-SGI [en] (X11; I; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Pat Gefre <pfg@sgi.com>, akpm@osdl.org, davidm@napali.hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updating our sn code in 2.6
References: <20031220122749.A5223@infradead.org> <Pine.SGI.3.96.1031222204757.20064A-100000@fsgi900.americas.sgi.com> <20031223090227.A5027@infradead.org> <3FE85533.E026DE86@sgi.com> <20031223165506.A8624@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> On Tue, Dec 23, 2003 at 08:46:11AM -0600, Colin Ngam wrote:
> > You are ofcourse talking about linux/drivers/.. right?
>
> My plans are to move the code to drivers/xtalk/ once it's finished, es.
>
> > IP27 is not a supported architecture under linux/arch/ia64/sn/io/..
> > The IP27 MIPS processor/io hardware(bridge/Xbridge)/BIOS for IP27 are very much
> > different than our SN2 product, supported within the linux/arch/ia64 tree -
> > ia64 processors, IO Chipsets(PIC, TIO(CP,CA)), and System BIOS.
> >
> > Is that not supported under the linux/arch/mips tree?
>
> It's currently supported, but I'm aiming for common code for the common
> parts (pcibr drivers,  xbow driver, hub/shub driver, xtalk discovery,
> some prom interface code).  I've already sent you my merged dma mapping
> code and I have similar code for hub and bridge/xbridge/pic/tiocp level
> pio mapping and xtalk discovery.
>
> There's of course code that will stay in the per-arch directories like
> the lowlevel interrupt code, etc..  Now this isn't something that happens
> from one day to another, but not not putting stones in the way of each
> other would help greatly..

Hi Christoph,

Yes I agree.  However, keep in mind that we are following the ia32/ia64
way of getting platforms initialized, via ACPI etc.  What you see as
drivers code in sn/io will probably not exist anymore.  All initialization
and configuration will be done at the System BIOS level and information
passed down to the Linux Kernel via ACPI.  This will take away much
code in the kernel.

We believe that all that will be left in sn/io directory maybe files dealing with
DMA mappings(IOMMU).  There will not be any PIO mapping code, no
configuration code, no discovery code, no init code etc. etc.  This is more
in line with what we see, with regards to all other ia64 platforms.

This will not take a day either, but we are trying very hard to accomplish this task

as soon as possible.

The direction that you are taking, we believe, is not the right strategy in Linux.

Thanks.

colin


