Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbVH3R3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbVH3R3f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 13:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVH3R3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 13:29:35 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:21209
	"EHLO gwia-smtp.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750930AbVH3R3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 13:29:35 -0400
Subject: Re: State of Linux graphics
From: David Reveman <davidr@novell.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>
In-Reply-To: <9e47339105083009037c24f6de@mail.gmail.com>
References: <9e47339105083009037c24f6de@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 30 Aug 2005 13:26:53 -0400
Message-Id: <1125422813.20488.43.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-30 at 12:03 -0400, Jon Smirl wrote:
> I've written an article that surveys the current State of Linux
> graphics and proposes a possible path forward. This is a long article
> containing a lot of detailed technical information as a guide to
> future developers. Skip over the detailed parts if they aren't
> relevant to your area of work.
> 
> http://www.freedesktop.org/~jonsmirl/graphics.html
> 
> Topics include the current X server, framebuffer, Xgl, graphics
> drivers, multiuser support, using the GPU, and a new server design.
> Hopefully it will help you fill in the pieces and build an overall
> picture of the graphics landscape.
> 
> The article has been reviewed but if it still contains technical
> errors please let me know. Opinions on the content are also
> appreciated.
> 

As the author of Xgl and glitz I'd like to comment on a few things.

>From the article:

> Xgl was designed as a near term transition solution. The Xgl model
> was to transparently replace the drawing system of the existing
> X server with a compatible one based on using OpenGL as a device
> driver. Xgl maintained all of the existing X APIs as primary APIs.
> No new X APIs were offered and none were deprecated.
..
> But Xgl was a near term, transition design, by delaying demand for
> Xgl the EXA bandaid removes much of the need for it.

I've always designed Xgl to be a long term solution. I'd like if
whatever you or anyone else see as not long term with the design of Xgl
could be clarified.

We already had a new drawing API for X, the X Render extension. Xgl is
the first server to fully accelerate X Render.


> Linux is now guaranteed to be the last major desktop to implement a
> desktop GUI that takes full advantage of the GPU. 

I'm not certain of that.


> In general, the whole concept of programmable graphics hardware is
> not addressed in APIs like xlib and Cairo. This is a very important
> point. A major new GPU feature, programmability is simply not
> accessible from the current X APIs. OpenGL exposes this
> programmability via its shader language.

That's just because we haven't had the need to expose it yet. I don't
see why this can't be exposed through the Render extension. The trickier
part is to figure out how we should expose it through the cairo API but
that's not an X server design problem.


-David

