Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291329AbSBGVhh>; Thu, 7 Feb 2002 16:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291331AbSBGVh1>; Thu, 7 Feb 2002 16:37:27 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:2473 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S291329AbSBGVhM>;
	Thu, 7 Feb 2002 16:37:12 -0500
Date: Thu, 7 Feb 2002 16:37:07 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Patrick Mochel <mochel@osdl.org>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] read() from driverfs files can read more bytes 
In-Reply-To: <Pine.LNX.4.33.0202071252010.25114-100000@segfault.osdlab.org>
Message-ID: <Pine.GSO.4.21.0202071634500.25715-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Feb 2002, Patrick Mochel wrote:

> issues discussed in this thread. What's even nicer is that if I convert to 
> that, driver callbacks become something like either:
> 
> int driver_show(struct device * dev, struct seq_file * m)
> 
> or 
> 
> int driver_show(struct device * dev, char * buf)

Preferably the former.
 
> Have you considered doing write()?

I had and that's going to be resurrected when remount() will be dealt
with (options-parsing both benefits a lot from and is a good testbed for
such helpers).

