Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267781AbTAHIoY>; Wed, 8 Jan 2003 03:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267782AbTAHIoY>; Wed, 8 Jan 2003 03:44:24 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:21210 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267781AbTAHIoX>;
	Wed, 8 Jan 2003 03:44:23 -0500
Date: Wed, 8 Jan 2003 09:52:53 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: Joshua Kwan <joshk@ludicrus.ath.cx>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: [2.5.54-dj1-bk] Some interesting experiences...
Message-ID: <20030108095253.B23278@ucw.cz>
References: <20030107172147.3c53efa8.joshk@ludicrus.ath.cx> <20030108015107.GA2170@gagarin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030108015107.GA2170@gagarin>; from andersg@0x63.nu on Wed, Jan 08, 2003 at 02:51:07AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 02:51:07AM +0100, Anders Gustafsson wrote:
> On Tue, Jan 07, 2003 at 05:21:46PM -0800, Joshua Kwan wrote:
> > 
> > 3. [linux-2.5] PS/2 mouse goes haywire every 30 seconds or so of use.
> > dmesg sayeth:
> > mice: PS/2 mouse device common for all mice
> > input: PS/2 Synaptics TouchPad on isa0060/serio4
> > 
> > but more importantly this is the cause:
> > 
> > psmouse.c: Lost synchronization, throwing 2 bytes away.
> > psmouse.c: Lost synchronization, throwing 2 bytes away.
> 
> This happens here too. But not that frequent at all, more like once every
> hour. And has happend on all kernels since at least 2.5.46 [1].
> 
> However 5 hours ago I changed the timeout in psmouse.c from 50ms to 100ms.
> And now it haven't misbehaved yet, but that might be just some nightly luck. 
> Is there something that turns off interupts or something and hinders the
> mouse driver from processing the data for such long time? Or is my hardware
> just buggy?

That I'd like to know, too. In the worst case, we can make the timeout
be half a second, or more - it'd just mean that for a resync you would
have to not touch the mouse this long if really a byte is lost.

> [1] http://marc.theaimsgroup.com/?l=linux-kernel&m=103688231622278&w=2
> 
> -- 
> Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/

-- 
Vojtech Pavlik
SuSE Labs
