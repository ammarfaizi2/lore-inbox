Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314811AbSECRBg>; Fri, 3 May 2002 13:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314810AbSECRBf>; Fri, 3 May 2002 13:01:35 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:24582 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314799AbSECRBd>;
	Fri, 3 May 2002 13:01:33 -0400
Date: Fri, 3 May 2002 19:01:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Sebastian Droege <sebastian.droege@gmx.de>
Cc: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #2
Message-ID: <20020503170118.GV839@suse.de>
In-Reply-To: <20020503110652.GF839@suse.de> <20020503163248.633c8358.sebastian.droege@gmx.de> <20020503164555.GQ839@suse.de> <20020503185744.7f4e192f.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03 2002, Sebastian Droege wrote:
> > Hmm strange, please send me your .config so I can see some more facts
> > about your setup.
> 
> Attached at the bottom...

Thanks! BTW, after having reproduced, could you reproduce with preempt
disabled as well?

> > > ide_tcq_intr_timeout: timeout waiting for interrupt...
> > > ide_tcq_intr_timeout: hwgroup not busy
> > 
> > We timed out waiting for an interrupt for service or dma completion.
> > Damn, I forgot to print which one. Please change that printk in
> > drivers/ide/ide-tcq.c:ide_tcq_intr_timeout() to:
> > 
> > 	printk("ide_tcq_intr_timeout: timeout waiting for %s interrupt...\n",
> > 		hwgroup->rq ? "completion" : "service");
> > 
> > and reproduce!
> Is this printk enough or should I handcopy the oops again? ;)

The oops is pretty irrelevant here, the fact that it triggers is enough
to know. I already know the backtrace :-)

> Yes this is possible... the oops is just hand copied...

Ah makes sense, no problem.

-- 
Jens Axboe

