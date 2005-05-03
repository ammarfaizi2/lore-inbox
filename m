Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVECB3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVECB3f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 21:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVECB3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 21:29:35 -0400
Received: from fire.osdl.org ([65.172.181.4]:40619 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261279AbVECB3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 21:29:31 -0400
Date: Mon, 2 May 2005 18:28:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: jdike@addtoit.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/22] UML - Include the linker script rather than
 symlink it
Message-Id: <20050502182851.27f22470.akpm@osdl.org>
In-Reply-To: <20050503011744.GC18977@parcelfarce.linux.theplanet.co.uk>
References: <200505012112.j41LC9fa016385@ccure.user-mode-linux.org>
	<20050502170654.248b11ea.akpm@osdl.org>
	<20050503002521.GA18977@parcelfarce.linux.theplanet.co.uk>
	<20050502174405.0c8cad31.akpm@osdl.org>
	<20050503011744.GC18977@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@parcelfarce.linux.theplanet.co.uk> wrote:
>
> On Mon, May 02, 2005 at 05:44:05PM -0700, Andrew Morton wrote:
> > 
> > There's a bit of a tangle going on in arch/um/kernel/Makefile, but it's
> > fairly simple stuff.
> > 
> > I put a rolled-up patch against 2.6.12-rc3 at
> > http://www.zip.com.au/~akpm/linux/patches/stuff/x.bz2 if someone wants to
> > check it all.
> 
> Broken, due to missing mk_sc patch (it should go before mk_thread one;

OK.  I ended up with an odd-looking arch/um/sys-x86_64/util/Makefile:



# Copyright 2003 - 2004 Pathscale, Inc
# Released under the GPL

hostprogs-y	:= mk_sc mk_thread
always		:= $(hostprogs-y)

HOSTCFLAGS_mk_thread.o := -I$(objtree)/arch/um


Is mk_sc still supposed to be in there?

> how the hell did the latter manage to apply at all?)

I just "fixed" things.  I do it all the time.

> > Is this all considered post-2.6.12 material?
> 
> Once all patches are in there - up to Jeff ;-)  Seriously, kbuild patchkit
> is decently tested and has obviously no impact on other architectures.  So
> that one is up to maintainer of architecture in question...

OK..
