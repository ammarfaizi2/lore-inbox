Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262617AbUKLVQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbUKLVQH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 16:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbUKLVQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 16:16:06 -0500
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:25411 "EHLO
	longlandclan.hopto.org") by vger.kernel.org with ESMTP
	id S262617AbUKLVOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 16:14:22 -0500
Message-ID: <419527AF.9060001@longlandclan.hopto.org>
Date: Sat, 13 Nov 2004 07:14:23 +1000
From: Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "M. A. Imam" <maimam@wichita.edu>
CC: Ed Schouten <ed@il.fontys.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: howt o remake the kernel
References: <419477AC@webmail.wichita.edu>
In-Reply-To: <419477AC@webmail.wichita.edu>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

M. A. Imam wrote:
> Thanks alot... but i have linux 2.4 would that work? and at what
directory
> level should i run 'make'
>
> Thanks again.

Normally the process is you run 'make' from the root of the kernel
source tree.

The exact process you use to process a working binary depends on the
architecture you're running.  On my main box here (Dual PIII 1GHz), I
use something like:

$ make -j8 bzImage modules

When cross-compilling a kernel for my SGI Indy, I use:
$ make -j8 vmlinux modules CROSS_COMPILE=mips-unknown-linux-gnu-

Similar for my Gateway Microserver (rebadged Cobalt Qube 2):
$ make -j8 vmlinux modules CROSS_COMPILE=mipsel-unknown-linux-gnu-

To the others: What's happening with the Kernel HOWTO?  That guide
covered a lot about how to do this...?

Also, remember that you can use the -C argument to make, to tell it to
change directories first... e.g. 'make -C /path/to/kernel/source' will
do what you want without having to manually 'cd' first.
- --
+-------------------------------------------------------------+
| Stuart Longland -oOo- http://stuartl.longlandclan.hopto.org |
| Atomic Linux Project     -oOo-    http://atomicl.berlios.de |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| I haven't lost my mind - it's backed up on a tape somewhere |
+-------------------------------------------------------------+
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBlSevuarJ1mMmSrkRAoFXAJwLO8uvfzds7ClcAzyrzUIwF8P1bwCfXG01
XDUlXzPr723W7RO3C0+soNs=
=gQcS
-----END PGP SIGNATURE-----
