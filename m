Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbTI3MG1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 08:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbTI3MG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 08:06:27 -0400
Received: from dspnet.fr.eu.org ([62.73.5.179]:20499 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S261368AbTI3MGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 08:06:25 -0400
Date: Tue, 30 Sep 2003 14:06:23 +0200
From: Olivier Galibert <galibert@pobox.com>
To: "David S. Miller" <davem@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, bunk@fs.tum.de,
       acme@conectiva.com.br, netdev@oss.sgi.com, pekkas@netcore.fi,
       lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Message-ID: <20030930120622.GA24747@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"David S. Miller" <davem@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, bunk@fs.tum.de,
	acme@conectiva.com.br, netdev@oss.sgi.com, pekkas@netcore.fi,
	lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20030928225941.GW15338@fs.tum.de> <20030928231842.GE1039@conectiva.com.br> <20030928232403.GX15338@fs.tum.de> <20030929220916.19c9c90d.davem@redhat.com> <1064903562.6154.160.camel@imladris.demon.co.uk> <20030930000302.3e1bf8bb.davem@redhat.com> <1064907572.21551.31.camel@hades.cambridge.redhat.com> <20030930010855.095c2c35.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930010855.095c2c35.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 01:08:55AM -0700, David S. Miller wrote:
> On Tue, 30 Sep 2003 08:39:33 +0100
> David Woodhouse <dwmw2@infradead.org> wrote:
> > 99% or more of tristate options can be enabled without affecting the
> > kernel, and it is expected that such options can be set to 'm' later,
> > while the kernel in question is actually running, then built and loaded
> > without a reboot.
> 
> Expected by whom?  Not by me.

By me for instance.  I'm used to modules having no influence until
loaded, even at compilation time.  I'm used to in-tree and out-of-tree
modules to have exactly the same status (ignoring the binary-only
modules crap).


> > We should strive to keep this true.
> 
> For things _OUTSIDE_ the kernel, surely.  But inside the kernel
> tree I don't see any value in this new restriction.
> 
> > 	Allow this kernel to ever support IPv6? Y/N
> > 	Build IPv6 support? Y/M/N
> 
> And I still think this is a complete joke.

I suspect what you _really_ want is a "disable ipv6 entirely"
depending on CONFIG_EMBEDDED which would remove the then bloat.
Normal users would never see it and the meaning would be obvious for
the ones who care.

  OG.
