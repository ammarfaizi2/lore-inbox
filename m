Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263227AbUEWSDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbUEWSDV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 14:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbUEWSDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 14:03:21 -0400
Received: from waste.org ([209.173.204.2]:65175 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263227AbUEWSDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 14:03:18 -0400
Date: Sun, 23 May 2004 13:03:02 -0500
From: Matt Mackall <mpm@selenic.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040523180302.GW5414@waste.org>
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org> <1085299337.2781.5.camel@laptop.fenrus.com> <20040523152540.GA5518@kroah.com> <20040523153510.GA24628@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040523153510.GA24628@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 05:35:10PM +0200, Arjan van de Ven wrote:
> On Sun, May 23, 2004 at 08:25:40AM -0700, Greg KH wrote:
> > On Sun, May 23, 2004 at 10:02:17AM +0200, Arjan van de Ven wrote:
> > > On Sun, 2004-05-23 at 08:46, Linus Torvalds wrote:
> > > > Hola!
> > > > 
> > > > This is a request for discussion..
> > > 
> > > Can we make this somewhat less cumbersome even by say, allowing
> > > developers to file a gpg key and sign a certificate saying "all patches
> > > that I sign with that key are hereby under this regime". I know you hate
> > > it but the FSF copyright assignment stuff at least has such "do it once
> > > for forever" mechanism making the pain optionally only once.
> > 
> > I don't think that adding a single line to ever patch description is
> > really "pain".  Especially compared to the FSF proceedure :)
> > 
> > Also, gpg signed patches are a pain to handle on the maintainer's side
> > of things, speaking from personal experience.  However our patch
> > handling scripts could probably just be modified to fix this issue, but
> > no one's stepped up to do it.
> 
> I'll buy that
> 
> >  And we'd have to start messing with the
> > whole "web of trust" thing, which would keep us from being able to
> > accept a patch from someone in a remote location with no way of being
> > able to add their key to that web, causing _more_ work to be done to get
> > a patch into the tree than Linus's proposal entails.
> 
> But I don't buy this. No web of trust is needed if all that is happening is
> filing a form ONCE saying "all patch submissions signed with THIS key are
> automatically certified". That doesn't prevent non-gpg users from using the
> proposed mechanism nor involves web of trust metrics.

a) without the web of trust, it's not much stronger than the original
method
b) it's a second method so signing off is no longer a uniform process
c) it requires tools and a database
d) it adds significant amounts of cruft to patches
e) said cruft is fragile and won't survive minor edits along the way

That last point is key - we can't propagate a GPG signature upstream
_with revisions_. Trivial revisions of the form 'rediff against latest
kernel' are to be assumed.

-- 
Mathematics is the supreme nostalgia of our time.
