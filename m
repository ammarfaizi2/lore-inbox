Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUBXIix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 03:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbUBXIix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 03:38:53 -0500
Received: from witte.sonytel.be ([80.88.33.193]:34494 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261628AbUBXIhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 03:37:24 -0500
Date: Tue, 24 Feb 2004 09:37:12 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: fbdv/fbcon pending problems
In-Reply-To: <1077576644.5960.77.camel@gaston>
Message-ID: <Pine.GSO.4.58.0402240936270.3187@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0402231823570.11599-100000@phoenix.infradead.org>
 <1077576644.5960.77.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004, Benjamin Herrenschmidt wrote:
> On Tue, 2004-02-24 at 05:59, James Simmons wrote:
> > I think we should do better validating of the var passed in. This also
> > needs a bit of work.
>
> It does. Radeonfb did one step in this direction, but that's not
> enough. _BUT_ we still need to differenciate between a full mode
> passed from userland from a mode where we _KNOW_ everything is
> bogus but width/height... In the later case, we really want to
> find a mode that is just large enough for the passed in width/height
> (but not smaller, or just fail if not found) and with the same
> hfreq if possible as the current mode. That's really a different
> request than a full blown mode coming from userland (like a 'tuning'
> tool or whatever...)
>
> The FB_ACTIVATE_FIND is just that. It justs tells the driver to
> pick up a mode based on width/height only. We know the rest of
> the var is bogus.

What about renaming it to FB_ACTIVE_RESIZE?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
