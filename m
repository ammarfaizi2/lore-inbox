Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288308AbSACVbZ>; Thu, 3 Jan 2002 16:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288320AbSACVbP>; Thu, 3 Jan 2002 16:31:15 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:30620 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S288308AbSACVbA>;
	Thu, 3 Jan 2002 16:31:00 -0500
Date: Thu, 3 Jan 2002 16:30:55 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: State of the new config & build system 
In-Reply-To: <20733.1010090809@ocs3.intra.ocs.com.au>
Message-ID: <Pine.GSO.4.21.0201031623580.23693-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Jan 2002, Keith Owens wrote:

> On Thu, 3 Jan 2002 15:35:19 -0500 (EST), 
> Alexander Viro <viro@math.psu.edu> wrote:
> >On Thu, 3 Jan 2002, Dave Jones wrote:
> >> And being able to NFS share 1 kernel tree, and be able to do parallel
> >> builds on multiple boxes without having to wait until 1 is finished.
> >
> >	Sigh...  As soon as we get to prototype change in
> >getattr()/setattr()/permission() - we get CoW fs.  I.e. equivalent of
> >*BSD unionfs.  I hope to get around to that stuff around 2.5.4 or so.
> 
> Unionfs and cow fs will be nice but kernel build will not use it.
> Users can build a Linux kernel on other operating systems, including
> Solaris, Irix, Cygwin etc.  kbuild requires a Posix compliant fs and
> GNU tools, but it must not use additional fs features that only exist
> on Linux or only on specific versions of Linux.

<shrug> kernel build doesn't have to use it - if I mount a writable layer
atop of the clean tree and build in the resulting tree, build system
doesn't need to have any idea of that fact.  That's the point - you are
emulating the thing that is generally useful and belongs to different
layer - namely, the kernel.

