Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030999AbWKOVG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030999AbWKOVG0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 16:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031001AbWKOVG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 16:06:26 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:46982 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030999AbWKOVGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 16:06:25 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] floppy: suspend/resume fix
Date: Wed, 15 Nov 2006 22:03:21 +0100
User-Agent: KMail/1.9.1
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <200611122047.kACKl8KP004895@harpo.it.uu.se> <20061115204915.1d0717db@localhost.localdomain> <20061115204933.GD3875@elf.ucw.cz>
In-Reply-To: <20061115204933.GD3875@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611152203.21835.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 15 November 2006 21:49, Pavel Machek wrote:
> Hi!
> 
> > > > > Suspending with mounted floppy is a user error.
> > > > 
> > > > Huh?  How so?
> > > 
> > > Floppy is removable, and you are expected to umount removable devices
> > > before suspend.
> > 
> > That seems pretty crude. There are lots of cases where an apparently
> > removable device is/should be preserved properly and left mounted (eg
> > builtin CF).
> > 
> > We really want to be smarter than that - which means the drivers ought to
> > be doing stuff in their suspend/resume paths to figure out if the media
> > changed when really possible (eg IDE removable)
> > 
> > Floppy is probably not too fixable, but calling it a "user error" is
> > insulting - user expectation is reasonable that suspend/resume should
> > just work. The implementation is just rather trickier/nonsensical in this
> > case.
> 
> Yep, it would be nice to do something about that; but I'm not sure how
> this "was media changed" should be implemented, and if it should be
> done in kernel or in userland.

<heresy>
Use something like subfs?
</heresy>

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
