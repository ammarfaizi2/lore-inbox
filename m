Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315443AbSEBVnS>; Thu, 2 May 2002 17:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315444AbSEBVnR>; Thu, 2 May 2002 17:43:17 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:6535 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315443AbSEBVm7>;
	Thu, 2 May 2002 17:42:59 -0400
Date: Thu, 2 May 2002 17:42:56 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: tomas szepe <kala@pinerecords.com>
cc: Keith Owens <kaos@ocs.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <20020502213443.GA10617@louise.pinerecords.com>
Message-ID: <Pine.GSO.4.21.0205021738410.17171-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 May 2002, tomas szepe wrote:
 
> '/usr/include/asm' points to '/usr/src/linux/include/asm', which doesn't
> exist at this moment. It seems to me that kbuild 2.5 makes the assumption
> that the 'asm' symlink in /usr/include already determines the machine
> architecture type by pointing to a concrete asm-$arch
> in /usr/src/linux/include.

Sigh...  Configurations with /usr/include/{linux,asm} being symlinks
are BROKEN.  Please, look through the archives - it had been discussed
a lot of times.  Userland has no business using kernel headers directly
and that's precisely what had bitten you - setup where /usr/include/asm
comes not from libc but from the (currently being built) kernel.

