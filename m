Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287355AbRL3H31>; Sun, 30 Dec 2001 02:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287356AbRL3H3R>; Sun, 30 Dec 2001 02:29:17 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:59537 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S287355AbRL3H3G>;
	Sun, 30 Dec 2001 02:29:06 -0500
Date: Sun, 30 Dec 2001 02:29:03 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <akpm@zip.com.au>
cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        torrey.hoffman@myrio.com, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd
 kern   el panic woes
In-Reply-To: <3C2EBD62.6A98F670@zip.com.au>
Message-ID: <Pine.GSO.4.21.0112300220490.8523-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Dec 2001, Andrew Morton wrote:

> As you pointed out offline, the -ac kernels fixed the problem using
> *both* approaches.  Here's a 2.4.18-pre1 version.  generic_file_write()
> is getting rather icky.
> 
> Please let me know if this looks like the way to proceed, and I'll
> find a way to actually test the thing.
 
Erm...  I don't think so.  Come on - vmtruncate() is obvious candidate
for out-of-line.  Please, look how it was done in 2.4.9-ac*.  BTW,
fs/buffer.c part of patch looks mangled.

