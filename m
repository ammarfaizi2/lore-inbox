Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUHGOoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUHGOoJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 10:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUHGOoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 10:44:09 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:55308 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262574AbUHGOoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 10:44:06 -0400
Date: Sat, 7 Aug 2004 15:43:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: Ian Romanick <idr@us.ibm.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: DRM function pointer work..
Message-ID: <20040807154357.A18510@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>, Ian Romanick <idr@us.ibm.com>,
	dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0408031427540.31513@skynet> <Pine.LNX.4.58.0408041201490.30393@skynet> <41128B90.5070702@us.ibm.com> <Pine.LNX.4.58.0408052338010.9947@skynet> <4112C09B.1070603@us.ibm.com> <Pine.LNX.4.58.0408060043300.9947@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0408060043300.9947@skynet>; from airlied@linux.ie on Fri, Aug 06, 2004 at 12:54:26AM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 12:54:26AM +0100, Dave Airlie wrote:
> 
> > I guess one (unpleasant) way to make it work would be to add the version to
> > all the symbols in the device-independent layer.  Instead of drm_foo you'd
> > have drm_foo_100 or drm_foo_101 or whatever.  You could then have multiple
> > modules loaded or a module loaded with a built-in version.  I'm not sure how
> > happy that would make the kernel maintainers (not to mention how happy it
> > would make us). :(  It's basically like what we have now, except the current
> > code has the device's name add to all the symbols and is built into the
> > device-dependent module.  Ugh, ugh.
> >
> > How do other multi-layer kernel modules handle this?  For example, how does
> > agpgart or iptables do it?

Just make sure the driver core and subdrivers are always in sync. That's an
entirely sensible thing and how all other subsystems with lowlevel calls work.
