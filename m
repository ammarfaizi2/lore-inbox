Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWBVTHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWBVTHL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 14:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWBVTHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 14:07:10 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:22697
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751401AbWBVTHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 14:07:09 -0500
Date: Wed, 22 Feb 2006 11:07:00 -0800
From: Greg KH <gregkh@suse.de>
To: "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
       penberg@cs.helsinki.fi, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060222190700.GA14252@suse.de>
References: <1140383653.11403.8.camel@localhost> <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost> <20060221225718.GA12480@vrfy.org> <20060221153305.5d0b123f.akpm@osdl.org> <20060222000429.GB12480@vrfy.org> <20060221162104.6b8c35b1.akpm@osdl.org> <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org> <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org> <20060222112158.GB26268@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222112158.GB26268@thunk.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 06:21:58AM -0500, Theodore Ts'o wrote:
> If we want more and more stuff to be poured into initrd, it's got to
> be made easier to debug and consistent across distributions, such that
> more people can test initrd configurations, and flush out the bugs,
> never mind the question of programs like udev randomly breaking
> between kernel releases.  Maybe it's time to consider moving all of
> that into the kernel source; if they wanted to be treated as part of
> the kernel, then let them liteally become part of the kernel from a
> source code and release management perspective.

With the klibc patches that move even more stuff in the early boot
process out into userspace, I would tend to agree with you about this.
If those changes ever go in, we will already have the framework to keep
these tools in the tree, and a method for building them

Discussions about if you want to use klibc for a long-running daemon
like udevd is for another time :)

thanks,

greg k-h
