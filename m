Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319053AbSHFKoj>; Tue, 6 Aug 2002 06:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319054AbSHFKoj>; Tue, 6 Aug 2002 06:44:39 -0400
Received: from [195.63.194.11] ([195.63.194.11]:15366 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S319053AbSHFKoi>; Tue, 6 Aug 2002 06:44:38 -0400
Message-ID: <3D4FA845.90702@evision.ag>
Date: Tue, 06 Aug 2002 12:43:17 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: martin@dalecki.de, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.30 IDE 113
References: <13A77E76028@vcnet.vc.cvut.cz> <3D4FA2F8.2050305@evision.ag> <20020806104238.GB1132@suse.de>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Jens Axboe napisa?:
> On Tue, Aug 06 2002, Marcin Dalecki wrote:
> 
>>device not per channel! If q->request_fn would properly return the
>>error count instead of void, we could even get rid ot the
>>checking for rq->errors after finishment... But well that's
>>entierly different story.
> 
> 
> That's nonsense! What exactly would you return from a request_fn after
> having queued, eg, 20 commands? Error count is per request, anything
> else would be stupid.

Returning the error count in the case q->request_fn is called for
a self submitted request like for example REQ_SPECIAL would be handy and 
well defined. For the cumulative case it would of course make sense to 
return the cumulative error count. Tough not very meaningfull, it would
indicate the occurrence of the error very fine.

