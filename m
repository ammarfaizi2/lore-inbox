Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271717AbRICNyH>; Mon, 3 Sep 2001 09:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271715AbRICNxr>; Mon, 3 Sep 2001 09:53:47 -0400
Received: from hera.cwi.nl ([192.16.191.8]:13019 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S271714AbRICNxg>;
	Mon, 3 Sep 2001 09:53:36 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 3 Sep 2001 13:53:07 GMT
Message-Id: <200109031353.NAA32321@vlet.cwi.nl>
To: torvalds@transmeta.com, viro@math.psu.edu
Subject: Re: [PATCH] cleanup in fs/super.c (do_kern_mount())
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Alexander Viro <viro@math.psu.edu>

    New helper function: do_kern_mount() (aka. kern_mount() donw right).

    +#define MS_NOUSER    (1<<31)

But you introduce a new, undocumented, mount flag?

(It seems a pity to take away from the scarce resource
"bits in the mount flag" for kernel-internal purposes.
Today 14 bits (of the 16) are in use, and as soon as we'll need
the 17th, mount will stop adding this 0xC0ED0000 flag, and
we'll have 15 or 16 additional bits.

On the other hand, if you think this bit is also useful from
user space, then the use should be documented.)

Andries
