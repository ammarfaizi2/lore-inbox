Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTI3J50 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 05:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbTI3J50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 05:57:26 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:4100 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261276AbTI3J5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 05:57:24 -0400
Date: Tue, 30 Sep 2003 11:57:21 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "David S. Miller" <davem@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, bunk@fs.tum.de,
       acme@conectiva.com.br, netdev@oss.sgi.com, pekkas@netcore.fi,
       lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Message-ID: <20030930095721.GA1036@mars.ravnborg.org>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, bunk@fs.tum.de,
	acme@conectiva.com.br, netdev@oss.sgi.com, pekkas@netcore.fi,
	lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <1064903562.6154.160.camel@imladris.demon.co.uk> <20030930000302.3e1bf8bb.davem@redhat.com> <1064907572.21551.31.camel@hades.cambridge.redhat.com> <20030930010855.095c2c35.davem@redhat.com> <1064910398.21551.41.camel@hades.cambridge.redhat.com> <20030930013025.697c786e.davem@redhat.com> <1064911360.21551.49.camel@hades.cambridge.redhat.com> <20030930015125.5de36d97.davem@redhat.com> <1064913241.21551.69.camel@hades.cambridge.redhat.com> <20030930022410.08c5649c.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930022410.08c5649c.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 02:24:10AM -0700, David S. Miller wrote:
> 
> > In the 2.6 kernel, I suspect that these same version strings are now
> > produced as a side-effect of the 'make vmlinux' stage, and hence that
> > it's required to 'make vmlinux' before any modules can be built.
> 
> What this means is that it's required for the kernel image to be up to
> date before any modules can be built.  If we can check that in the
> build system for the sake of modversions (and if we're not doing that
> now it's a bug we should fix) we can do it equally for ipv6.

There is a postprocessing step when building modules that take care
of modversioning. And yes, it requires a final vmlinux.

	Sam
