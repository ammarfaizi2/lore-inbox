Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318720AbSHAKCf>; Thu, 1 Aug 2002 06:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318721AbSHAKCf>; Thu, 1 Aug 2002 06:02:35 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26262 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318720AbSHAKCe>;
	Thu, 1 Aug 2002 06:02:34 -0400
Date: Thu, 1 Aug 2002 12:05:53 +0200
From: Jens Axboe <axboe@suse.de>
To: martin@dalecki.de
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: IDE from current bk tree, UDMA and two channels...
Message-ID: <20020801100553.GA13494@suse.de>
References: <9B9F331783@vcnet.vc.cvut.cz> <3D48420F.5050407@evision.ag> <20020801095609.GE1096@suse.de> <3D4905DB.70305@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D4905DB.70305@evision.ag>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01 2002, Marcin Dalecki wrote:
> >hey that sucks :-)
> 
> Since IDE 111 not any more...

Yeah I just saw that 110 was the 'broken' solution, 111 made it right.
Good.

> >seriously, the better way to do this would be to change the q->queuedata
> >to be a pointer to drive instead of the channel.
> 
> ... becouse this is already *done* there :-).

:-)

> >that would work, but I think it would seriously starve the other device
> >on the same channel.
> 
> We starve anyway, becouse the kernel isn't real time and we can't
> guarantee "sleeping" for some maximum time and comming back.
> We don't reschedule the kernel during this kind of "sleeping".
> And we can't know that a command on the "mate" will not take 
> extraordinary amounts of time. It's only a problem if mixing travan
> tapes with disks on a channel.

I'm thinking about the alternation of the devices so one device can't
starve the other device off the channel.

-- 
Jens Axboe

