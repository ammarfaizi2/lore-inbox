Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTKERjh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 12:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbTKERjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 12:39:37 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:65509 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263077AbTKERjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 12:39:36 -0500
Date: Wed, 5 Nov 2003 18:39:07 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matt <dirtbird@ntlworld.com>, herbert@gondor.apana.org.au,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [MOUSE] Alias for /dev/psaux
Message-ID: <20031105173907.GA27922@ucw.cz>
References: <3FA91493.7060009@ntlworld.com> <Pine.LNX.4.44.0311050818240.11208-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311050818240.11208-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05, 2003 at 08:27:30AM -0800, Linus Torvalds wrote:

> On Wed, 5 Nov 2003, Matt wrote:
> >
> > had excatly the same problem moving to test9-mm1, way i fixed it was to 
> > pass the options "psmouse_rate=60 psmouse_resolution=200" to the kernel 
> > at boot (these were the old defaults).
> 
> Can you guys test passing in "psmouse_noext=1" instead?
> 
> The thing is, the psmouse initialization in 2.4.x does _nothing_. Nada. 
> Zilch. Zero. And it obviously works fine. So the 2.6.x code is apparently 
> just _crap_.
> 
> The extended psmouse detection code will try different things, and one 
> thing in particular is that the Logitech magic ID matching sets the 
> resolution to zero, while the IntelliMouse thing sets the rate to 80.

We could save the bootup mouse settings (the mouse will tell us) and
restore them after we go trough all the probing if desired.

That is, if it's really really needed not to change the default mouse
settings.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
