Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQKSM6T>; Sun, 19 Nov 2000 07:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129473AbQKSM6J>; Sun, 19 Nov 2000 07:58:09 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:29194 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129408AbQKSM5y>;
	Sun, 19 Nov 2000 07:57:54 -0500
Date: Sun, 19 Nov 2000 13:27:49 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swap=<device> kernel commandline
Message-ID: <20001119132749.A31695@almesberger.net>
In-Reply-To: <20001118141524.A15214@nic.fr> <Pine.LNX.4.21.0011181804360.9267-100000@duckman.distro.conectiva> <20001118223455.G23033@almesberger.net> <m11yw86byt.fsf@frodo.biederman.org> <20001119030345.F23030@almesberger.net> <m1snoo4dw0.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1snoo4dw0.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sun, Nov 19, 2000 at 12:30:55AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Hmm. What does it take to mount an NFS partition?

Mainly Sun RPC :-(

> Anyway.  All I did was wrote a tiny libc that is just a bunch of
> wrappers for syscalls, and some string functions.

Certainly a good approach. It's also basically the idea behind newlib,
although newlib has more overhead.

Ultimately, I want to be able to compile regular Unix/Linux programs
out of the box. Right now, this works for a bunch of trivial programs,
and it almost works for ash.

> Now if glibc wouldn't link in 200k of unused crap when you make a
> trivial static binary I'd much prefer to use it...

Precisely why I went to newlib ... It's really a pity that glibc is
such a monster.

> Though I wish it was possible to have a ramfs preloader instead of
> initrd.  An initramfs would allow me to not even compile in the block
> device driver layer, and be more efficient.

Hmm, this would be tricky. You could do it by implementing a simple
tar file reader in the kernel, which reads from /dev/initrd (well, it's
in-kernel representation), but I'm not sure if this buys you that much
in the end. (How much overhead is in block devices anyway ?)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
