Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318813AbSIPFvQ>; Mon, 16 Sep 2002 01:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318816AbSIPFvQ>; Mon, 16 Sep 2002 01:51:16 -0400
Received: from dsl-213-023-021-198.arcor-ip.net ([213.23.21.198]:46470 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318813AbSIPFvP>;
	Mon, 16 Sep 2002 01:51:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Christoph Hellwig <hch@lst.de>, marcelo@conectiva.com.br
Subject: Re: [PATCH] rework inode allocation to allow filesystems more control
Date: Mon, 16 Sep 2002 07:55:30 +0200
X-Mailer: KMail [version 1.3.2]
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
References: <20020911145557.A13949@lst.de>
In-Reply-To: <20020911145557.A13949@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17qor4-0000HW-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 September 2002 14:55, Christoph Hellwig wrote:
> This patch adds ->alloc_inode and ->destroy_inode super operations to
> allow the filesystem control the allocation of struct inode, e.g. to
> have it's private inode and the VFS one n the same slab cache.
> 
> This allows to break worst-offenders like NFS out of the big inode union
> and make VM balancing better by wasting less ram for inodes.  It also
> speedups filesystems that don't want to touch that union in struct
> inode, like JFS, XFS or FreeVxFS (once switched over).  It is a straight
> backport from Al's code in 2.5 and has proven stable in Red Hat's
> recent beta releases (limbo, null).  Al has ACKed my patch submission.

How about a credit for the original author/designer?  Yes, that was me.

-- 
Daniel
