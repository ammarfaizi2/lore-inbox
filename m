Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbWD0C1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWD0C1n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 22:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWD0C1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 22:27:43 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:35563 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964895AbWD0C1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 22:27:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
cc: David Woodhouse <dwmw2@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Simple header cleanups 
In-reply-to: Your message of Wed, 26 Apr 2006 19:18:52 PDT.
             <Pine.LNX.4.64.0604261917270.3701@g5.osdl.org> 
Date: Wed, 26 Apr 2006 19:27:27 -0700
Message-Id: <E1FYwE4-00047r-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Apr 2006 19:18:52 PDT, Linus Torvalds wrote:
> 
> 
> On Thu, 27 Apr 2006, David Woodhouse wrote:
> >
> > Andrew (or preferably Linus since these are fairly simple and
> > unintrusive bug fixes), please pull from my tree at 
> > git://git.infradead.org/hdrcleanup-2.6.git
> 
> Hmm. Every time we've done this in the past, something has broken, so I'd 
> actually _much_ rather wait until early in the 2.6.18 cycle than do it 
> now.
> 
> Yeah, people shouldn't include kernel headers, but if they didn't, this 
> patch wouldn't matter. And when they do, patches like this tends to show 
> some strange app that depends on the current header layout.. Gaah.
> 
> 		Linus

Except there are a few things you can't use in user space now, like
connectors, without including a kernel header file.  So, should apps
duplicate the structures and definitions in each and every application and
hopefully notice when the kernel API changes?  Seems painful.

Plus, do we really want Apache or other licensed software directly
including GPL header files?  Oh what a tangled web we weave when we suck
GPL headers into other applications.

Damned if you do, damned if you don't.

gerrit
