Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbTDIF3g (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 01:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTDIF3f (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 01:29:35 -0400
Received: from dsl2.external.hp.com ([192.25.206.7]:26128 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id S262749AbTDIF3e (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 01:29:34 -0400
Date: Tue, 8 Apr 2003 23:41:13 -0600
To: Matthew Wilcox <willy@debian.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-kernel@vger.kernel.org,
       grundler@parisc-linux.org
Subject: Re: [PATCH] [3/3] PCI segment support
Message-ID: <20030409054113.GA21306@dsl2.external.hp.com>
References: <20030407234411.GT23430@parcelfarce.linux.theplanet.co.uk> <20030408203824.A27019@jurassic.park.msu.ru> <20030408165026.GA23430@parcelfarce.linux.theplanet.co.uk> <20030408212119.A783@jurassic.park.msu.ru> <20030408173109.GD23430@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030408173109.GD23430@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
From: grundler@dsl2.external.hp.com (Grant Grundler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 06:31:09PM +0100, Matthew Wilcox wrote:
> On Tue, Apr 08, 2003 at 09:21:19PM +0400, Ivan Kokshaysky wrote:
...
> > I believe each PCI controller on these ia64/parisc boxes has its
> > own config space, and can support up to 256 bridged PCI buses, right?

yes - at least "HP Designed" chipsets do.

> > Whether or not these PCI controllers share the same IO or MEM space is
> > irrelevant (because it's entirely implementation specific).
> 
> I think hardware _could_ work like that, but it's never set up to work
> like that in practice.

I interpret "practice" as equivalent to "implementation" in this context.

I hedge by saying "HP designed" because HP tried to sell Intel itanic
boxes until current mckinley boxes became available. And SGI, IBM,
and other vendors are designing their own "high end" ia64 chipsets.
(eg NEC Azusa - 16 CPU itanic).

parisc firmware (both Legacy and PAT PDC) and current IA64 firmware number
the PCI busses.  I didn't want the parisc-linux implementation to
reprogram PCI Bus numbers because:
o lack of PCI Segment support (which I'm glad to see willy is fixing)
o the "view" of devices from both firmware and linux should match.

card-mode dino (PCI controller on GSC HBA) is the only exception where
firmware has no clue about the PCI controller.

hth,
grant
