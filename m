Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263639AbREYIZk>; Fri, 25 May 2001 04:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263636AbREYIYk>; Fri, 25 May 2001 04:24:40 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:7172 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S263637AbREYIY1>;
	Fri, 25 May 2001 04:24:27 -0400
Date: Wed, 23 May 2001 16:22:28 +0000
From: Pavel Machek <pavel@suse.cz>
To: Bharath Madhavan <bharath_madhavan@ivivity.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Speeding up VFS using HW assist
Message-ID: <20010523162227.A33@toy.ucw.cz>
In-Reply-To: <25369470B6F0D41194820002B328BDD2071790@ATLOPS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <25369470B6F0D41194820002B328BDD2071790@ATLOPS>; from bharath_madhavan@ivivity.com on Tue, May 22, 2001 at 05:11:37PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 	I will be using Linux as the OS for an embedded system.
> I was looking into 2.4.4 kernel code and saw the dcache implementation
> in VFS which is pretty neat and fast by itself.
> 
> My question is, will I gain any considerable efficiency in file system
> access
> if I can move this "pathname -> inode" lookup into some proprietery 
> HW assist mechanism and take out the dcache hashing and "cached_lookup"
> function.

I doubt it will do much difference. How much time is spent in kernel
in your workload? What kind of embedded system is that?

> How good(bad) was it before the dcache implementation and in which release
> was dcache feature added (was it only after 2.2.x release). 
> Did we get 2-3 times better performance with dcache? (if not, how much?)

I'd be surprised if dcache made more than 20% speedup.

> Can anyone suggest any other place in the file system (VFS and EXT2) where
> we
> can use any HW assist (let us say FPGA implementing search, lookup, etc.)
> to speed up file-system access (both for opening and read/write)

Dumping ext2 for reiserfs? ;-)


-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

