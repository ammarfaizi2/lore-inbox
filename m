Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317194AbSGYHiK>; Thu, 25 Jul 2002 03:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317448AbSGYHiJ>; Thu, 25 Jul 2002 03:38:09 -0400
Received: from [195.63.194.11] ([195.63.194.11]:24837 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317194AbSGYHiJ>; Thu, 25 Jul 2002 03:38:09 -0400
Message-ID: <3D3FAA6D.70801@evision.ag>
Date: Thu, 25 Jul 2002 09:36:13 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.28
References: <1027549801.11619.2.camel@sonja.de.interearth.com> <20020724230613.27190.qmail@eklektix.com> <20020725055619.GH5159@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>>  <dalecki@evision.ag>
>>	[PATCH] IDE-101
>>	
>>	Here is a quick fix.  I would like to synchronize with the irq handler
>>	changes as well.  Becouse right now I know that preemption is killing
>>	the disk subsystem when moving data between disks using different
>>	request queues...  In esp.  It get's me in to do_request() with a queue
>>	in unplugged state.  (Not everything is my fault, after all :-).
> 
>            ^^^^^^^^^
> 
> must be a typo, it would be a bug to enter do_request() with the queue
> in a _plugged_ state, not vice versa.

Yes you are right. Anyway the described problem is indeed observable.

