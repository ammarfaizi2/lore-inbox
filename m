Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbTIETBv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 15:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTIETBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 15:01:51 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:19333
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262540AbTIETBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 15:01:49 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Jeff Garzik <jgarzik@pobox.com>, Patrick Mochel <mochel@osdl.org>
Subject: Re: Fix up power managment in 2.6
Date: Fri, 5 Sep 2003 14:57:37 -0400
User-Agent: KMail/1.5
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>
References: <200309050158.36447.rob@landley.net> <Pine.LNX.4.44.0309051044470.17174-100000@cherise> <20030905180248.GB29353@gtf.org>
In-Reply-To: <20030905180248.GB29353@gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309051457.37241.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 September 2003 14:02, Jeff Garzik wrote:
> On Fri, Sep 05, 2003 at 10:47:49AM -0700, Patrick Mochel wrote:
> > > the power LED still on and the hibernate light off, and the thing's a
> > > brick at that point; the only thing you can do is hold the power button
> > > down for ten seconds or pop the battery to get it to boot back up from
> > > scratch.)  So I have to shut the sucker down every time I want to move
> > > it, which is a pain...
> >
> > What model is it? It probably doesn't support APM at all. I can't
> > guarantee that ACPI suspend/resume will work on it, but I'm interested to
> > see if it does..
>
> Note that a lot of ThinkPads out in the field need a BIOS update
> before their ACPI is working.  (I know this because IBM was quite
> helpful and proactive in addressing their Linux-related ACPI BIOS
> issues)
>
> 	Jeff

ACPI currently works fine in terms of IRQ routing, sensing when the lid closes 
and the power button gets pressed, telling me how much battery power is left 
and when I disconnect the AC adapter from the wall...

I was hoping software suspend would avoid having to have IBM firmware involved 
in the suspend process at all (it can boot, it can shut down, I just want it 
to snapshot process state so it comes up with the same things up on the 
desktop as last time).

And then if I just get alsa configured I'll have every single thing on my new 
laptop working under 2.6.  (Well, okay, then I'll need to tackle USB.  But 
every single thing I've tried to use so far, anyway. :)

P.S.  I reeeeeeeeeeeeeeeeeally hate it the way the keys on the keyboard 
sometimes have an up event delayed (or miss it entirely) and decide to 
auto-repeat insanely fast.  It happens about twice an hour.  I've seen mouse 
clicks do it as well.  Not a show-stopper, just annoying.

Okay, once it did it during boot, and the beast was unusable.  X recovers when 
you hit the next key, the console apparently does not.

Rob
