Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSEKDoe>; Fri, 10 May 2002 23:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316221AbSEKDod>; Fri, 10 May 2002 23:44:33 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:27869 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316210AbSEKDod>;
	Fri, 10 May 2002 23:44:33 -0400
Date: Fri, 10 May 2002 23:44:23 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: linux-kernel@vger.kernel.org, kaos@ocs.com.au
Subject: Re: [PATCH] iget-locked [2/6]
In-Reply-To: <20020511030437.GA29392@ravel.coda.cs.cmu.edu>
Message-ID: <Pine.GSO.4.21.0205102317410.20383-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 May 2002, Jan Harkes wrote:

> On Sat, May 11, 2002 at 12:48:46PM +1000, Keith Owens wrote:
> > On Fri, 10 May 2002 21:21:16 -0500 (CDT), 
> > Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> wrote:
> > >This is not true anymore in 2.5, this limitation was removed when ALSA 
> > >went in.
> > 
> > True, but if the iget change goes into 2.5 it will probably be
> > backported to 2.4 later, 2.4 still has the restriction.
> > 
> > As for modversions on 2.5, well you know my opinion ;).
> 
> A backport is not that likely. The patch removes iget4 and as a result
> breaks compatibility for binary-only kernel modules that use iget and/or
> iget4. So, I don't believe this patch is appropriate for a stable series.

It will need decent testing + backport of knfsd changes to 2.4 to become
a candidate for merge.

As for the binary compatibility... as long as we are source-compatible
(i.e. keep ->read_inode2 and provide a compatible iget4()) - compatibility
is not a problem.  Anyone who ships binary-only modules is playing in the
traffic and if they become a roadkill - it's Not Our Problem(tm).  Think
of it as evolution in action...

