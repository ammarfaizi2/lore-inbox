Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUFBPJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUFBPJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 11:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbUFBPJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 11:09:56 -0400
Received: from main.gmane.org ([80.91.224.249]:54700 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263117AbUFBPJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 11:09:54 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: SERIO_USERDEV patch for 2.6
Date: Wed, 2 Jun 2004 17:08:42 +0200
Message-ID: <MPG.1b27e7e5aece43bc9896b5@news.gmane.org>
References: <Pine.GSO.4.58.0406011105330.6922@stekt37> <200406011318.36992.dtor_core@ameritech.net> <MPG.1b272042f54382879896b4@news.gmane.org> <200406011850.16136.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-81-129.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Tuesday 01 June 2004 05:23 pm, Giuseppe Bilotta wrote:
> > Dmitry Torokhov wrote:
> > > echo "rawdev" > /sys/bus/serio/devices/serio0/driver
> > > 
> > > or something alont these lines. At least that's my grand plan ;)
> > 
> > I like this kind of idea. Many options should be settable this 
> > way (think for example about Synaptics and ALPS touchpad 
> 
> Yes, exactly, it will allow much more flexible option handling. Still,
> as far as your examples go: 
> 
> > configurations: whether to use multipointers separately or 
> > together,
> - userspace task - always persent separate devices and have application
>   (GPM or X) multiplex data together.

Ok, in this case your ALPS patch need a little working ;) (Last 
time I saw it it ORed the touchpad and stick values.)

> > (de)activation of tapping,
> - may be userspace task - i.e can be done in userspace if device can
>   report BTN_TOUCH event. If not then kernel has to toggle it.

> > button remapping etc).  
> - userspace task

When you say "userspace task", are you saying that the 
filtering out of, say, BTN_TOUCH events should happen at a 
higher level than the kernel driver not reporting them at all? 
Say, in gpm?

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

