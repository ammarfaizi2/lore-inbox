Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132547AbREKBLI>; Thu, 10 May 2001 21:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132553AbREKBK6>; Thu, 10 May 2001 21:10:58 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:30213 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S132547AbREKBKn>; Thu, 10 May 2001 21:10:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@turbolinux.com>, phillips@bonn-fries.net
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
Date: Fri, 11 May 2001 03:10:46 +0200
X-Mailer: KMail [version 1.2]
Cc: Linux kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <200105102053.f4AKrEke004120@webber.adilger.int>
In-Reply-To: <200105102053.f4AKrEke004120@webber.adilger.int>
MIME-Version: 1.0
Message-Id: <01051103104602.01587@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 May 2001 22:53, Andreas Dilger wrote:
> OK, here are the patches described above.
>
> The first one changes the use of the various INDEX flags, so that
> they only appear when we have mounted with "-o index" (or
> COMPAT_DIR_INDEX) and actually created an indexed directory.
>
> The second one changes the i_nlink counting on indexed dirs so that
> if it overflows the 16-bit i_link_count field it is set to 1 and we
> no longer track link counts on this directory.
>
> Unfortunately, they haven't been tested.  I've given them several
> eyeballings and they appear OK, but when I try to run the ext2 index
> code (even without "-o index" mount option) my system deadlocks
> somwhere inside my ext2i module (tight loop, but SysRQ still works). 
> I doubt it is due to these patches, but possibly because I am also
> working on ext3 code in the same kernel.  I'm just in the process of
> getting kdb installed into that kernel so I can find out just where
> it is looping.

I'll apply and test them in uml tomorrow (3 am here now).  By the way, 
uml was made in heaven for this sort of filesystem development.  Err, 
actually it was made by Jeff, but I guess that makes him some kind of 
angel :-)

--
Daniel
