Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267497AbUHDXVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267497AbUHDXVV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 19:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267502AbUHDXVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 19:21:21 -0400
Received: from colin2.muc.de ([193.149.48.15]:49164 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S267497AbUHDXVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 19:21:17 -0400
Date: 5 Aug 2004 01:21:16 +0200
Date: Thu, 5 Aug 2004 01:21:16 +0200
From: Andi Kleen <ak@muc.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: block layer sg, bsg
Message-ID: <20040804232116.GA30152@muc.de>
References: <2ppN4-1wi-11@gated-at.bofh.it> <2pvps-5xO-33@gated-at.bofh.it> <2pvz2-5Lf-19@gated-at.bofh.it> <2pwbQ-68b-43@gated-at.bofh.it> <m33c32ke3f.fsf@averell.firstfloor.org> <20040804191850.GA19224@havoc.gtf.org> <20040804122254.3d52c2d4.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040804122254.3d52c2d4.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 12:22:54PM -0700, David S. Miller wrote:
> On Wed, 4 Aug 2004 15:18:50 -0400
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> > On Wed, Aug 04, 2004 at 07:28:04PM +0200, Andi Kleen wrote:
> > > So please never pass any structures with read/write/netlink.
> > 
> > Sorry...  This is pretty much a given IMO.
> 
> Yes, netlink would be a nop if we gave in to Andi's reccomendation
> :-)

Well, 32bit ipsec on x86-64/ia64 is a NOP because of that.

Alternatively for me it would be enough if you never use long long
in such data structures. That is what broke ipsec. And it's pretty
much unfixable because netlink is so adverse to emulation layers.

Longer term adding a presentation layer to netlink will be likely
a good idea. That's also needed for the cluster netlink stuff some
people are talking about.

-Andi
