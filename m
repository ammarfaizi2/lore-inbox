Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263229AbSJCKk7>; Thu, 3 Oct 2002 06:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263230AbSJCKk7>; Thu, 3 Oct 2002 06:40:59 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:48770 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263229AbSJCKk7>;
	Thu, 3 Oct 2002 06:40:59 -0400
Date: Thu, 3 Oct 2002 06:46:30 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: block device size in 2.5
In-Reply-To: <20021003103414.GA11966@fib011235813.fsnet.co.uk>
Message-ID: <Pine.GSO.4.21.0210030645200.13480-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Oct 2002, Joe Thornber wrote:

> Why is the total size of a block device held in struct gendisk rather
> than struct block_device ?

It is mirrored into bdev->bd_inode->i_size.  However, struct block_device
is not persistent - persistent stuff lives in struct gendisk.

