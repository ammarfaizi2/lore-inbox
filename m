Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbRAEBlq>; Thu, 4 Jan 2001 20:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131078AbRAEBlg>; Thu, 4 Jan 2001 20:41:36 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:61161 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129610AbRAEBld>; Thu, 4 Jan 2001 20:41:33 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Chris Mason <mason@suse.com>, reiserfs-list@namesys.com,
        linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] reiserfs patch for 2.4.0-prerelease
Date: Thu, 4 Jan 2001 20:41:13 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
In-Reply-To: <244070000.978645169@tiny>
In-Reply-To: <244070000.978645169@tiny>
MIME-Version: 1.0
Message-Id: <01010420411300.00624@oscar>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been doing some dbench runs with the original and latest (Jan 4 22:xx) 
prerelease.diff kernels.  Looks like both the latest kernels and the reiserfs 
patch both are costing some performance.

prerelease
	MB/s	user	system	cpu	time	
ext2	14.6	50.5s	 76.4s	29%	 7:14.9m
ext2	12.6	50.9s 	 76.7s	25%	 8:23.6m

reiser	14.5	53.8s	149.2s	46%	 7:16.1m
reiser	10.7	54.1s	154.5s	35%	 9:49.9m

prerelease (2.4.0 jan 4 22:xx)
	MB/s	user	system	cpu	time
ext2	10.5	52.8s	 81.5s	22%	10:02.3m

reiser	 5.8	54.6s	198.5s	23%	18:12.5m
reiser	 6.4	55.1s	188.7s	24%	16.19.3m

Using the notail reiserfs mount option improves the reiserfs numbers 10-20% 
with both kernels.

All benchmarks run on a K6-III 400 with 128M just after boot with no X 
running.

Comments?
Ed Tomlinson
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
