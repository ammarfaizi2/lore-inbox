Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbTLXLd5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 06:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbTLXLd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 06:33:57 -0500
Received: from dyn-213-36-225-201.ppp.tiscali.fr ([213.36.225.201]:31500 "EHLO
	nsbm.kicks-ass.org") by vger.kernel.org with ESMTP id S263595AbTLXLd4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 06:33:56 -0500
Date: Wed, 24 Dec 2003 12:33:26 +0100
From: Witukind <witukind@nsbm.kicks-ass.org>
To: linux-kernel@vger.kernel.org
Cc: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: DevFS vs. udev
Message-Id: <20031224123326.2e8989ff.witukind@nsbm.kicks-ass.org>
In-Reply-To: <20031224034121.GH4176@parcelfarce.linux.theplanet.co.uk>
References: <20031223215910.GA15946@kroah.com>
	<Pine.LNX.4.33.0312240938450.890-100000@wombat.indigo.net.au>
	<20031223183820.5b297c50.akpm@osdl.org>
	<20031224034121.GH4176@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Dec 2003 03:41:21 +0000
viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Tue, Dec 23, 2003 at 06:38:20PM -0800, Andrew Morton wrote:
>  
> > And yes, there are architectural/cleanliness issues with devfs.  In
> > 2.5 Adam Richter totally reinventing devfs's internals, basing it
> > around the ramfs infrastructure.  If we elect to retain devfs in 2.8
> > then that effort should be resurrected.
> 
> Switching internals to ramfs won't be enough, though.  There are
> problems with devfs API that can't be solved by work on internals -
> lifetime rules for devfs nodes make no sense.  Take a look at the
> insertion/removal primitives and think of the lifetime rules they
> create for directories and user-created nodes.  _That_ is independent
> from the way you implement the internals (and sanitized version of the
> interface won't fit into use of ramfs, BTW).

What's the difference that prevents Linux from having a "good" devfs since
FreeBSD is happy with this feature? 

-- 
Jabber: heimdal@jabber.org
