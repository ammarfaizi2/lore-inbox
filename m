Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319073AbSHFL7K>; Tue, 6 Aug 2002 07:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319074AbSHFL7J>; Tue, 6 Aug 2002 07:59:09 -0400
Received: from [195.63.194.11] ([195.63.194.11]:4615 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S319073AbSHFL7J>;
	Tue, 6 Aug 2002 07:59:09 -0400
Message-ID: <3D4FB9BB.8010502@evision.ag>
Date: Tue, 06 Aug 2002 13:57:47 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: martin@dalecki.de, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.30 IDE 113
References: <13A77E76028@vcnet.vc.cvut.cz> <3D4FA2F8.2050305@evision.ag> <20020806104238.GB1132@suse.de> <3D4FA845.90702@evision.ag> <20020806105450.GD1323@suse.de> <3D4FAA87.8040303@evision.ag> <20020806110548.GF1323@suse.de> <3D4FAE5C.9050205@evision.ag> <20020806111749.GH1323@suse.de>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Jens Axboe napisa?:

> Ho hum, well I think it's only ugly in the way it had to be done
> previously. Right now I think the usage is pretty nice, actually

Ho ho. I can't do it the pretty way, becouse the queue synchronization
doesn't work as expected :-).

> request_fn(q)
> {
> 	rq = elv_next_request();
> 	start_request(rq);
> 	blk_stop_queue(q);
> }
> 
> isr()
> {
> 	handle_completion();
> 	blk_start_queue(queue);
> }
> 
> The API works nicely regardless of queue depth and how many requests
> request_fn consumes.

You know why I *hate* IDE_BUSY bit 8-)..

