Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSFDOnp>; Tue, 4 Jun 2002 10:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSFDOno>; Tue, 4 Jun 2002 10:43:44 -0400
Received: from [195.63.194.11] ([195.63.194.11]:523 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S313070AbSFDOno>;
	Tue, 4 Jun 2002 10:43:44 -0400
Message-ID: <3CFCC467.7060702@evision-ventures.com>
Date: Tue, 04 Jun 2002 15:45:11 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Neil Brown <neilb@cse.unsw.edu.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 RAID5 compile error
In-Reply-To: <04cf01c20b2d$96097030$f6de11cc@black> <20020604115132.GZ1105@suse.de> <15612.43734.121255.771451@notabene.cse.unsw.edu.au> <20020604115842.GA5143@suse.de> <15612.44897.858819.455679@notabene.cse.unsw.edu.au> <20020604122105.GB1105@suse.de> <20020604123205.GD1105@suse.de> <20020604123856.GE1105@suse.de> <20020604142327.GN1105@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Neil,
> 
> I tried converting umem to see how it fit together, this is what I came
> up with. This does use a queue per umem unit, but I think that's the
> right split anyways. Maybe at some point we can use the per-major
> statically allocated queues...

>  
>  /*
> + * remove the queue from the plugged list, if present. called with
> + * queue lock held and interrupts disabled.
> + */
> +inline int blk_remove_plug(request_queue_t *q)


Jens - I have noticed some unlikely() tag "optimizations" in
tcq code too.
Please tell my, why do you attribute this exported function as inline?
I "hardly doubt" that it will ever show up on any profile.
Contrary to popular school generally it only pays out to unroll vector code
on modern CPUs not decision code like the above.

