Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317140AbSGXONQ>; Wed, 24 Jul 2002 10:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317211AbSGXONQ>; Wed, 24 Jul 2002 10:13:16 -0400
Received: from [195.63.194.11] ([195.63.194.11]:33038 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317140AbSGXONP>; Wed, 24 Jul 2002 10:13:15 -0400
Message-ID: <3D3EB576.1040601@evision.ag>
Date: Wed, 24 Jul 2002 16:11:02 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Jens Axboe <axboe@suse.de>, Adam Kropelin <akropel1@rochester.rr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: cpqarray broken since 2.5.19
References: <Pine.SOL.4.30.0207241606090.15605-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Jens, the same is in cciss.c.
> Please remove locking from blk_stop_queue() (as you suggested) or intrduce
> unlocking in request_functions.
> 
Bartek I think the removal is just for reassertion that the
locking is the problem. You can't remove it easly from
blk_stop_queue() unless you make it mandatory that blk_stop_queue
has to be run with the lock already held. Or in other words
basically -> Don't use blk_stop_queue() outside of ->request_fn.


