Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131513AbRCNUWR>; Wed, 14 Mar 2001 15:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131516AbRCNUWH>; Wed, 14 Mar 2001 15:22:07 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:40902 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131513AbRCNUV7>;
	Wed, 14 Mar 2001 15:21:59 -0500
Date: Wed, 14 Mar 2001 15:21:17 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>,
        linux-kernel@vger.kernel.org
Subject: Re: system call for process information?
In-Reply-To: <Pine.LNX.4.30.0103142206460.13864-100000@fs131-224.f-secure.com>
Message-ID: <Pine.GSO.4.21.0103141517380.4468-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Mar 2001, Szabolcs Szakacsits wrote:

> 
> On Wed, 14 Mar 2001, Alexander Viro wrote:
> > On Wed, 14 Mar 2001, Szabolcs Szakacsits wrote:
> > > read() doesn't really work for this purpose, it blocks way too many
> > > times to be very annoying. When finally data arrives it's useless.
> > Huh? Take code of your non-blocking syscall. Make it ->read() for
> > relevant file on /proc or wherever else you want it. See read() not
> > blocking...
> 
> Sorry I should have quoted "blocks". Problem isn't with blocking but
> *no* data, no information. In the end you can conclude you know
> *nothing* what happend in the last t time interval - this can be second,
> minutes even with an RT, mlocked, etc process when the load is around 0.

And how will a new syscall avoid the same problems you have with
read()? Again, they can share the payload code - it's a matter
of calling conventions and layout of the output. _That_ part doesn't
take long. If reading is too slow - too bad, changing the syscall
number won't help.

