Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129203AbQJaItb>; Tue, 31 Oct 2000 03:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129371AbQJaItV>; Tue, 31 Oct 2000 03:49:21 -0500
Received: from [62.172.234.2] ([62.172.234.2]:40373 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129203AbQJaItP>;
	Tue, 31 Oct 2000 03:49:15 -0500
Date: Tue, 31 Oct 2000 08:49:02 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Brian Gerst <bgerst@didntduck.org>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: kmalloc() allocation.
In-Reply-To: <39FE6291.FA8162A7@didntduck.org>
Message-ID: <Pine.LNX.4.21.0010310846490.1494-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2000, Brian Gerst wrote:

> "H. Peter Anvin" wrote:
> > 
> > Followup to:  <Pine.LNX.3.95.1001030133720.3346A-100000@chaos.analogic.com>
> > By author:    "Richard B. Johnson" <root@chaos.analogic.com>
> > In newsgroup: linux.dev.kernel
> > >
> > > > 64K probably less. kmalloc allocates physically linear spaces. vmalloc will
> > > > happily grab you 2Mb of space but it will not be physically linear
> > > >
> > >
> > > Okay. Thanks.
> > >
> > 
> > FWIW, vmalloc()-allocated pages are definitely pinned-down and
> > available to interrupts.  However, you should keep in mind that the
> > vmalloc() call *itself* is quite expensive on SMP machines (have to
> > interrupt all CPUs and flush their TLBs!!) so if you're using
> > vmalloc(), be careful with the number of calls you make.  Of course,
> > this is usually not a problem.
> 
> This was just changed in 2.4 so that vmalloced pages are faulted in on
> demand.

what do you mean?! That is, of course, impossible because it would break
all existing software, so I won't even bother checking the code, safely 
assuming that you perhaps meant something else, ok?

Thanks,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
