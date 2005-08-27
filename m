Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751645AbVH0Tbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbVH0Tbt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 15:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbVH0Tbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 15:31:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:1973 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751643AbVH0Tbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 15:31:46 -0400
Date: Sat, 27 Aug 2005 14:34:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Yani Ioannou <yani.ioannou@gmail.com>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Jon Escombe <lists@dresco.co.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>,
       linux-ide@vger.kernel.org
Subject: Re: PATCH: ide: ide-disk freeze support for hdaps
Message-ID: <20050827123408.GD1109@openzaurus.ucw.cz>
References: <253818670508250708a9075a0@mail.gmail.com> <58cb370e0508250859701ea571@mail.gmail.com> <253818670508252204b22e8c2@mail.gmail.com> <20050826065515.GQ4018@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050826065515.GQ4018@suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Please make the interface accept number of seconds (as suggested by Jens)
> > > and remove this module parameter. This way interface will be more flexible
> > > and cleaner.  I really don't see any advantage in doing "echo 1 > ..." instead
> > > of "echo x > ..." (Pavel, please explain).
> > 
> > Either way is pretty easy enough to implement. Note though that I'd
> > expect the userspace app should thaw the device when danger is out of
> > the way (the timeout is mainly there to ensure that the queue isn't
> > frozen forever, and should probably be higher). Personally I don't
> > have too much of an opinion either way though... what's the consensus?
> > :).
> 
> Yes please, I don't understand why you would want a 0/1 interface
> instead, when the timer-seconds method gives you the exact same ability
> plus a way to control when to unfreeze...

Well, with my power-managment hat on:

we probably want "freeze" functionality to be generic; it makes sense
for other devices, too.

"My battery is so low I can not use wifi any more" => userspace
freezes wifi.

Now, having this kind of timeout in all the cases looks pretty ugly to my eyes.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

