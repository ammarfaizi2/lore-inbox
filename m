Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132133AbRAKSmC>; Thu, 11 Jan 2001 13:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132292AbRAKSlv>; Thu, 11 Jan 2001 13:41:51 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:46543 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132133AbRAKSlh>;
	Thu, 11 Jan 2001 13:41:37 -0500
Date: Thu, 11 Jan 2001 13:41:34 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@innominate.de>
cc: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        linux-kernel@vger.kernel.org
Subject: Re: Strange umount problem in latest 2.4.0 kernels
In-Reply-To: <3A5DFC64.2969D25E@innominate.de>
Message-ID: <Pine.GSO.4.21.0101111337250.17363-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Jan 2001, Daniel Phillips wrote:

> "Udo A. Steinberg" wrote:
> > Upon fscking after reboot, I always have errors on a
> > single inode and it's always the same one:
> > 
> > /dev/hdb1: Inode 522901, i_blocks is 64, should be 8. FIXED
> > 
> > Can someone tell me an easy and reliable way of figuring
> > out which file (program) uses said inode? I think that's
> > probably the key to figuring out why the partition is
> > busy on umount.
> 
> ls -iR | grep 12345

find `mount | grep hdb1 | cut -f3 -d' '` -inum 522901 -xdev

- no need to walk through all filesystems.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
