Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbTHSTeI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbTHSTce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:32:34 -0400
Received: from pizda.ninka.net ([216.101.162.242]:52621 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261300AbTHSTby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:31:54 -0400
Date: Tue, 19 Aug 2003 12:24:51 -0700
From: "David S. Miller" <davem@redhat.com>
To: Daniel Gryniewicz <dang@fprintf.net>
Cc: ak@colin2.muc.de, ak@muc.de, lmb@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819122451.0b092b6b.davem@redhat.com>
In-Reply-To: <1061321268.3744.20.camel@athena.fprintf.net>
References: <mdtk.Zy.1@gated-at.bofh.it>
	<mgUv.3Wb.39@gated-at.bofh.it>
	<mgUv.3Wb.37@gated-at.bofh.it>
	<miMw.5yo.31@gated-at.bofh.it>
	<m365ktxz3k.fsf@averell.firstfloor.org>
	<1061320620.3744.16.camel@athena.fprintf.net>
	<20030819192125.GD92576@colin2.muc.de>
	<1061321268.3744.20.camel@athena.fprintf.net>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Aug 2003 15:27:48 -0400
Daniel Gryniewicz <dang@fprintf.net> wrote:

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

Nobody has shown this to be invalid.  In fact, it has been shown
clearly that systems not responding to such ARP requests are buggy.

The only thing a system implementor can claim this accomplishes
is "pseudo security", and it barely even provides that.
