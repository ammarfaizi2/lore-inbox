Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269569AbRHHVre>; Wed, 8 Aug 2001 17:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269570AbRHHVrZ>; Wed, 8 Aug 2001 17:47:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:39563 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269569AbRHHVrJ>;
	Wed, 8 Aug 2001 17:47:09 -0400
Date: Wed, 8 Aug 2001 17:47:19 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <9ksa6j$jo7$1@cesium.transmeta.com>
Message-ID: <Pine.GSO.4.21.0108081742350.22542-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 8 Aug 2001, H. Peter Anvin wrote:

> Followup to:  <Pine.GSO.4.21.0108071510390.18565-100000@weyl.math.psu.edu>
> By author:    Alexander Viro <viro@math.psu.edu>
> In newsgroup: linux.dev.kernel
> > 
> > It is not reliable. E.g. on NFS inumbers are not unique - 32 bits is
> > not enough.
> > 
> 
> Unfortunately there is a whole bunch of other things too that rely on
> it, and *HAVE* to rely on it -- (st_dev, st_ino) are defined to
> specify the identity of a file, and if the current types aren't large
> enough we *HAVE* to go to new types.  THERE IS NO OTHER WAY TO TEST
> FOR FILE IDENTITY IN UNIX, and being able to perform such a test is
> vital for many things, including security and hard link detection

Indeed, but it still doesn't help libc5 getcwd(3), which uses 32 bit
values.

> (think tar, cpio, cp -a.)

I'd rather not.  Too bloody depressive... (If you want details - let's
take it off-list).

