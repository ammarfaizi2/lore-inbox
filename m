Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271941AbTG2RzW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 13:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271943AbTG2RxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 13:53:08 -0400
Received: from fubar.phlinux.com ([216.254.54.154]:16602 "EHLO
	fubar.phlinux.com") by vger.kernel.org with ESMTP id S271845AbTG2Ru4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 13:50:56 -0400
Date: Tue, 29 Jul 2003 10:50:53 -0700 (PDT)
From: Matt C <wago@phlinux.com>
To: Hugo Mills <hugo-lkml@carfax.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Meelis Roos <mroos@math.ut.ee>,
       lkml <linux-kernel@vger.kernel.org>, <neilb@cse.unsw.edu.au>
Subject: Re: NFS server broken in 2.4.22-pre6?
In-Reply-To: <20030726151956.GA11253@carfax.org.uk>
Message-ID: <Pine.LNX.4.44.0307291048590.189-100000@fubar.phlinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if this is related or not, but I noticed that on old 
redhat-6.2 (glibc-2.1.3) systems, portmap dies instantly under 2.4.21+ 
kernels. Older 2.4.18 kernels worked fine. It exits with -EBADF. I can get 
a complete strace if that's interesting. I tested the portmap binary from 
redhat-7.2 (which works under redhat-7.2) in the 6.2 environment, and it 
had the same problem, so it's not portmap itself.

-matt c

On Sat, 26 Jul 2003, Hugo Mills wrote:

> On Fri, Jul 25, 2003 at 10:05:33AM -0300, Marcelo Tosatti wrote:
> > 
> > 
> > On Thu, 24 Jul 2003, Meelis Roos wrote:
> > 
> > > NFS serving seems to be broken in 2.4.22-pre6. I had 2 computers running
> > > 2.4.22-pre6 (x86, debian unstable current). Tried to acces them via NFS
> > > (using am-utils actually) from a 3rd computer, IO error. Tried to
> > > mount directly, mount: RPC: timed out. Rebooted one computer to 2.4.18
> > > and NFS started to work.
> > >
> > > No more details currently but I can test more thoroughly tomorrow.
> > 
> > Meelis,
> > 
> > Please report more details.
> 
>    I'm also having trouble with NFS, with a 2.4.22-pre6-ac1 server.
> 
>    I'm booting a diskless workstation (with a 2.4.21-ac1 client), and
> it will boot and mount the root filesystem. When I try to mount any
> other filesystems, the client reports
> 
> mount: can't get address for vlad
> 
> and loses the main NFS mount: attempts to access any file on the root
> filesystem gives stale NFS file handle errors. The failure to mount
> also breaks the server -- I can no longer boot the diskless client.
> Restarting the NFS server allows me to boot the client once again.
> 
>    Like Meelis, I'm also using Debian unstable, and I've tried with
> both the 1.0.3-1 and 1.0.5 versions of the nfs-tools on both machines.
> Both versions give the same error that I reported above.
> 
>    Hugo.
> 
> 

