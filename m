Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWBVTSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWBVTSj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 14:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWBVTSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 14:18:39 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:60809
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751414AbWBVTSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 14:18:37 -0500
Date: Wed, 22 Feb 2006 11:18:32 -0800
From: Greg KH <gregkh@suse.de>
To: Gabor Gombas <gombasg@sztaki.hu>, "Theodore Ts'o" <tytso@mit.edu>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kay Sievers <kay.sievers@suse.de>, penberg@cs.helsinki.fi,
       bunk@stusta.de, rml@novell.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060222191832.GA14638@suse.de>
References: <20060221153305.5d0b123f.akpm@osdl.org> <20060222000429.GB12480@vrfy.org> <20060221162104.6b8c35b1.akpm@osdl.org> <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org> <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org> <20060222112158.GB26268@thunk.org> <20060222154820.GJ16648@ca-server1.us.oracle.com> <20060222162533.GA30316@thunk.org> <20060222173354.GJ14447@boogie.lpds.sztaki.hu> <20060222185923.GL16648@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222185923.GL16648@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 10:59:23AM -0800, Joel Becker wrote:
> On Wed, Feb 22, 2006 at 06:33:54PM +0100, Gabor Gombas wrote:
> > I don't think isnmod is broken. It's job is to load a chunk of code into
> > the kernel, and it's doing just that.
> > 
> > ...
> >
> > But if your kernel has CONFIG_HOTPLUG enabled, then _you_ have asked for
> > this exact behavior, therefore you should better fix userspace to cope
> > with it. Your initrd should use the notification mechanisms provided by
> > the kernel to wait for the would-be root device really becoming
> > available; if it's not doing that, then IMHO you should not use a
> > CONFIG_HOTPLUG enabled kernel.
> 
>         The issue isn't so much "insmod is right" vs "insmod is wrong".
> It's that the behavior changed in a surprising fashion.  Red Hat's
> kernel for RHEL4 (in our example) has CONFIG_HOTPLUG=y, yet it Just
> Works.  A more recent kernel (.15 and .16 at least) with
> CONFIG_HOTPLUG=y doesn't work.  Same disk drivers.  Same initramfs
> script.

RHEL is a very different kernel from mainline (just like SLES is).  Have
you looked through their patches to see if they are including something
that causes this behavior?

What about trying a stock 2.6.6 or so kernel?  Does that work
differently from 2.6.15?

thanks,

greg k-h
