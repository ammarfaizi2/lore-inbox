Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265629AbUBGBcX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 20:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265911AbUBGBcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 20:32:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31112 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265629AbUBGBby
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 20:31:54 -0500
Date: Sat, 7 Feb 2004 01:31:53 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Greg KH <greg@kroah.com>
Cc: James Simmons <jsimmons@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fbdev sysfs support.
Message-ID: <20040207013153.GV21151@parcelfarce.linux.theplanet.co.uk>
References: <20040207011916.GD4492@kroah.com> <Pine.LNX.4.44.0402070122270.19559-100000@phoenix.infradead.org> <20040207012841.GG4492@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040207012841.GG4492@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 05:28:41PM -0800, Greg KH wrote:
> On Sat, Feb 07, 2004 at 01:23:29AM +0000, James Simmons wrote:
> > 
> > > This function will not get called until the sysfs node stops being busy,
> > > so it should all work properly.  But only if that fb_info structure was
> > > allocated dynamically, unlike all of the current fb drivers (see my
> > > other comment about this patch.)
> > > 
> > > So in that case, this will cause us to try to call kfree on a static
> > > structure :(
> > 
> > I plan to move every driver to framebuffer_alloc. 
> 
> When?  With this patchset?  Or at a later time?  It all needs to be done
> at the same time to prevent easy kernel oopses.

It doesn't, actually - you can move the drivers before touching sysfs with
no breakage at all.  The only reason why entire patchset needs to go at
the same time is that sysfs part is in the wrong place in sequence...
