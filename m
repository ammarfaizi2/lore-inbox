Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314456AbSEFOfz>; Mon, 6 May 2002 10:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314457AbSEFOfy>; Mon, 6 May 2002 10:35:54 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:3707 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S314456AbSEFOfy>; Mon, 6 May 2002 10:35:54 -0400
Message-Id: <5.1.0.14.2.20020506153345.043f4d00@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 06 May 2002 15:36:44 +0100
To: Jens Axboe <axboe@suse.de>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: tcq problem details Re: vanilla 2.5.13 severe file system
  corruption experienced follozing e2fsck ...
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20020506131805.GA18817@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14:18 06/05/02, Jens Axboe wrote:
>On Mon, May 06 2002, Jens Axboe wrote:
> > Agrh, that's a silly bug in blk_queue_init_tags(). Could you replace the
> > memset() of tags->tag_index in there with something ala:
>
>Brown paper bag time, this should make it work. Linus, please apply.

It now works. (-; running 2.5.14 with ide, tcq, highmem (1G ram), NO 
preemption or smp compiled in, seems to be holding up. ran already one loop 
of my ntfs stress test without problems. now trying second time...

[aia21@drop aia21]$ sudo cat /proc/ide/ide0/hda/tcq
TCQ currently on:       yes
Max queue depth:        32
Max achieved depth:     32
Max depth since last:   4
Current depth:          0
Active tags:            [ ]
Queue:                  released [ 3852 ] - started [ 6539 ]
DMA status:             not running

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

