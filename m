Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319065AbSHFLFu>; Tue, 6 Aug 2002 07:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319066AbSHFLFu>; Tue, 6 Aug 2002 07:05:50 -0400
Received: from [195.63.194.11] ([195.63.194.11]:35846 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S319065AbSHFLFt>; Tue, 6 Aug 2002 07:05:49 -0400
Message-ID: <3D4FAD3A.1090309@evision.ag>
Date: Tue, 06 Aug 2002 13:04:26 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: martin@dalecki.de, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.30 IDE 113
References: <13AC5F92253@vcnet.vc.cvut.cz> <20020806104414.GC1132@suse.de> <3D4FA924.3030601@evision.ag> <20020806110354.GE1323@suse.de>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Jens Axboe napisa?:

> Agrh god no. So you'll spin waiting for the ioctl to complete?
> 
>>From ide_raw_taskfile(), the right way to do it is:
> 
> 	struct request *rq = blk_get_request(...);
> 
> This gets _everything_ right.
> 
> BTW, _glad to see you got rid of the horrible insert-and-execute stuff
> in ide_raw_taskfile(). That was a layering violation.
> 
> 
>>OK?
> 
> 
> Not likely :-)

Argh. Yes. Thank's for the back-head slap.
I was looking too much at the SCSI code again and got it wrong.
But some time ago I was already thinking about blk_get_request().
How could I maintain that the blk_get_request() really returns?
blk_get_request() does only drain up to maximum queue depth as
far as I can read the code and then bad things wil happen :-).
Or should I just not worry?


