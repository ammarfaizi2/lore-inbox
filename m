Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131493AbRCNRls>; Wed, 14 Mar 2001 12:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131494AbRCNRlj>; Wed, 14 Mar 2001 12:41:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53266 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131489AbRCNRla>;
	Wed, 14 Mar 2001 12:41:30 -0500
Date: Wed, 14 Mar 2001 17:40:31 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>
Subject: Re: (struct dentry *)->vfsmnt;
Message-ID: <20010314174031.A12200@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <Pine.GSO.4.21.0103140146590.2506-100000@weyl.math.psu.edu> <200103141726.f2EHQoj09856@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103141726.f2EHQoj09856@webber.adilger.int>; from adilger@turbolinux.com on Wed, Mar 14, 2001 at 10:26:50AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2001 at 10:26:50AM -0700, Andreas Dilger wrote:
> > Let me put it that way: I don't understand why (if it is useful at all)
> > it is done in the fs. Looks like a wrong level...
> 
> For the same reason that the UUID and LABEL are stored in the superblock:
> you want this infomation kept with the filesystem and not anywhere else,
> otherwise it will quickly get out-of-date.  Wherever you mounted the
> filesystem last is where it would be mounted if you import the VG on
> another system.  You can obviously edit /etc/fstab afterwards if it is
> wrong, and then remount the filesystem(s), and this will store the
> correct mountpoint into the filesystem for the next vgimport.

Al is saying `why not do this in mount(8) instead of mount(2)?'  I haven't
seen you answer that yet.

-- 
Revolutions do not require corporate support.
