Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312972AbSDOQoC>; Mon, 15 Apr 2002 12:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSDOQoB>; Mon, 15 Apr 2002 12:44:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43018 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S312972AbSDOQoA>;
	Mon, 15 Apr 2002 12:44:00 -0400
Date: Mon, 15 Apr 2002 18:44:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Aaron Tiensivu <mojomofo@mojomofo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
Message-ID: <20020415164404.GW12608@suse.de>
In-Reply-To: <20020415125606.GR12608@suse.de> <02db01c1e498$7180c170$58dc703f@bnscorp.com> <20020415161833.GV12608@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15 2002, Jens Axboe wrote:
> On Mon, Apr 15 2002, Aaron Tiensivu wrote:
> > Simple question but hopefully it has a simple answer.. is there a command
> > you can issue or flag you can look for from the output of hdparm to tell if
> > your hard drive is capable of TCQ before installing the patch? I have a few
> > IBM drives that I'm sure have TCQ abilities but I don't trust them as far as
> > I can throw them (being Hungarian and cursed) but I'd like to give TCQ a
> > whirl on my WD 120GB drives that should work OK, if they support TCQ..
> > 
> > Sorry if it's already been asked.. :)
> 
> It has not been asked :-)
> 
> You can run a IDENTIFY_DEVICE from user space with the task ioctls and
> look at word 83 -- bit 1 and 14 must be set for TCQ to be supported. If
> you give me the model identifier from the IBM drive, I can tell you if
> it has tcq or not...
> 
> I'll write a small util to detect this tomorrow and send it to you + the
> list.

Duh, you can of course just look at /proc/ide/ideX/hdY/identify and
parse that. The info above is still valid for that, of course :-)

-- 
Jens Axboe

