Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277791AbRJRQR7>; Thu, 18 Oct 2001 12:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277782AbRJRQRu>; Thu, 18 Oct 2001 12:17:50 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:14069 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277791AbRJRQRj>;
	Thu, 18 Oct 2001 12:17:39 -0400
Date: Thu, 18 Oct 2001 12:18:12 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Kamil Iskra <kamil@science.uva.nl>, Steve Kieu <haiquy@yahoo.com>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: Poor floppy performance in kernel 2.4.10
In-Reply-To: <20011018092837.C1144@turbolinux.com>
Message-ID: <Pine.GSO.4.21.0110181217120.21021-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Oct 2001, Andreas Dilger wrote:

> I think this is a result of the "blockdev in pagecache" change added in
> 2.4.10.  One of the byproducts of this change is that if a block device
> is closed (no other openers) then all of the pages from this device are
> dropped from the cache.  In the case of a floppy drive, this is very
> important, as you don't want to be cacheing data from one floppy after
> you have inserted a new floppy.


RTFS.  That _exactly_ matches the behaviour of buffer-cache variant.

