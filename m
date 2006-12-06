Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935553AbWLFPSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935553AbWLFPSy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935072AbWLFPSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:18:32 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:54972 "EHLO
	mail.holtmann.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935138AbWLFPST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:18:19 -0500
Subject: Re: [PATCH] usb/hid: The HID Simple Driver Interface 0.4.1 (core)
From: Marcel Holtmann <marcel@holtmann.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Li Yu <raise.sail@gmail.com>,
       Greg Kroah Hartman <greg@kroah.com>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Vincent Legoll <vincentlegoll@gmail.com>,
       "Zephaniah E. Hull" <warp@aehallh.com>, liyu <liyu@ccoss.com.cn>
In-Reply-To: <d120d5000612060713n5118b379w11dc7e65abae1c58@mail.gmail.com>
References: <200612061803324532133@gmail.com>
	 <Pine.LNX.4.64.0612061114560.28502@twin.jikos.cz>
	 <d120d5000612060624o15f608dk83f35a228b9a6d18@mail.gmail.com>
	 <1165415924.2756.63.camel@localhost>
	 <Pine.LNX.4.64.0612061549040.29624@jikos.suse.cz>
	 <d120d5000612060713n5118b379w11dc7e65abae1c58@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 16:18:37 +0100
Message-Id: <1165418317.2756.75.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

> > > > I still have the same objection - the "simple'" code will have to be
> > > > compiled into the driver instead of being a separate module and
> > > > eventyally will lead to a monster-size HID module. We have this issue
> > > > with psmouse to a degree but with HID the growth potential is much
> > > > bigger IMO.
> >
> > I guess that this paragraph wasn't for me, but rather for the author of
> > the HID Simple Driver proposal, am I right?
> 
> Yes, mainly for him but also for you because we need to be able to do
> what Li Yu is trying to do and be able to tweak HID interfaces.
> 
> ...
> 
> > This split is quite painful, as there are many things happening in USB all
> > the time, so the best way seem to be just to perform big split (with
> > needed changes) at once, and then develop other things on top of it (like
> > hidraw).
> 
> Is there any reason why we can't mecanically move everything into
> drivers/hid right now? Then Greg could simply forward all patches he
> gets for HID your way and you won't have hard time merging your work
> with others...

I fully agree. Lets move and split the transports now and start the work
on top of it. My only concern is to have a clean Git tree to the full
history of HID changes stay intact and will trackable. Some quirk
decisions and other stuff is not obvious and I assume will never be when
it comes to broken HID devices.

So do you have pending HID patches. If yes, please sync them with Linus
and Jiri can setup a clean tree for the move.

Regards

Marcel


