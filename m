Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317282AbSGXNkW>; Wed, 24 Jul 2002 09:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317287AbSGXNkV>; Wed, 24 Jul 2002 09:40:21 -0400
Received: from [195.63.194.11] ([195.63.194.11]:12302 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317282AbSGXNkL>; Wed, 24 Jul 2002 09:40:11 -0400
Message-ID: <3D3EADBB.3060203@evision.ag>
Date: Wed, 24 Jul 2002 15:38:03 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       martin@dalecki.de, linux-kernel@vger.kernel.org
Subject: Re: please DON'T run 2.5.27 with IDE!
References: <20020724132529.GD15201@suse.de> <Pine.SOL.4.30.0207241531200.15605-100000@mion.elka.pw.edu.pl> <20020724133652.GH15201@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>>>>My goal is to make sure that the QUEUE_FLAG_STOPPED has a valid value
>>>>*inside* the q->request_fn call.
>>>
>>>So you want the queue_lock to protect the flags as well... I don't
>>>really see the point of this.
>>
>>If driver corectly uses blk_start/stop_queue() it is not needed.
>>Whole point of introducing this flag was not to take lock to check
>>status of queue.
> 
> 
> Right. The way it was meant to be used it how cpqarray and cciss does
> it -- stopping queue in request_fn, restarting it from isr.

Yes got it. Of course. But please note that:

1. My suggestion doesn't change the checking case.

2. What you describe is precisely what I would like to be able to
do in my own "playground".



