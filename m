Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316845AbSG3V7Y>; Tue, 30 Jul 2002 17:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316857AbSG3V7Y>; Tue, 30 Jul 2002 17:59:24 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:50409 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316845AbSG3V7W>;
	Tue, 30 Jul 2002 17:59:22 -0400
Date: Tue, 30 Jul 2002 18:02:44 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Brad Hards <bhards@bigpond.net.au>
cc: Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net
Subject: Re: [patch] Input cleanups for 2.5.29 [2/2]
In-Reply-To: <200207310747.35605.bhards@bigpond.net.au>
Message-ID: <Pine.GSO.4.21.0207301755200.6010-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 31 Jul 2002, Brad Hards wrote:

> On Wed, 31 Jul 2002 07:42, Alexander Viro wrote:
> <snip>
> > Strictly speaking, there might be a DISadvantage - IIRC, there's nothing to
> > stop gcc from
> > #define uint8_t unsigned long long	/* it is at least 8 bits */
> Here is an extract from <linux/types.h>
> typedef         __u8            uint8_t;
> typedef         __u16           uint16_t;
> 
> > ICBW, but wasn't uint<n>_t only promised to be at least <n> bits?
> I am not sure I understand the point you are trying to make.

The difference between compiler's "unsigned at least n bits" and kernel's
"unsigned exactly n bits".  They may very well be the same on all platforms
we are interested in presuming that compiler is sane, but at the very least
the implied meaning is different.


