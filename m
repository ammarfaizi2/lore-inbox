Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315222AbSEYSYI>; Sat, 25 May 2002 14:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315227AbSEYSYH>; Sat, 25 May 2002 14:24:07 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:37322 "EHLO
	snipe.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S315222AbSEYSYH>; Sat, 25 May 2002 14:24:07 -0400
Date: Sat, 25 May 2002 14:24:09 -0400
To: linux-kernel@vger.kernel.org
Cc: andrea@suse.de
Subject: Slabinfo memory usage after big box benchmarks
Message-ID: <20020525142409.A323@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if this is related to the negative 
dentry thread or not.  After running various 
benchmarks on quad Xeon with 3.75 GB RAM, 
there are some big differences in slab size.  

inode_cache and dentry_cache have the biggest 
difference between kernels.  

		total slab size		inode_cache
2.4.19-pre7-rmap13	 45.9 MB	  9.9 MB
2.4.19-pre8		278.0 MB	202.8 MB
2.4.19-pre8-aa2		306.1 MB	233.9 MB
2.4.19-pre8-ac4		 44.3 MB	  4.5 MB
2.4.19-pre8-jam2	263.9 MB	182.1 MB

The benchmarks create a million or more temp
files during the run.  Updatedb runs several
times too.

bonnie++ is one of the benches that creates a lot
of files.  On runs with vastly different "number
of files to create", there was little difference
in slabinfo memory usage on 2.4.19-pre8-jam2.

More slabinfo detail at:
http://home.earthlink.net/~rwhron/kernel/bigbox/slabinfo.txt

Script to create slabinfo.txt in url above:
http://home.earthlink.net/~rwhron/kernel/bigbox/si_sum

Big box benchmarks:
http://home.earthlink.net/~rwhron/kernel/bigbox.html

--
Randy Hron

