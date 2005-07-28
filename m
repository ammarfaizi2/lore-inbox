Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVG1NJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVG1NJk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 09:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVG1NJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 09:09:40 -0400
Received: from mail1.kontent.de ([81.88.34.36]:48834 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261436AbVG1NJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 09:09:11 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Date: Thu, 28 Jul 2005 15:09:39 +0200
User-Agent: KMail/1.8
Cc: Mitchell Blank Jr <mitch@sfgoth.com>, Greg KH <greg@kroah.com>,
       dtor_core@ameritech.net, linux-kernel@vger.kernel.org
References: <20050726003018.GA24089@kroah.com> <20050728070455.GF9985@gaz.sfgoth.com> <9e47339105072805545766f97d@mail.gmail.com>
In-Reply-To: <9e47339105072805545766f97d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507281509.40118.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 28. Juli 2005 14:54 schrieb Jon Smirl:
> On 7/28/05, Mitchell Blank Jr <mitch@sfgoth.com> wrote:
> > Greg KH wrote:
> > > > +   /* locate trailng white space */
> > > > +   z = y = x;
> > > > +   while (y - buffer->page < count) {
> > > > +           y++;
> > > > +           z = y;
> > > > +           while (isspace(*y) && (y - buffer->page < count)) {
> > > > +                   y++;
> > > > +           }
> > > > +   }
> > > > +   count = z - x;
> > >
> > > Hm, I _think_ this works, but I need someone else to verify this...
> > > Anyone else?
> > 
> > It looks sane-ish to me, but also more complicated than need be.  Why can't
> > you just do something like:
> > 
> >         while (count > 0 && isspace(x[count - 1]))
> >                 count--;
> > 
> > -Mitch
> > 
> 
> Do we need to deal with UTF8 here? I did the forward loop because you
> can't parse UTF8 backwards. If UTF8 is possible I need to change the
> pointer inc function.

This considerations show that having parsing code in kernel space is
a questionable idea. Are you absolutely sure that you cannot do with less?

	Regards
		Oliver
