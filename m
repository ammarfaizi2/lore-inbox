Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbQL1OFL>; Thu, 28 Dec 2000 09:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129568AbQL1OFB>; Thu, 28 Dec 2000 09:05:01 -0500
Received: from hera.cwi.nl ([192.16.191.1]:31111 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129464AbQL1OE5>;
	Thu, 28 Dec 2000 09:04:57 -0500
Date: Thu, 28 Dec 2000 14:34:29 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Christoph Rohland <cr@sap.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Dave Gilbert <gilbertd@treblig.org>
Subject: Re: [Patch] shmmin behaviour back to 2.2 behaviour
Message-ID: <20001228143429.A1402@veritas.com>
In-Reply-To: <m3d7eeb1pa.fsf@linux.local> <Pine.LNX.4.21.0012271316020.11471-100000@freak.distro.conectiva> <20001227215703.A1302@veritas.com> <m3wvck99wx.fsf@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <m3wvck99wx.fsf@linux.local>; from cr@sap.com on Thu, Dec 28, 2000 at 01:01:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2000 at 01:01:53PM +0100, Christoph Rohland wrote:

> > My first reaction is that this patch is broken, since
> > one usually specifies size 0 in shmget to get an existing
> > bit of shared memory

> That's still covered: The check is moved out of shmget into the create
> function. So you cannot create segments of size 0 but you can get
> existing segments by giving a size 0.

Good. (The patch fragment gave the impression that 0 would be illegal.)

> We don't match this exactly since we allow arbitrary sizes smaller
> than segment size for existing segments (0 included).

Good.

> So should we go for SUSv2?

No.
I regard shm* as obsolete. New programs will probably not use it.
So, the less we change the better. Moreover, the SUSv2 text is broken.

One of these years the present Austin drafts will turn into the
new POSIX standard. That would be a good moment to look again.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
