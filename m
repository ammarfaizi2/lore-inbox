Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313557AbSEJLnj>; Fri, 10 May 2002 07:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315557AbSEJLni>; Fri, 10 May 2002 07:43:38 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:32626 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313557AbSEJLnh>; Fri, 10 May 2002 07:43:37 -0400
Message-Id: <5.1.0.14.2.20020510114609.01f66c60@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 10 May 2002 12:43:43 +0100
To: Peter Chubb <peter@chubb.wattle.id.au>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] remove 2TB block device limit
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@zip.com.au>,
        Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org,
        martin@dalecki.de, neilb@cse.unsw.edu.au
In-Reply-To: <15579.39081.528187.280027@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:53 10/05/02, Peter Chubb wrote:
> >>>>> "Jens" == Jens Axboe <axboe@suse.de> writes:
>
>Jens> On Fri, May 10 2002, Anton Altaparmakov wrote:
> >> Why not the even dumber one? Forget FMT_SECTOR_T and always use %Lu
> >> and typecast (unsigned long long)sector_t_variable in the printk.
>
>Jens> I like that better too, it's what I did in the block layer too.
>
>That's exactly what I did in the patch....
>
>Except most places I used u64 not unsigned long long (it's the same
>thing on all architectures, and much shorter to type).

I have been told that this is wrong (it was on this list but I can't 
remember who said it - it was one of the prominent kernel hackers... (-;).

u64 is not necesssarily unsigned long long type and this causes compilation 
problems on some architectures (apparently).

Anton


>Peter C
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

