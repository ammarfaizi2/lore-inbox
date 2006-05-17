Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWEQNjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWEQNjf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 09:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWEQNjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 09:39:35 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:49318 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750828AbWEQNje convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 09:39:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e3BhqRmFPNg0oaG+0UUVB3/xcvILMZ/9T+msW5aU5xTWuc6d6VQ/x3cuNYPI0FCK/rSviQ6v38fWq7Q/NcHy3HV/p7ECNkzxdHMKGCeIIesr14Y+pw7OkOIhUb+HdM05Cw1bzez0lskOutxA/NcitCOFZUYUNwv2bkW/nwHc2iE=
Message-ID: <9a8748490605170639n12fde7c9i836599f02a30fd51@mail.gmail.com>
Date: Wed, 17 May 2006 15:39:33 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "linux cbon" <linuxcbon@yahoo.fr>
Subject: Re: replacing X Window System !
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20060517123937.75295.qmail@web26605.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200605171218.k4HCIt4L013978@turing-police.cc.vt.edu>
	 <20060517123937.75295.qmail@web26605.mail.ukl.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/06, linux cbon <linuxcbon@yahoo.fr> wrote:
>  --- Valdis.Kletnieks@vt.edu a écrit :
> > On Wed, 17 May 2006 13:47:22 +0200, linux cbon said:
> >
> > If it isn't backward compatible, people won't use
> > it.  X may suck,
> > but it doesn't suck hard enough that people will
> > abandon all their
> > currently mostly-working software.
>
> If we have a new window system, shall all applications
> be rewritten ?
>
Unless the new windowing system is 100% backwards compatible with X11, then yes.


>
> > Actually, you've proved the opposite.  Consider if
> > the kernel had *already*
> > included some universal window system (we'll call it
> > W). At that point, you
> > can't easily write an X, Y, or Z if you don't like
> > W.  If anything, the
> > *current* W (which happens to be called X11) is
> > *too* friendly with the kernel
> > already - witness all the headaches dealing with DRM
> > and 'enable' attributes
> > and other hoops things have to jump through.
> >
> > If anything, there should be even *less* kernel
> > support for graphics.
> > That way, writing a Y or Z (or improving X) is
> > easier to do without
> > destabilizing the kernel.
>
> My idea is that the kernel should include universal
> graphical support.
> And then we would NOT need ANY window system AT ALL.
> We wouldnt have 2 os (kernel and X) at the same time
> like now.
> It would be faster, simpler, easier to manage etc.
>
And when the windowing system crashes it'll take the kernel down with it - ouch.

And if I want to run a headless server without a graphical display I
can't simply stop the windowing system I'd have to rebuild a kernel
without the windowing system in it - yuck.

What we have now is a nicely decoupled system - it would be even
better if X was even more decoupled from the kernel, but lets not put
the windowing system in kernel space.

X is not perfect, but it has been around long enough that it has a
huge base of software using it. Throwing that out the window would be
silly.
X also has had networking support since the beginning, and all X apps
can run with remote displays without having to do much (if anything)
themselves to support that - that's a really nice feature.
Modern X can be quite fast with a properly supported graphics card,
and stuff like Xgl has just improved things even more recently.
X has good multihead support - another nice feature.
Graphics drivers for X run (usually/mostly) in userspace - nice, then
they don't destabilize the kernel.
And there's lots of other features as well.

Do you really want to put all that complexity into the kernel?


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
