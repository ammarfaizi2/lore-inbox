Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279984AbRKRSJJ>; Sun, 18 Nov 2001 13:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279981AbRKRSIw>; Sun, 18 Nov 2001 13:08:52 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:27892 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S279952AbRKRSIi>;
	Sun, 18 Nov 2001 13:08:38 -0500
Date: Sun, 18 Nov 2001 13:08:37 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Urban Widmark <urban@teststation.com>
cc: Sven Vermeulen <sven.vermeulen@rug.ac.be>,
        Linux-Kernel Development Mailinglist 
	<linux-kernel@vger.kernel.org>
Subject: Re: /sbin/mount and /proc/mounts difference
In-Reply-To: <Pine.LNX.4.30.0111181401140.13487-100000@cola.teststation.com>
Message-ID: <Pine.GSO.4.21.0111181304361.15361-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 18 Nov 2001, Urban Widmark wrote:

> On Sun, 18 Nov 2001, Sven Vermeulen wrote:

> I don't know if there are any plans to change that. Wouldn't be difficult
> to add something to super_operations.
> 
> fs/namespace.c:
> 	show_vfsmnt
> 	show_nfs_mount

Well, now that's easy to do.  With the old code (FVO "old" equal to
2.4.15-pre2) you would end up with mind-boggling amount of buffer
overruns _and_ ugly code in filesystems.

I would rather start messing with that area with cleaning up mount
options' parsers - I've got a patch that does it, it just needs to
be ported to recent trees.

