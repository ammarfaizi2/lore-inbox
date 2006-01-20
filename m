Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbWATRww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWATRww (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWATRww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:52:52 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:22436 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1751005AbWATRwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:52:51 -0500
Date: Fri, 20 Jan 2006 18:53:44 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: dtor_core@ameritech.net
Cc: Marc Koschewski <marc@osknowledge.org>, Michael Loftis <mloftis@wgops.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060120175343.GF5873@stiffy.osknowledge.org>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com> <20060120155919.GA5873@stiffy.osknowledge.org> <d120d5000601200840o704af2e5h6d9087b62594bbe1@mail.gmail.com> <20060120164827.GD5873@stiffy.osknowledge.org> <d120d5000601200855y7318e708va22a21607cf9c078@mail.gmail.com> <20060120172431.GE5873@stiffy.osknowledge.org> <d120d5000601200943o200b3452yff84151b0d495774@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000601200943o200b3452yff84151b0d495774@mail.gmail.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc1-marc-g18a41440-dirty
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [2006-01-20 12:43:12 -0500]:

> On 1/20/06, Marc Koschewski <marc@osknowledge.org> wrote:
> > * Dmitry Torokhov <dmitry.torokhov@gmail.com> [2006-01-20 11:55:38 -0500]:
> >
> > > On 1/20/06, Marc Koschewski <marc@osknowledge.org> wrote:
> > > > * Dmitry Torokhov <dmitry.torokhov@gmail.com> [2006-01-20 > >
> > > > > Marc, have you tried 2.6.16-rc1 yet? Does it also give you problems
> > > > > with psmouse?
> > > > >
> > > >
> > > > Not yet, Dmitry. I just managed to get today's -git compiled and running. I'll
> > > > give it a try tonite.
> > > >
> > > > Moreover, I put a
> > > >
> > > >        echo -n 0 > /sys/bus/serio/devices/serio0/resync_time
> > > >
> > > > in my initscripts. Since then I didn't see any problem. I'll report later how it
> > > > went with that line removed and stock 2.6.16-rc1.
> > > >
> > >
> > > Ok, if psmouse gives you a fit and setting resync_time to 0 cures it,
> > > please do the follwing:
> > >
> > > echo -n 5 > /sys/bus/serio/devices/serioX/resync_time
> > > echo 1 > /sys/modules/i8042/parameters/debug
> > > ... wait 10 seconds ...
> > > move the mouse slightly
> > > ... wait another 10 seconds ...
> > > move the mouse slighty again
> > > echo 0 > /sys/modules/i8042/parameters/debug
> > >
> > > and send me your dmesg (or better /var/log/messages or whatever file
> > > you use for kernel messages).
> > >
> > > --
> > > Dmitry
> >
> > OK, here goes:
> >
> 
> Hmm, I see 2 perfectly healthy resyncs. Could you remind me what is
> exactly wrong with the mouse on your box? Does it give you fits right
> now (you seem to leave resync on)?

Well, the pointer seems to be very happy when jumping into the (mostly) upper
right corner. Then it seems like movement and clicks somehow get swallowed
away or stacked and after that get issued in a) either wrong order or b) wrong.
Moreover, even if I didn't click any button (including btn 4 + 5 for wheel
up/down) the mouse clicks into the window what often opens context menus.
Sometimes it then even clicks in. Once it logged me off that way from GNOME
because selecting the entry from the menu and hit 'Log out'. Summary: unusable.

Let me repeat this with a clean 2.6.16-rc1 install without any patches and
resync_timing of 5 tonite. I'll send the whole kern.log part from gdm login (the
agpgart lines) until the mouse jumps then. 

Marc
