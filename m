Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263316AbREWX2i>; Wed, 23 May 2001 19:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263317AbREWX22>; Wed, 23 May 2001 19:28:28 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:10712 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263316AbREWX2Q>;
	Wed, 23 May 2001 19:28:16 -0400
Date: Wed, 23 May 2001 19:28:14 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Maciek Nowacki <maciek@Voyager.powersurfr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Busy on BLKFLSBUF w/initrd
In-Reply-To: <20010523172326.A898@wintermute.starfire>
Message-ID: <Pine.GSO.4.21.0105231927090.20269-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 May 2001, Maciek Nowacki wrote:

> On Wed, May 23, 2001 at 06:21:23PM -0400, Alexander Viro wrote:
> I wrote out the contents of /dev/rd/0 a few times and diff'ed with the
> uncompressed image of the initrd on the server. No difference each time. The
> same after digging into swap, turning off swap, running blockdev --flushbufs
> several times (always with BLKFLSBUF: Device or resource busy).
> 
> The next test will be to create an initrd that has the 'initrd' directory..

Not initrd with /initrd in it, final root with /initrd, so that change_root()
had a place to remount the thing on.

