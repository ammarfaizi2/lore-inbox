Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267904AbRG3Uth>; Mon, 30 Jul 2001 16:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267890AbRG3Ut1>; Mon, 30 Jul 2001 16:49:27 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:34272 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S267885AbRG3UtI>;
	Mon, 30 Jul 2001 16:49:08 -0400
Date: Mon, 30 Jul 2001 16:49:15 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Mike Touloumtzis <miket@bluemug.com>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] initramfs patch
In-Reply-To: <20010730132957.A20284@bluemug.com>
Message-ID: <Pine.GSO.4.21.0107301646050.19391-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Mon, 30 Jul 2001, Mike Touloumtzis wrote:

> On Mon, Jul 30, 2001 at 02:05:55AM -0400, Alexander Viro wrote:
> > 
> > The thing unpacks cpio archive (currently - linked into the kernel image)
> > on root ramfs and execs /init. After that we are in userland code. Said
> > code (source in init/init.c and init/nfsroot.c) emulates the vanilla
> > 2.4 behaviour. You can replace it with your own - that's just the default
> > that gives (OK, is supposed to give) a backwards-compatible behaviour.
> 
> One thing that would make embedded systems developers very happy
> is the ability to map a romfs or cramfs filesystem directly from
> the kernel image, avoiding the extra copy necessitated by the cpio
> archive.  Are there problems with this approach?

a) IIRC, both are read-only.
b) what stops you from doing initramfs + romfs-on-initrd? It works.

