Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbTHZO25 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 10:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264077AbTHZOR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 10:17:27 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6561 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264108AbTHZOQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 10:16:41 -0400
Date: Tue, 26 Aug 2003 16:16:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Samphan Raruenrom <samphan@nectec.or.th>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Linux TLE Team <rdi1@opentle.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [Rdi1] Re: [PATCH] Add MOUNT_STATUS ioctl to cdrom device
Message-ID: <20030826141614.GE862@suse.de>
References: <3F4A53ED.60801@nectec.or.th> <20030825195026.A10305@infradead.org> <3F4B0343.7050605@nectec.or.th> <20030826083249.B20776@infradead.org> <3F4B23E2.8040401@nectec.or.th> <20030826105613.A23356@infradead.org> <20030826095830.GA20693@suse.de> <3F4B44C2.4030406@nectec.or.th> <20030826113633.GA22124@suse.de> <3F4B561A.2000103@nectec.or.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4B561A.2000103@nectec.or.th>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26 2003, Samphan Raruenrom wrote:
> Jens Axboe wrote:
> >On Tue, Aug 26 2003, Samphan Raruenrom wrote:
> >>>Exactly. You poll media events from the drive, and upon an eject request
> >>>you try and umount it. If it suceeds, you eject the tray. 
> >>No, it seems impossible to sense the eject request (right?). This
> >No it isn't, in fact there are several ways to do it. Just by searching
> >this list you should be able to find them.
> 
> YES!! 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0202.0/att-0603/01-cd_poll.c
> get_media_event() = 1 -> eject
> Thanks :-)  I think you can't imagine how happy I am now. Thank you again.

I'm surprised you didn't find these things up front.

> >>is what I really did with the patched kernel and patched magicdev.
> >magicdev is a piece of crap.
> 
> Why? I read all its code. Because of 2 sec. polling?

Because it relies on unreliable mechanisms instead of using the proper
support. That makes it 100% crap in my eyes, unusable.

> >I think you need to spend a little more time thinking/researching this
> >problem. At least it really looks like you are going about it all wrong.
> 
> You've just put me on the right track. Thank you very much. I really
> appreciate your and every others insightful comments.

No problem.

-- 
Jens Axboe

