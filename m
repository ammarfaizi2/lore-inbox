Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316695AbSGLRcw>; Fri, 12 Jul 2002 13:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316705AbSGLRcv>; Fri, 12 Jul 2002 13:32:51 -0400
Received: from pD9E235D3.dip.t-dialin.net ([217.226.53.211]:25221 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316695AbSGLRct>; Fri, 12 Jul 2002 13:32:49 -0400
Date: Fri, 12 Jul 2002 11:35:26 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Jens Axboe <axboe@suse.de>
Subject: [Q] BIO for O_DIRECT
Message-ID: <Pine.LNX.4.44.0207121127330.3421-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In fs/direct_io.c, we have this construct:

                  ret = dio_bio_alloc(dio, map_bh.b_bdev,
                        map_bh.b_blocknr << (blkbits - 9),
                        DIO_BIO_MAX_SIZE / PAGE_SIZE);

Problem is that BIO_MAX_SIZE isn't static any more with the BIO patch. 
BIO_MAX_SIZE / PAGE_SIZE looks like the maximal number of iovecs, which is 
dynamic now and can be determined using

bio_max_iovecs(request_queue_t *q, int *iovec_size)

My problem here is that I don't know where to get the parameters from...

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

