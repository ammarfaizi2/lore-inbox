Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310372AbSCAHyR>; Fri, 1 Mar 2002 02:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310379AbSCAHuk>; Fri, 1 Mar 2002 02:50:40 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:5800 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S310371AbSCAHr2>;
	Fri, 1 Mar 2002 02:47:28 -0500
Date: Fri, 1 Mar 2002 02:47:26 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Val Henson <val@nmt.edu>,
        "Randy.Dunlap" <rddunlap@osdl.org>, Laurent <laurent@augias.org>,
        linux-kernel@vger.kernel.org
Subject: Re: read_proc issue
In-Reply-To: <20020301071410.GA11256@arthur.ubicom.tudelft.nl>
Message-ID: <Pine.GSO.4.21.0203010245150.2886-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Mar 2002, Erik Mouw wrote:

> On Wed, Feb 27, 2002 at 04:19:35AM +0100, Daniel Phillips wrote:
> > On February 28, 2002 01:05 am, Erik Mouw wrote:
> > > It might also be an idea to export proc_calc_metrics() from
> > > fs/proc/proc_misc.c because quite a lot of code actually tries to do
> > > exactly the same.
> > 
> > Look at all the parameters, they're trying to be a struct.  How about
> > cleaning it up before exporting?
> 
> Look at all the parameters of a procfs read() function and compare them
> with the parameters of proc_calc_metrics(). See why cleaning up
> would make things only more complicated?

Oh, for fsck sake...

We already have better mechanism.  Let ->proc_read() die, it's an ugly
kludge, breeding overcomplicated code and buffer overflows.

