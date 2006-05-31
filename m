Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbWEaKZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWEaKZl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 06:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWEaKZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 06:25:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:32909 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964953AbWEaKZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 06:25:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K5oD47fnK7CulJSzxoTk6LqHk9zJ+fi4O3/z4sKb00xXqvOG/VFv8exroY5cbcy7SwxwrE25JaAEEYhVpOJmkux2GApyN+Oq00HfBiBuRGUe3rmEGvCe1KK3TJ8ZTniofXtI2isQG5m1KaEBIdmuvg/myd+hV3FLbQw4xb2okVU=
Message-ID: <4423333a0605310325v18c069efiec9147d244e87406@mail.gmail.com>
Date: Wed, 31 May 2006 12:25:37 +0200
From: "Marko M" <marcus.magick@gmail.com>
To: "Ondrej Zajicek" <santiago@mail.cz>
Subject: Re: OpenGL-based framebuffer concepts
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060531082605.GA3925@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605272245.22320.dhazelton@enter.net>
	 <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>
	 <200605280112.01639.dhazelton@enter.net>
	 <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
	 <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com>
	 <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz>
	 <20060530223513.GA32267@localhost.localdomain>
	 <447CD367.5050606@gmail.com>
	 <20060531082605.GA3925@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is actually over my head, but would it be possible to dynamically
switch between two drivers by saving and restoring whole context, much
like in suspend-resume process?

Lowest layer of fbdev/DRM would control basic PCI/memory management
and load/unload appropriate (module) driver, so we could safely switch
between different hardware management (driver) policies. Or I'm just
to fancy?

On 5/31/06, Ondrej Zajicek <santiago@mail.cz> wrote:
> On Wed, May 31, 2006 at 07:21:11AM +0800, Antonino A. Daplas wrote:
> > > 2) To modify appropriate fbdev drivers to not do mode change at startup.
> > >    Fill fb_*_screeninfo with appropriate values for text mode instead.
> >
> > Most drivers do not change the mode at startup.  Do not load fbcon, and
> > you will retain your text mode even if a framebuffer is loaded.
>
> Yes, but i wrote about _using_ fbcon and fbdev without mode change.
>
> > > 3) (optional) To modify appropriate fbdev drivers to be able to switch
> > >    back from graphics mode to text mode.
> >
> > And a few drivers already do that, i810fb and rivafb.  Load rivafb or i810fb,
> > switch to graphics mode, unload, and you're back to text mode.
>
> I though about being able to explicitly change mode from graphics to text
> (for example when fbdev-only X switch to fbcon) while using fbdev.
>
> --
> Elen sila lumenn' omentielvo
>
> Ondrej 'SanTiago' Zajicek (email: santiago@mail.cz, jabber: santiago@njs.netlab.cz)
> OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
> "To err is human -- to blame it on a computer is even more so."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
