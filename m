Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281032AbRKCUbp>; Sat, 3 Nov 2001 15:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281034AbRKCUbf>; Sat, 3 Nov 2001 15:31:35 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:16068 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281032AbRKCUb1>;
	Sat, 3 Nov 2001 15:31:27 -0500
Date: Sat, 3 Nov 2001 15:31:25 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Simon Kirby <sim@netnation.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Something broken in sys_swapon
In-Reply-To: <20011103122344.A12059@netnation.com>
Message-ID: <Pine.GSO.4.21.0111031529490.18001-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Nov 2001, Simon Kirby wrote:

>                 kdev_t dev = swap_inode->i_rdev;
>                 struct block_device_operations *bdops;
> 
>                 p->swap_device = dev;
>                 set_blocksize(dev, PAGE_SIZE);
> 
> I don't know much at all about the inode structure, but doesn't this set
> the block size of the originating filesystem containing the inode rather
> than the block device that inode happens to be pointing to?  That would

man 2 stat

i_rdev is equivalent of st_rdev, i_dev - of st_dev.

