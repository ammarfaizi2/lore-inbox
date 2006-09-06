Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWIFAsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWIFAsI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 20:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbWIFAsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 20:48:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:4802 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751535AbWIFAsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 20:48:04 -0400
Subject: Re: Linux 2.6.18-rc6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Olaf Hering <olaf@aepfle.de>, Linus Torvalds <torvalds@osdl.org>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1157498567.3463.91.camel@mulgrave.il.steeleye.com>
References: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org>
	 <20060905122656.GA3650@aepfle.de>
	 <1157490066.3463.73.camel@mulgrave.il.steeleye.com>
	 <1157494837.22705.151.camel@localhost.localdomain>
	 <1157498567.3463.91.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 10:47:33 +1000
Message-Id: <1157503653.22705.156.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 18:22 -0500, James Bottomley wrote:
> On Wed, 2006-09-06 at 08:20 +1000, Benjamin Herrenschmidt wrote:
> > Yes, it's a PCI error.
> 
> Thanks, and the cat of /proc/scsi_host/host<n>/signalling?
> 
> My suspicion is the register doesn't actually exist on this card so it
> doesn't actually respond on the bus.  However, on my equivalent
> everything works; largely I think because the only PC's I have don't
> know how to signal a PCI error.

Olaf will tell us (I don't have the hardware) but it's indeed a typical
thing .... From my experience, Adaptec tend to very easily throw PCI
aborts at you if it doesn't like something in a register access (which
isn't necessarily a bad thing btw, other vendors are more lenient tho),
and Macs are well known to Machine Check the box when getting a PCI
error while most x86 boxes silently ignore them...

Ben.


