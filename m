Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261310AbSKBReD>; Sat, 2 Nov 2002 12:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261311AbSKBReD>; Sat, 2 Nov 2002 12:34:03 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:43995 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261310AbSKBReC>;
	Sat, 2 Nov 2002 12:34:02 -0500
Date: Sat, 2 Nov 2002 12:40:26 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Petr Baudis <pasky@ucw.cz>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, aeb@cwi.nl
Subject: Re: [PATCH] [2.5.45] Extended /proc/partitions
In-Reply-To: <20021102172324.GB2535@pasky.ji.cz>
Message-ID: <Pine.GSO.4.21.0211021238340.25010-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 2 Nov 2002, Petr Baudis wrote:

>   Hello,
> 
>   this patch (against 2.5.45) extends contents of /proc/partitions by starting
> offset of each partition. This can be terribly useful if you (or someone who
> then passed you the computer for a repair) by some mistake over-dd'd the
> partition table on a disk, but the system is still up. I know that you can also
> dig this out by some ioctl()s, but this can make life a lot easier for those
> who don't know C or can't dig the ioctl codes from the kernel source code.
> 
>   Note that it's possibly totally flawed (I don't know anything about this
> piece of code), but it looks to work ok.

It's already exported in files in driverfs.  No need to duplicate in
/proc/partitions.

