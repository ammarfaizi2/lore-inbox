Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270600AbRHIWZK>; Thu, 9 Aug 2001 18:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270601AbRHIWZA>; Thu, 9 Aug 2001 18:25:00 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:53456 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S270600AbRHIWYx>;
	Thu, 9 Aug 2001 18:24:53 -0400
Date: Thu, 9 Aug 2001 18:24:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Mason <mason@suse.com>
cc: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, lvm-devel@sistina.com
Subject: Re: [PATCH] LVM snapshot support for reiserfs and others
In-Reply-To: <505560000.997395642@tiny>
Message-ID: <Pine.GSO.4.21.0108091822440.25945-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Aug 2001, Chris Mason wrote:

> 
> Ok, here it is:
> 
> LVM_VFS_ENHANCEMENT #define is gone, lvm only calls fsync_dev_lockfs
> when syncing for the snapshot
> 
> sync_supers_lockfs calls write_super if the super is dirty,
> and write_super_lockfs (regardless of dirty state).
> 
> Works on reiserfs and ext2, should not break other filesystems
> using the old patch.
> 
> updated to 2.4.8-pre7

Chris, how about doing that after fs/super.c stuff (things that went into
-ac)?

