Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263289AbREWWMP>; Wed, 23 May 2001 18:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263290AbREWWMF>; Wed, 23 May 2001 18:12:05 -0400
Received: from voyager.powersurfr.com ([24.109.67.8]:57611 "EHLO
	unity.starfire") by vger.kernel.org with ESMTP id <S263289AbREWWL6>;
	Wed, 23 May 2001 18:11:58 -0400
From: Maciek Nowacki <maciek@Voyager.powersurfr.com>
Date: Wed, 23 May 2001 16:11:49 -0600
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Busy on BLKFLSBUF w/initrd
Message-ID: <20010523161149.A701@Voyager.powersurfr.com>
In-Reply-To: <20010523154843.A32583@Voyager.powersurfr.com> <Pine.GSO.4.21.0105231753270.20269-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.GSO.4.21.0105231753270.20269-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, May 23, 2001 at 06:05:52PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2001 at 06:05:52PM -0400, Alexander Viro wrote:
> 
> 
> On Wed, 23 May 2001, Maciek Nowacki wrote:
> 
> > May 22 09:14:31 wintermute kernel: RAMDISK: romfs filesystem found at block 0
> > May 22 09:14:31 wintermute kernel: RAMDISK: Loading 28216 blocks [1 disk] into ram disk... done.
> > May 22 09:14:31 wintermute kernel: Freeing initrd memory: 28216k freed
> > May 22 09:14:31 wintermute kernel: VFS: Mounted root (romfs filesystem) readonly.
> > May 22 09:14:31 wintermute kernel: Mounted devfs on /dev
> > May 22 09:14:31 wintermute kernel: VFS: Mounted root (romfs filesystem) readonly.
> > May 22 09:14:31 wintermute kernel: change_root: old root has d_count=7
> > May 22 09:14:31 wintermute kernel: Mounted devfs on /dev
> > May 22 09:14:31 wintermute kernel: Trying to unmount old root ... okay
> 
> At that point /dev/ram0 _is_ killed.

Really? Because I can still mount it later on without any trouble at all..
after init has started. Hmm, I will try later after running the system for a
while to see if the data is still comprehensible.

> > Perhaps they're bumping up the reference count so that it is impossible to
> > free the ramdisk later?
> 
> If you want to keep it until later (i.e. want to destiry it by hands)
> mkdir /initrd on your final root and old one will be remounted there.
> Again, "Trying to unmount old root ... okay" means that it already got
> an equivalent of BKLFLSBUF

Ah, okay.. I assumed this behavior had been removed. I will try this as well.

Maciek
