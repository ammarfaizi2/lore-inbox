Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263490AbTJBTAm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 15:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263488AbTJBTAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 15:00:42 -0400
Received: from genericorp.net ([69.56.190.66]:2226 "EHLO
	narbuckle.genericorp.net") by vger.kernel.org with ESMTP
	id S263476AbTJBTAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 15:00:37 -0400
Date: Thu, 2 Oct 2003 14:00:25 -0500 (CDT)
From: Dave O <cxreg@pobox.com>
X-X-Sender: count@narbuckle.genericorp.net
To: Roman Zippel <zippel@linux-m68k.org>
cc: linux-hfsplus-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] new HFS(+) driver
In-Reply-To: <Pine.LNX.4.44.0310022028220.8124-100000@serv>
Message-ID: <Pine.LNX.4.58.0310021359140.31213@narbuckle.genericorp.net>
References: <Pine.LNX.4.44.0310021029110.17548-100000@serv>
 <Pine.LNX.4.58.0310021300220.31213@narbuckle.genericorp.net>
 <Pine.LNX.4.44.0310022028220.8124-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Oct 2003, Roman Zippel wrote:
> On Thu, 2 Oct 2003, Dave O wrote:
>
> >  I get this when building your driver (20030930) against 2.6.0-test6:
> >
> > *** Warning: "get_gendisk" [fs/hfsplus/hfsplus.ko] undefined!
> > *** Warning: "get_gendisk" [fs/hfs/hfs.ko] undefined!
> >
> > any idea how to resolve this?
>
> You can simply remove the code block from get_gendisk to put_disk in
> hfsplus/wrapper.c and hfs/mdb.c.
>

This works, however du(1) seems to get the block size wrong:

meatloop:/cdrom# ls -l
total 393244
-rwxr-xr-x    1 501      dialout  341952833 Sep 22 17:24 else.zip
-rwxr-xr-x    1 501      dialout  450701627 Sep 22 20:07 outlook.zip
-rwxr-xr-x    1 501      dialout  607534655 Sep 22 17:26 quick1.zip
-rwxr-xr-x    1 501      dialout  431279243 Sep 22 17:26 quick2.zip
-rwxr-xr-x    1 501      dialout  605501959 Sep 22 17:27 quick3.zip
-rwxr-xr-x    1 501      dialout  403836898 Sep 22 17:28 quick4.zip
-rwxr-xr-x    1 501      dialout  380636073 Sep 22 17:28 quick5.zip

meatloop:/cdrom# du -sh
385M    .


