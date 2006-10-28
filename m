Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWJ1PZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWJ1PZA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 11:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWJ1PZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 11:25:00 -0400
Received: from [139.30.44.16] ([139.30.44.16]:53003 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1750877AbWJ1PY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 11:24:59 -0400
Date: Sat, 28 Oct 2006 17:24:57 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: Al Viro <viro@ftp.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: dealing with excessive includes
Message-ID: <Pine.LNX.4.63.0610281712180.29510@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006 10:31:26 +0100, Al Viro wrote:
> On Wed, Oct 18, 2006 at 01:19:44PM +0400, Alexey Dobriyan wrote:
> > > module.h is trickier.  First of all, we want extern for wake_up_process().
> > 
> > When I came up with this to l-k, Nick and Christoph told me that duplicate
> > proto sucks. So module.h/sched.h is
> > a) uninline module_put()
> > b) remove #include <linux/sched.h>
> 
> Works for me...  OTOH, wake_up_process() is not likely to change
> prototype, so I'm not sure how strong that argument actually is.
> 
> Anyway, that patch is obviously preliminary - at the very least
> it needs be checked on more configs (and more targets - e.g. mips and
> parisc hadn't been checked at all).  Probably worth putting in -mm for
> a while, too, or we'll get fun breakage on the next big merge from -mm.

So, has a patch emerged yet? I'd like to help checking and fixing things.

There shouldn't be too much fallout from that. I had a patch to uninclude 
sched.h from module.h in -mm for some time about a year ago.
All fixes necessary at that time should be in Linus' tree by now, just the 
final patch to module.h got dropped.

Tim
