Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbVCJACJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbVCJACJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVCJAA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:00:59 -0500
Received: from waste.org ([216.27.176.166]:24486 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262320AbVCIX5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:57:33 -0500
Date: Wed, 9 Mar 2005 15:57:16 -0800
From: Matt Mackall <mpm@selenic.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, chrisw@osdl.org,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: Linux 2.6.11.2
Message-ID: <20050309235716.GZ3163@waste.org>
References: <20050309083923.GA20461@kroah.com> <Pine.LNX.4.61.0503090950200.7496@student.dei.uc.pt> <20050309111102.GA30119@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050309111102.GA30119@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 12:11:02PM +0100, Pavel Machek wrote:
> On St 09-03-05 09:52:46, Marcos D. Marado Torres wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > On Wed, 9 Mar 2005, Greg KH wrote:
> > 
> > >which is a patch against the 2.6.11.1 release.  If consensus arrives
> > >that this patch should be against the 2.6.11 tree, it will be done that
> > >way in the future.
> > 
> > IMHO it sould be against 2.6.11 and not 2.6.11.1, like -rc's that are'nt 
> > againt
> > the last -rc but against 2.6.x.
> 
> You expect people to go through all 2.6.11.1, 2.6.11.2, ... . That
> means .11.2 should be relative to .11.1, because otherwise people will
> have to revert (ugly). And you want people to track -stable kernels as
> fast as possible.

There are three ways we can do this:

a) all 2.6.x.y are diffs against 2.6.x
b) interdiffs for .1, .2, etc. with 2.6.x+1 diffed against 2.6.x
c) interdiffs and 2.6.12 is a diff against 2.6.11.last

Imagine we want to go from 2.6.11.3 to 2.6.12

case a)
revert patch 2.6.11.3
get and apply 2.6.12

case b)
revert patch 2.6.11.3
revert patch 2.6.11.2
revert patch 2.6.11.1
get and apply 2.6.12

case c)
poke around on kernel.org and figure out that the last kernel in .11 is .11.5
get and apply 2.6.11.4
get and apply 2.6.11.5
get and apply 2.6.12

Note this gets increasingly more painful in cases b and c when there
are a large number of post-releases. And case c) is really stupid when
you want to go from 2.6.12 to 2.6.11.

Also note that -pre, -rc, -bk, -mm, -ac, and every other branch off a
release has worked the a) way.

-- 
Mathematics is the supreme nostalgia of our time.
