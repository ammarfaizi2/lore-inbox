Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262461AbREXWkQ>; Thu, 24 May 2001 18:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262465AbREXWkG>; Thu, 24 May 2001 18:40:06 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:33665 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S262461AbREXWjs>; Thu, 24 May 2001 18:39:48 -0400
Message-Id: <5.1.0.14.2.20010524233919.051932a0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 24 May 2001 23:40:17 +0100
To: Dawson Engler <engler@csl.Stanford.EDU>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and
  2.4.4-ac8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200105242110.OAA29766@csl.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 22:10 24/05/2001, Dawson Engler wrote:
[snip]
>---------------------------------------------------------
>[BUG]
>/u2/engler/mc/oses/linux/2.4.4-ac8/fs/ntfs/super.c:352:ntfs_get_free_cluster_count: 
>ERROR:VAR:352:352: suspicious var 'bits' = 2048 bytes:352 [nbytes=2048]
>
>static int nc[16]={4,3,3,2,3,2,2,1,3,2,2,1,2,1,1,0};
>
>int ntfs_get_free_cluster_count(ntfs_inode *bitmap)
>{
>
>Error --->
>         unsigned char bits[2048];
>---------------------------------------------------------

Thanks. I was just about to submit a large patch anyway, so I will fix this 
and submit shortly.

Anton



-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sf.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

