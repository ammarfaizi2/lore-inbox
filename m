Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132587AbRDXAQZ>; Mon, 23 Apr 2001 20:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132601AbRDXAQP>; Mon, 23 Apr 2001 20:16:15 -0400
Received: from tomts13.bellnexxia.net ([209.226.175.34]:47800 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S132587AbRDXAQI>; Mon, 23 Apr 2001 20:16:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
Date: Mon, 23 Apr 2001 20:16:01 -0400
X-Mailer: KMail [version 1.2]
Cc: Andreas Dilger <adilger@turbolinux.com>
MIME-Version: 1.0
Message-Id: <01042320160100.01338@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

> Consider, when I was doing some fs benchmark, my inode slab cache was
> over 120k items on a 128MB machine.  At 480 butes per inode, this is
> almost 58 MB, close to half of RAM.  Reducing this to exactly ext2
> sized inodes would save (50 - 27) * 4 * 120k = 11MB of memory (on 32-bit
> systems)!!! (This assumes nfs_inode_info is the largest).

Was this with a recient kernel (post Alexander Viro's dcache pressure fix)?  
If not I suggest rerunning the benchmark.  I had/have a patch to apply pressure 
to the dcache and icache from kswapd but its not been needed here since the above 
fix.

Ed Tomlinson <tomlins@cam.org>
