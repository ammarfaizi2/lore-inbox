Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313919AbSDPVmF>; Tue, 16 Apr 2002 17:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313920AbSDPVmE>; Tue, 16 Apr 2002 17:42:04 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:65246 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S313919AbSDPVmD>; Tue, 16 Apr 2002 17:42:03 -0400
Date: Tue, 16 Apr 2002 17:48:27 -0400
To: jjs@lexus.com, akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.8 final - another data point
Message-ID: <20020416174827.A1845@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Running dbench 128 on ext2 mounted with delalloc and Andrew's
>>patches from http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.8/
>>was 7.5x faster than 2.5.8 vanilla and 1.5x faster than

> Wow, good stuff - I'll have to pull those down

Hmm, I had to run e2fsck -f twice on the filesystem that ran
dbench, tiobench, bonnie++ on nfs, and osdb.  The filesystem
was showing 52% used and is normally 1% used before/after
testing.  No big files on the fs. The directory where
bonnie++ on nfs runs had some temporary directories that
were not deletable.  A bunch of files/directories were in
lost+found after e2fsck.  After removing the files, the
fs was back to 1% used.

I backed up and did mke2fs in case there was any
pre-existing/lingering corruption.  So keep your karma
up and test on a test box. :)

-- 
Randy Hron

