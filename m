Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbWFLIch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWFLIch (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 04:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWFLIcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 04:32:36 -0400
Received: from witte.sonytel.be ([80.88.33.193]:64738 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751039AbWFLIcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 04:32:35 -0400
Date: Mon, 12 Jun 2006 10:31:56 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Jon Smirl <jonsmirl@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 5/5] VT binding: Add new doc file
 describing the feature
In-Reply-To: <448B7594.6040408@gmail.com>
Message-ID: <Pine.LNX.4.62.0606121029010.7668@pademelon.sonytel.be>
References: <44893407.4020507@gmail.com>  <9e4733910606092253n7fe4e074xe54eaec0fe4149f3@mail.gmail.com>
  <448AC8BE.7090202@gmail.com>  <9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>
  <448B38F8.2000402@gmail.com>  <9e4733910606101644j79b3d8a5ud7431564f4f42c7f@mail.gmail.com>
  <448B61F9.4060507@gmail.com>  <9e4733910606101749r77d72a56mbcf6fb3505eb1de0@mail.gmail.com>
 <9e4733910606101805t3060c0cdgd08ceabe8cfe4e0e@mail.gmail.com>
 <448B7594.6040408@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jun 2006, Antonino A. Daplas wrote:
> Jon Smirl wrote:
> > On 6/10/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> >> On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> >> > > I see now that you can have tty0-7 assigned to a different console
> >> > > driver than tty8-63.
> >> > > Why do I want to do this?
> >> >
> >> > Multi-head.  I can have vgacon on the primary card for tty0-7,
> >> > fbcon on the secondary card for tty8-16.
> >>
> > 
> > When I say dropped, I mean drop the feature of having multiple drivers
> > simultaneously open by the VT layer. You would still be able to switch
> > from vgacon to fbcon by using sysfs. You just wouldn't be able to use
> > VT swap hotkeys between them.
> 
> Quoting you:
> 
> "Googling around the only example I could find was someone with a VGA
> card and a Hercules card. They setup 8 consoles on each card."
> 
> How do you think they accomplished that? They did not rewrite the VT
> layer, all they need to do is change the 'first' and 'last' parameter
> passed to take_over_console() in mdacon.c.  This implies that the VT
> layer already supports multiple active VT console drivers, maybe as
> early as 2.2, and no, we won't remove that.

JFYI, probably 2.1.x. Multi-head dates back to at least 1996.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
