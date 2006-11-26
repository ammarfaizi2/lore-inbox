Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935596AbWKZWmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935596AbWKZWmv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 17:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935597AbWKZWmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 17:42:51 -0500
Received: from mail.enter.net ([216.193.128.40]:19394 "EHLO mmail.enter.net")
	by vger.kernel.org with ESMTP id S935596AbWKZWmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 17:42:50 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: "Dave Airlie" <airlied@gmail.com>
Subject: Re: Overriding X on panic
Date: Sun, 26 Nov 2006 17:42:39 -0500
User-Agent: KMail/1.9.5
Cc: Alan <alan@lxorguk.ukuu.org.uk>, "Adam Jackson" <ajax@nwnk.net>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Casey Dahlin" <cjdahlin@ncsu.edu>, linux-kernel@vger.kernel.org
References: <1164434093.10503.2.camel@localhost.localdomain> <20061126142213.52c292d3@localhost.localdomain> <21d7e9970611261419s12da9881h1f19adcf11756769@mail.gmail.com>
In-Reply-To: <21d7e9970611261419s12da9881h1f19adcf11756769@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611261742.39469.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 November 2006 17:19, Dave Airlie wrote:
> On 11/27/06, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> > On Sun, 26 Nov 2006 09:18:41 +0100
> >
> > Arjan van de Ven <arjan@infradead.org> wrote:
> > > > The mode switch sequences for modern cards are a bit more hairy than
> > > > lists of I/O poking unfortunately.
> > >
> > > for the Intel hw Keith doesn't seem to think it's all that much of a
> > > problem though...
> >
> > Including the TV out, odder LCD panels, non BIOS modes etc ? If so then
> > it might be an interesting test case for intelfb to grow some kind of
> > console helper interface
>
> It's non-trivial, I think you are better off going initially with just
> using the current framebuffer that X is using, I know ajax was doing
> some hacking on this with a "user"-framebuffer, until I disuaded him
> due to I think the trouble caused by dual-head and something else I
> can't remember..
>
> I personally think we need to probably just bite the bullet and start
> sticking graphics drivers into the kernel, the new randr-1.2 interface
> for X is probably a good starting point for a generic mode setting
> interface that isn't so X dependent and could replace fbdev with
> something more sane wrt dualhead and multiple outputs... fbdev could
> be implemented on top of that layer then.. also suspend/resume really
> needs this sort of thing....

I've been working on this myself. Unfortunately the box I was using for devel 
has died and the start I made on the work was lost several months ago when I 
had a hard drive die on me. (I really need to go buy a UPS and a better surge 
protector - the box I was doing devel on bought it in a lightning strike and 
the hard drive I had used as a backup just died)

> My main worry with integrating graphics drivers into the kernel is
> that when they don't work the user gets no screen, with network/sound
> etc this isn't so bad, but if they can't see a screen debugging gets
> to be a bit more difficult....

Yeah - this is why the work I was doing kept the old vgacon around and used 
fbcon on those platforms that needed it (unchanged). My plan was to add a 
graphics system that would "take over" from the boot console when it was 
ready to take over.

DRH
