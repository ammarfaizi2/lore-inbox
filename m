Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286148AbRLZE0k>; Tue, 25 Dec 2001 23:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286150AbRLZE03>; Tue, 25 Dec 2001 23:26:29 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:51925 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S286148AbRLZE0T>;
	Tue, 25 Dec 2001 23:26:19 -0500
Date: Tue, 25 Dec 2001 23:26:18 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre2 forces ramfs on
In-Reply-To: <2452.1009338062@ocs3.intra.ocs.com.au>
Message-ID: <Pine.GSO.4.21.0112252319300.1105-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Dec 2001, Keith Owens wrote:

> Index: 2-pre1.1/fs/Config.in
> --- 2-pre1.1/fs/Config.in Sat, 24 Nov 2001 05:28:08 +1100 kaos (linux-2.5/F/d/27_Config.in 1.1 644)
> +++ 2-pre2.1/fs/Config.in Wed, 26 Dec 2001 14:32:39 +1100 kaos (linux-2.5/F/d/27_Config.in 1.2 644)
> @@ -45,7 +45,7 @@ if [ "$CONFIG_JFFS2_FS" = "y" -o "$CONFI
>  fi
>  tristate 'Compressed ROM file system support' CONFIG_CRAMFS
>  bool 'Virtual memory file system support (former shm fs)' CONFIG_TMPFS
> -tristate 'Simple RAM-based file system support' CONFIG_RAMFS
> +define_bool CONFIG_RAMFS y
> 
> Why is ramfs forced on?

Because it's always used for rootfs - notice a bunch of crap disappearing
from the end of fs/namespace.c.  In principle, we can keep the config item
and make the first DECLARE_FSTYPE in ramfs/inode.c conditional, but that
will only make ramfs invisible - code still needs to be compiled in.
 
> And why is Al Viro's email address not in CREDITS or MAINTAINERS?  We
> should have somewhere to complain to ;).

<shrug>  I _do_ read l-k.

