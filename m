Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281423AbRKLL3j>; Mon, 12 Nov 2001 06:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281422AbRKLL3a>; Mon, 12 Nov 2001 06:29:30 -0500
Received: from albatross-ext.wise.edt.ericsson.se ([194.237.142.116]:51679
	"EHLO albatross-ext.wise.edt.ericsson.se") by vger.kernel.org
	with ESMTP id <S281419AbRKLL3V>; Mon, 12 Nov 2001 06:29:21 -0500
From: Miklos.Szeredi@eth.ericsson.se (Miklos Szeredi)
Date: Mon, 12 Nov 2001 12:28:27 +0100 (MET)
Message-Id: <200111121128.MAA15119@duna207.danubius>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        avfs@fazekas.hu
Subject: Introducing FUSE: Filesystem in USErspace
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Had enough of life?  Nothing to do?  Write a filesystem!

What is FUSE?

  FUSE (Filesystem in USErspace) provides a simple interface for
  userspace programs to export a virtual filesystem to the Linux
  kernel.  FUSE also aims to provide a secure method for non
  privileged users to create and mount their own filesystem
  implementations.

There's NFS or CODA. Why FUSE?

  Yes both NFS and CODA make it possible to create userspace
  filesystems.  But none of them were designed for this task.  The
  design of FUSE differs from the above in the following:

    - Ability to provide a _very_ simple userspace library interface.

    - Thin layer in kernel. Minimal caching, predictable behavior.

    - Communication is not over a network, and is optimized for local
      data transfer

    - Secure environment even if userspace client is non-cooperative.

All this is nice, but does it work?

  I've tested fuse with a simple 'loopback' test program, and also
  with AVFS (http://www.inf.bme.hu/~mszeredi/avfs/), for which FUSE
  was designed for.  That doesn't mean that there are no bugs in it,
  but it's a good sign...

Is it available?

  Yes it can be downloaded from

    http://sourceforge.net/projects/avf

How can it be installed?

  FUSE currently works only on 2.4.X kernels.  Installation requires
  the kernel source to be present.  The kernel does not need to be
  patched or recompiled: the kernel part of FUSE is installed as a
  module.  The FUSE module is SMP safe.

  There is also a kernel patch (for kernels 2.4.12 and up) included in
  the distribution, which makes mounting by non-privileged users
  secure.

Comments on design, implementation, and on my state of mind are
welcome.

Miklos
