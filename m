Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265883AbUBGB3J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 20:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265911AbUBGB3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 20:29:07 -0500
Received: from mail.kroah.org ([65.200.24.183]:23005 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265883AbUBGB2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 20:28:50 -0500
Date: Fri, 6 Feb 2004 17:28:41 -0800
From: Greg KH <greg@kroah.com>
To: James Simmons <jsimmons@infradead.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fbdev sysfs support.
Message-ID: <20040207012841.GG4492@kroah.com>
References: <20040207011916.GD4492@kroah.com> <Pine.LNX.4.44.0402070122270.19559-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402070122270.19559-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 01:23:29AM +0000, James Simmons wrote:
> 
> > This function will not get called until the sysfs node stops being busy,
> > so it should all work properly.  But only if that fb_info structure was
> > allocated dynamically, unlike all of the current fb drivers (see my
> > other comment about this patch.)
> > 
> > So in that case, this will cause us to try to call kfree on a static
> > structure :(
> 
> I plan to move every driver to framebuffer_alloc. 

When?  With this patchset?  Or at a later time?  It all needs to be done
at the same time to prevent easy kernel oopses.

thanks,

greg k-h
