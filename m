Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312917AbSDOQSb>; Mon, 15 Apr 2002 12:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312920AbSDOQSa>; Mon, 15 Apr 2002 12:18:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35593 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S312917AbSDOQSa>;
	Mon, 15 Apr 2002 12:18:30 -0400
Date: Mon, 15 Apr 2002 18:18:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Aaron Tiensivu <mojomofo@mojomofo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
Message-ID: <20020415161833.GV12608@suse.de>
In-Reply-To: <20020415125606.GR12608@suse.de> <02db01c1e498$7180c170$58dc703f@bnscorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15 2002, Aaron Tiensivu wrote:
> Simple question but hopefully it has a simple answer.. is there a command
> you can issue or flag you can look for from the output of hdparm to tell if
> your hard drive is capable of TCQ before installing the patch? I have a few
> IBM drives that I'm sure have TCQ abilities but I don't trust them as far as
> I can throw them (being Hungarian and cursed) but I'd like to give TCQ a
> whirl on my WD 120GB drives that should work OK, if they support TCQ..
> 
> Sorry if it's already been asked.. :)

It has not been asked :-)

You can run a IDENTIFY_DEVICE from user space with the task ioctls and
look at word 83 -- bit 1 and 14 must be set for TCQ to be supported. If
you give me the model identifier from the IBM drive, I can tell you if
it has tcq or not...

I'll write a small util to detect this tomorrow and send it to you + the
list.

I thought only the IBM's had TCQ, but I got one report today indicating
that some WD do too.

-- 
Jens Axboe

