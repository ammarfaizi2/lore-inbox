Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbWJXInw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbWJXInw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbWJXInw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:43:52 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:14278 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030218AbWJXInv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:43:51 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
Date: Tue, 24 Oct 2006 10:43:04 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <1161576857.3466.9.camel@nigel.suspend2.net> <20061023153257.GC8414@elf.ucw.cz> <1161644650.7033.23.camel@nigel.suspend2.net>
In-Reply-To: <1161644650.7033.23.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610241043.05233.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 24 October 2006 01:04, Nigel Cunningham wrote:
> Hi.
> 
> On Mon, 2006-10-23 at 17:32 +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > Switch from bitmaps to using extents to record what swap is allocated;
> > > they make more efficient use of memory, particularly where the allocated
> > > storage is small and the swap space is large.
> > 
> > > This is also part of the ground work for implementing support for
> > > supporting multiple swap devices.
> > 
> > bitmaps were more efficient and longer than original code... I did not
> > _like_ them, but they are in now. I'd hate to change the code again,
> > for what, 0.5% gain?
> 
> 0.5% of what? This is part of what is needed to implement support for
> multiple swap devices. You could extend what you already have,
> implementing bitmaps that require a bit for every page of swap the user
> has swapon'd, but that doesn't seem efficient to me.

I agree.  Further, I though I would change the bitmaps thing at some point,
but there still are more urgent things to do. ;-)

> > ...and this is still longer than bitmaps.

Yes, it is.  Still I'd like to have a thorough look at it.  The idea is fine by me.

> > And SNAPSHOT_GET_SWAP_PAGE seems to support multiple swap spaces
> > already.
> 
> It may do, but swap.c certainly doesn't. It supports exactly one device.

That's correct.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
