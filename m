Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbTKESEC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 13:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbTKESEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 13:04:02 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:14054 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263019AbTKESD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 13:03:59 -0500
Date: Wed, 5 Nov 2003 19:03:21 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Matt <dirtbird@ntlworld.com>,
       herbert@gondor.apana.org.au,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [MOUSE] Alias for /dev/psaux
Message-ID: <20031105180321.GC27922@ucw.cz>
References: <20031105173907.GA27922@ucw.cz> <Pine.LNX.4.44.0311050942461.11208-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311050942461.11208-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05, 2003 at 09:49:42AM -0800, Linus Torvalds wrote:

> On Wed, 5 Nov 2003, Vojtech Pavlik wrote:
> > 
> > We could save the bootup mouse settings (the mouse will tell us) and
> > restore them after we go trough all the probing if desired.
> 
> That sounds like a good idea. At least for the mice that we didn't 
> recognize, that otherwise get basically "random" commands.
> 
> How about something like this:
> 
>  - if "mouse_noext" is set (which implies that we won't be doing any 
>    probing), we also don't set rate/precision unless the user asked us.
> 
>    Thus "psmouse_noext" becomes the "ultra-safe" setting. We still want to 
>    have some way to set things like wheel etc info by hand later on (ie as
>    a response to the user _telling_ us what mouse it is), but that's a
>    more long-range plan.
> 
>  - if we do probing, we first ask the mouse for its current details, and 
>    we restore the thing by default afterwards. That at least should give 
>    us 2.4.x behaviour unless the mouse is broken (and for broken mice 
>    you'd just have to have "mouse_noext").
> 
>    Again, long-term we'd want to have the possibility of tweaking the 
>    results later even with the autodetection.
> 
> Does that sound like a reasonable plan?

Yes, it does.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
