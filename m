Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267044AbSKWTMQ>; Sat, 23 Nov 2002 14:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267048AbSKWTMQ>; Sat, 23 Nov 2002 14:12:16 -0500
Received: from ares.cs.Virginia.EDU ([128.143.137.19]:64204 "EHLO
	ares.cs.Virginia.EDU") by vger.kernel.org with ESMTP
	id <S267044AbSKWTMP>; Sat, 23 Nov 2002 14:12:15 -0500
Date: Sat, 23 Nov 2002 14:20:54 -0500 (EST)
From: Ronghua Zhang <rz5b@cs.virginia.edu>
To: "Sathyanarayana.A.N - 01cs6002" <san@cse.iitkgp.dhs.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: insmod 
In-Reply-To: <Pine.LNX.4.33L2.0211240020330.16811-100000@pcs-2.cse.iitkgp.ernet.in>
Message-ID: <Pine.LNX.4.44.0211231416100.717-100000@bobbidi.cs.virginia.edu>
References: <Pine.LNX.4.33L2.0211240020330.16811-100000@pcs-2.cse.iitkgp.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inode_dir_notify may not be exported, that's why when you insmod, kernel
reports Unresolved symbol. run 'cat /proc/ksyms | grep 'inode_dir_notify'
to see if it's exported.

Ronghua

On Sun, 24 Nov 2002, Sathyanarayana.A.N - 01cs6002 wrote:

> Friends,
>
>
>     I have written a kernel Virtual file system which merges different
> filesystem directories. For this I am using a VFS function
> inode_dir_notify() function to notify the parent inodes. Now I want my
> virtual file system to be converted as a module. I am facing problems
> while inserting the module. When I do a insmod it is giving
> Unresolved symbol inode_dir_notify even though it is defined in the kernel
> VFS. It is working in case of statically linked version.
>
> Can somebody please suggest me why this is happening?
>
> Please CC the reply to san@cse.iitkgp.dhs.org
>
> Thanks and regards,
> sathya
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

