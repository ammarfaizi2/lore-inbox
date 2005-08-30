Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbVH3SNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVH3SNh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 14:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVH3SNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 14:13:37 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:20301 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932251AbVH3SNg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 14:13:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wlv3vSQ+S7pjoUdyZBkG9BNyonhw6A8D4pyhuVNhU9YH4cxCBmUXfkWUwOSjBLFJPXlpqGLUe7l1mCT0LZ2s01n3PqGAz3zqilloPVM3AAX3OQvM4F3EJ3V272fD/D1XkxVP+ljiSYrWMMexLPKKpS4MM+QqYJL/Mmg0k65DFyU=
Message-ID: <9e4733910508301113593e56e5@mail.gmail.com>
Date: Tue, 30 Aug 2005 14:13:35 -0400
From: Jon Smirl <jonsmirl@gmail.com>
To: David Reveman <davidr@novell.com>
Subject: Re: State of Linux graphics
Cc: lkml <linux-kernel@vger.kernel.org>,
       Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>
In-Reply-To: <1125422813.20488.43.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e47339105083009037c24f6de@mail.gmail.com>
	 <1125422813.20488.43.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/05, David Reveman <davidr@novell.com> wrote:
> > Xgl was designed as a near term transition solution. The Xgl model
> > was to transparently replace the drawing system of the existing
> > X server with a compatible one based on using OpenGL as a device
> > driver. Xgl maintained all of the existing X APIs as primary APIs.
> > No new X APIs were offered and none were deprecated.
> ..
> > But Xgl was a near term, transition design, by delaying demand for
> > Xgl the EXA bandaid removes much of the need for it.
> 
> I've always designed Xgl to be a long term solution. I'd like if
> whatever you or anyone else see as not long term with the design of Xgl
> could be clarified.

Xgl doesn't run standalone, it needs either Xegl or Xglx. Xglx isn't
really interesting since you're running an X server inside of another
one. It's a good environment for software developers but I don't think
you would want to base a desktop distribution on it.

The leaves Xegl. If Xegl were to enter widespread use by the end of
2006 it would be the right solution. But I don't think it is going to
make it anywhere close to the end of 2006 since X11R7 and EXA are
going to be released in front of it. I suspect those two releases will
just be getting widespread by the end of 2006.

So we are looking at 2007. That means two more year's advances in
hardware and things like a NV 6800GT will be $40. In that timeframe
programmable hardware will be mainstream. We also have time to fix
some of the problem in the current server. As described at the end of
the paper a new server design would feature OpenGL as it's primary
API, xlib would still be supported but at a secondary status.

> We already had a new drawing API for X, the X Render extension. Xgl is
> the first server to fully accelerate X Render.

I think the EXA people will say they have the first server in
distribution that fully accelerates X Render.

> 
> > Linux is now guaranteed to be the last major desktop to implement a
> > desktop GUI that takes full advantage of the GPU.
> 
> I'm not certain of that.

I can't see any scenario where Linux can put together a full GPU based
desktop before MS/Apple. We aren't even going to be close, we are at
least a year behind. Even if we fix the server all of the desktop
components need time to adjust too.

> 
> > In general, the whole concept of programmable graphics hardware is
> > not addressed in APIs like xlib and Cairo. This is a very important
> > point. A major new GPU feature, programmability is simply not
> > accessible from the current X APIs. OpenGL exposes this
> > programmability via its shader language.
> 
> That's just because we haven't had the need to expose it yet. I don't
> see why this can't be exposed through the Render extension. The trickier
> part is to figure out how we should expose it through the cairo API but
> that's not an X server design problem.

It will be interesting to read other X developer's comments on
exposing programmable graphics via render.

-- 
Jon Smirl
jonsmirl@gmail.com
