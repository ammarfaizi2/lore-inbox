Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbUFCNL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUFCNL6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 09:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUFCNL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 09:11:58 -0400
Received: from main.gmane.org ([80.91.224.249]:51141 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261156AbUFCNL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 09:11:56 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: RE: SERIO_USERDEV patch for 2.6
Date: Thu, 3 Jun 2004 15:11:51 +0200
Message-ID: <MPG.1b2941f4285450179896b7@news.gmane.org>
References: <20040602153128.57388.qmail@web81307.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-165-128.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> Giuseppe Bilotta wrote:
> > Ok, in this case your ALPS patch need a little working ;) (Last
> > time I saw it it ORed the touchpad and stick values.)
> 
> Yes it needs indeed. I have something here that treats stick as a
> mouse on a passthrough port, much like Synaptics driver. It's not
> ready for publishing yet though.  

Ok, thanks.

> > When you say "userspace task", are you saying that the
> > filtering out of, say, BTN_TOUCH events should happen at a
> > higher level than the kernel driver not reporting them at all?
> > Say, in gpm?
> 
> Exactly. If you check Peter Osterlund's X driver or my GPM patches
> you will see that they get BTN_TOUCH or even ABS_PRESSURE events
> and then decide for themselves what should be considered a tap and
> what is not. And the logic is not dependent on a particular model
> but rather on set of capabilities that device reports.

I see and get the point.

> Kernel task is to convert data from individual devices into unified
> representation and userpace task is to do with that data whatever
> it wants. X driver does not (should not) care whether a mouse is a
> serial or PS/2 or USB. It only wants to know that it reports 2
> relative axis motions and has X number of buttons and X number of
> wheels.
> 
> Now operation of a touchscreen is different from operation of touchpad
> which is different from standard mouse and userspace has to distinguish
> between these, but that's because they are different classes of input
> devices and should be handled [slightly] differently.

I guess the problem with X is that it has to work on a wide 
variety of systems, not all of which expose the same 
capabilities the same way, which is why it has the tendency to 
prefer direct acces ...

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

