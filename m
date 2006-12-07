Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968802AbWLGFQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968802AbWLGFQj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 00:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968804AbWLGFQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 00:16:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:50902 "EHLO perch.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968802AbWLGFQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 00:16:38 -0500
Date: Wed, 6 Dec 2006 21:16:08 -0800
From: Greg KH <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
       Li Yu <raise.sail@gmail.com>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Vincent Legoll <vincentlegoll@gmail.com>,
       "Zephaniah E. Hull" <warp@aehallh.com>, liyu <liyu@ccoss.com.cn>
Subject: Re: [PATCH] usb/hid: The HID Simple Driver Interface 0.4.1 (core)
Message-ID: <20061207051608.GA13969@kroah.com>
References: <200612061803324532133@gmail.com> <Pine.LNX.4.64.0612061114560.28502@twin.jikos.cz> <d120d5000612060624o15f608dk83f35a228b9a6d18@mail.gmail.com> <1165415924.2756.63.camel@localhost> <Pine.LNX.4.64.0612061549040.29624@jikos.suse.cz> <d120d5000612060713n5118b379w11dc7e65abae1c58@mail.gmail.com> <1165418317.2756.75.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165418317.2756.75.camel@localhost>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 04:18:37PM +0100, Marcel Holtmann wrote:
> Hi Dmitry,
> 
> > > > > I still have the same objection - the "simple'" code will have to be
> > > > > compiled into the driver instead of being a separate module and
> > > > > eventyally will lead to a monster-size HID module. We have this issue
> > > > > with psmouse to a degree but with HID the growth potential is much
> > > > > bigger IMO.
> > >
> > > I guess that this paragraph wasn't for me, but rather for the author of
> > > the HID Simple Driver proposal, am I right?
> > 
> > Yes, mainly for him but also for you because we need to be able to do
> > what Li Yu is trying to do and be able to tweak HID interfaces.
> > 
> > ...
> > 
> > > This split is quite painful, as there are many things happening in USB all
> > > the time, so the best way seem to be just to perform big split (with
> > > needed changes) at once, and then develop other things on top of it (like
> > > hidraw).
> > 
> > Is there any reason why we can't mecanically move everything into
> > drivers/hid right now? Then Greg could simply forward all patches he
> > gets for HID your way and you won't have hard time merging your work
> > with others...
> 
> I fully agree. Lets move and split the transports now and start the work
> on top of it. My only concern is to have a clean Git tree to the full
> history of HID changes stay intact and will trackable. Some quirk
> decisions and other stuff is not obvious and I assume will never be when
> it comes to broken HID devices.
> 
> So do you have pending HID patches. If yes, please sync them with Linus
> and Jiri can setup a clean tree for the move.

I have no pending HID patches in my queue right now.  Jiri, feel free to
respin your patches against Linus's tree and send them to me now.  I can
handle the git stuff and send them to Linus.

thanks,

greg k-h
