Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWBCKZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWBCKZc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 05:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWBCKZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 05:25:32 -0500
Received: from witte.sonytel.be ([80.88.33.193]:12683 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751156AbWBCKZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 05:25:31 -0500
Date: Fri, 3 Feb 2006 11:24:30 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Akinobu Mita'" <mita@miraclelinux.com>,
       Grant Grundler <iod00d@hp.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH 1/12] generic *_bit()
In-Reply-To: <20060201191957.GG3072@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.62.0602031123190.30934@pademelon.sonytel.be>
References: <20060201180237.GA18464@infradead.org> <200602011807.k11I7ag15563@unix-os.sc.intel.com>
 <20060201191957.GG3072@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Feb 2006, Russell King wrote:
> On Wed, Feb 01, 2006 at 10:07:28AM -0800, Chen, Kenneth W wrote:
> > Christoph Hellwig wrote on Wednesday, February 01, 2006 10:03 AM
> > > > Akinobu Mita wrote on Wednesday, January 25, 2006 7:29 PM
> > > > > This patch introduces the C-language equivalents of the functions below:
> > > > > 
> > > > > - atomic operation:
> > > > > void set_bit(int nr, volatile unsigned long *addr);
> > > > > void clear_bit(int nr, volatile unsigned long *addr);
> > > > > void change_bit(int nr, volatile unsigned long *addr);
> > > > > int test_and_set_bit(int nr, volatile unsigned long *addr);
> > > > > int test_and_clear_bit(int nr, volatile unsigned long *addr);
> > > > > int test_and_change_bit(int nr, volatile unsigned long *addr);
> > > > 
> > > > I wonder why you did not make these functions take volatile
> > > > unsigned int * address argument?
> > > 
> > > Because they are defined to operate on arrays of unsigned long
> > 
> > I think these should be defined to operate on arrays of unsigned int.
> > Bit is a bit, no matter how many byte you load (8/16/32/64), you can
> > only operate on just one bit.
> 
> Invalid assumption, from the point of view of endianness across different
> architectures.  Consider where bit 0 is for a LE and BE unsigned long *
> vs a LE and BE unsigned char *.

Intel doesn't care about big endian (cfr. your lkml back issues of January
2006).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
