Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbTHSTfg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbTHSTeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:34:15 -0400
Received: from colin2.muc.de ([193.149.48.15]:15891 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261346AbTHSTci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:32:38 -0400
Date: 19 Aug 2003 21:32:35 +0200
Date: Tue, 19 Aug 2003 21:32:35 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Daniel Gryniewicz <dang@fprintf.net>
Cc: Andi Kleen <ak@muc.de>, Lars Marowsky-Bree <lmb@suse.de>, davem@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-ID: <20030819193235.GG92576@colin2.muc.de>
References: <mdtk.Zy.1@gated-at.bofh.it> <mgUv.3Wb.39@gated-at.bofh.it> <mgUv.3Wb.37@gated-at.bofh.it> <miMw.5yo.31@gated-at.bofh.it> <m365ktxz3k.fsf@averell.firstfloor.org> <1061320620.3744.16.camel@athena.fprintf.net> <20030819192125.GD92576@colin2.muc.de> <1061321268.3744.20.camel@athena.fprintf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061321268.3744.20.camel@athena.fprintf.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 03:27:48PM -0400, Daniel Gryniewicz wrote:
> On Tue, 2003-08-19 at 15:21, Andi Kleen wrote:
> > On Tue, Aug 19, 2003 at 03:17:00PM -0400, Daniel Gryniewicz wrote:
> > > On Tue, 2003-08-19 at 14:48, Andi Kleen wrote:
> > > > In my experience everybody who wants a different behaviour use some
> > > > more or less broken stateful L2/L3 switching hacks (like ipvs) or
> > > > having broken routing tables. While such hacks may be valid for some
> > > > uses they should not impact the default case.
> > > 
> > > So, changing your default route is a "hack"?  That's all that's
> > > necessary.  You can even do it with "route del/route add".
> > 
> > Necessary to do what exactly? 
> 
> Cause Linux to issue an arp request with a tell address not on the
> interface sending the arp.

I was merely talking about _answering_ ARP requests on all interfaces.

What happens on outgoing active ARPs is a different thing. Reasonable
choices would be either the prefered source address of the route or
the local interface's address. I must admit I don't have a strong
opinion on what the better behaviour of those is, but neither of them would
seem particularly wrong to me.

-Andi

