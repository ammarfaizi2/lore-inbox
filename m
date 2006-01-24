Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWAYALo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWAYALo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 19:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWAYALo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 19:11:44 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:713 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750864AbWAYALn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 19:11:43 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm] swsusp: userland interface (rev 2)
Date: Wed, 25 Jan 2006 00:53:26 +0100
User-Agent: KMail/1.9
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200601240929.37676.rjw@sisk.pl> <20060124135843.739481e7.akpm@osdl.org> <20060124221426.GB1602@elf.ucw.cz>
In-Reply-To: <20060124221426.GB1602@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601250053.27394.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 24 January 2006 23:14, Pavel Machek wrote:
> > > > > This patch introduces a user space interface for swsusp.
> > > > 
> > > > How will we know if/when this feature is ready for mainline?  What criteria
> > > > can we use to judge that?
> > > 
> > > It was stable for me last time I tested. I do not think it needs
> > > longer -mm testing than usual patches.
> > 
> > One we've shipped the interface we're kinda stuck with it for ever, so it
> > does want to be pretty mature.
> 
> Well, I think we got the interface pretty much right -- and it is
> really pretty simple. It survived pretty nasty stress testing at one
> point.

I think the ioctls defined so far won't change.  However, it's possible we'll
need some more (for example the suspend console handling is not
optimal now, so to speak).

IMHO the current version is sufficient to start with, but now we should
start working on userland tools seriously.  Then it'll turn out what else
is necessary.

> Of course, bad things happen. Having it merged but disabled in
> Makefile would certainly be preferred than not merged at
> all. Plus... stable kernel or not, it is new feature, and userland
> suspending programs are quite closely tied to the kernel. I think it
> is reasonable to expect users to have matching version of kernel and
> userland-swsusp tools, at least before dust settles.

I'm afraid that would be a nightmare for distributors who decide to use it.

IMHO after it gets into mainline every next version of the interface should
be backwards compatible with the previous one.

Greetings,
Rafael
