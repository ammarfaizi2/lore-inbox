Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263408AbTJBSC1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 14:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263411AbTJBSC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 14:02:27 -0400
Received: from genericorp.net ([69.56.190.66]:33712 "EHLO
	narbuckle.genericorp.net") by vger.kernel.org with ESMTP
	id S263408AbTJBSCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 14:02:24 -0400
Date: Thu, 2 Oct 2003 13:02:10 -0500 (CDT)
From: Dave O <cxreg@pobox.com>
X-X-Sender: count@narbuckle.genericorp.net
To: Roman Zippel <zippel@linux-m68k.org>
cc: linux-hfsplus-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] new HFS(+) driver
In-Reply-To: <Pine.LNX.4.44.0310021029110.17548-100000@serv>
Message-ID: <Pine.LNX.4.58.0310021300220.31213@narbuckle.genericorp.net>
References: <Pine.LNX.4.44.0310021029110.17548-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Roman

 I get this when building your driver (20030930) against 2.6.0-test6:

*** Warning: "get_gendisk" [fs/hfsplus/hfsplus.ko] undefined!
*** Warning: "get_gendisk" [fs/hfs/hfs.ko] undefined!

any idea how to resolve this?

On Thu, 2 Oct 2003, Roman Zippel wrote:

> Hi,
>
> This is a rather big update to the HFS+ driver. It includes now also an
> updated HFS driver. Both drivers use now almost the same btree code and
> the general structure is very similiar, so one day it will be possible to
> merge both drivers. The HFS driver got a major cleanup and a lot of broken
> options were removed, most notably if you want to continue using netatalk
> with this driver, you have to fix netatalk first.
>
> The HFS+ driver has a number of improvements and fixes:
> - blocks are now preallocated.
> - allocation file is now in the page cache too
> - better extent caching
> - btrees are now able to grow arbitrarily
> - allocation block size can now be larger than a page
> - actual fs block size is adjusted to avoid alignment problems
> - cdrom session/partition support (note that this is a crutch and has
>   problems)
>
> This is basically the version I'd liked to get merged into 2.6 (minus lots
> of ifdefs and some debug prints). You can find the driver at
> http://www.ardistech.com/hfsplus/
>
> bye, Roman
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
