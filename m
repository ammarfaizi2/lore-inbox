Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286283AbSAEWhy>; Sat, 5 Jan 2002 17:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286311AbSAEWhp>; Sat, 5 Jan 2002 17:37:45 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62772 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S286283AbSAEWhe>; Sat, 5 Jan 2002 17:37:34 -0500
To: Alexander Viro <viro@math.psu.edu>
Cc: Legacy Fishtank <garzik@havoc.gtf.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre2 forces ramfs on
In-Reply-To: <Pine.GSO.4.21.0112261228180.2716-100000@weyl.math.psu.edu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Jan 2002 15:35:15 -0700
In-Reply-To: <Pine.GSO.4.21.0112261228180.2716-100000@weyl.math.psu.edu>
Message-ID: <m1r8p4s9y4.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:

> On Wed, 26 Dec 2001, Legacy Fishtank wrote:
> 
> > On Wed, Dec 26, 2001 at 03:04:40PM +0000, Alan Cox wrote:
> > > > Because it's small, and if it wasn't there, we'd have to have the small
> > > > "rootfs" anyway (which basically duplicated ramfs functionality).
> > > 
> > > Can ramfs=N longer term actually come back to be "use __init for the RAM
> > > fs functions". That would seem to address any space issues even the most 
> > > embedded fanatic has. 
> > 
> > Nifty idea... We could use __rootfs or similar in the module.
> 
> Um, folks - rootfs does _not_ go away after you mount final root over it.
> Having absolute root always there makes life much simpler in a lot of
> places...
> 
> What's more, quite a few ramfs methods are good candidates for library
> functions, since they are already shared with other filesystems and
> number of such cases is going to grow.

I guess this is o.k.  Assuming we get good code sharing between ramfs/rootfs
and shmfs.  As those both seem to be always compiled in.

Eric
