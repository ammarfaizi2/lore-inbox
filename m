Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316675AbSG3VjR>; Tue, 30 Jul 2002 17:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316678AbSG3VjR>; Tue, 30 Jul 2002 17:39:17 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:7120 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316675AbSG3VjN>;
	Tue, 30 Jul 2002 17:39:13 -0400
Date: Tue, 30 Jul 2002 17:42:32 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Brad Hards <bhards@bigpond.net.au>, Greg KH <greg@kroah.com>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net
Subject: Re: [patch] Input cleanups for 2.5.29 [2/2]
In-Reply-To: <Pine.LNX.4.33.0207301433480.2051-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0207301738090.6010-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Jul 2002, Linus Torvalds wrote:

> 
> On Wed, 31 Jul 2002, Brad Hards wrote:
> > 
> > We shouldn't arbitrarily invent new types that could be trivially done with 
> > standard types. Maybe we could retain existing usage for ABIs that are
> > unchanged from 2.0 days, but we certainly shouldn't be making the ABI
> > any worse.
> 
> I disagree. 
> 
> I actively _dislike_ those stupid standard typenames. I don't want them in 
> the kernel, and they have no advantages over the standard kernel types 
> that have been there for a _loong_ time.

Strictly speaking, there might be a DISadvantage - IIRC, there's nothing to
stop gcc from
#define uint8_t unsigned long long	/* it is at least 8 bits */
ICBW, but wasn't uint<n>_t only promised to be at least <n> bits?

