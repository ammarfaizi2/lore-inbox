Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbTHST2T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbTHST17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:27:59 -0400
Received: from relay.pair.com ([209.68.1.20]:60420 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S261243AbTHST1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:27:51 -0400
X-pair-Authenticated: 68.40.145.213
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
From: Daniel Gryniewicz <dang@fprintf.net>
To: Andi Kleen <ak@colin2.muc.de>
Cc: Andi Kleen <ak@muc.de>, Lars Marowsky-Bree <lmb@suse.de>, davem@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030819192125.GD92576@colin2.muc.de>
References: <mdtk.Zy.1@gated-at.bofh.it> <mgUv.3Wb.39@gated-at.bofh.it>
	 <mgUv.3Wb.37@gated-at.bofh.it> <miMw.5yo.31@gated-at.bofh.it>
	 <m365ktxz3k.fsf@averell.firstfloor.org>
	 <1061320620.3744.16.camel@athena.fprintf.net>
	 <20030819192125.GD92576@colin2.muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061321268.3744.20.camel@athena.fprintf.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 19 Aug 2003 15:27:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-19 at 15:21, Andi Kleen wrote:
> On Tue, Aug 19, 2003 at 03:17:00PM -0400, Daniel Gryniewicz wrote:
> > On Tue, 2003-08-19 at 14:48, Andi Kleen wrote:
> > > In my experience everybody who wants a different behaviour use some
> > > more or less broken stateful L2/L3 switching hacks (like ipvs) or
> > > having broken routing tables. While such hacks may be valid for some
> > > uses they should not impact the default case.
> > 
> > So, changing your default route is a "hack"?  That's all that's
> > necessary.  You can even do it with "route del/route add".
> 
> Necessary to do what exactly? 

Cause Linux to issue an arp request with a tell address not on the
interface sending the arp.
-- 
Daniel Gryniewicz <dang@fprintf.net>
