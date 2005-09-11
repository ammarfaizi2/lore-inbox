Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbVIKTDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVIKTDV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 15:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbVIKTDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 15:03:21 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:8076
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750705AbVIKTDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 15:03:21 -0400
Date: Sun, 11 Sep 2005 12:03:16 -0700 (PDT)
Message-Id: <20050911.120316.97042144.davem@davemloft.net>
To: torvalds@osdl.org
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: sungem driver patch testing..
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0509111151520.3242@g5.osdl.org>
References: <Pine.LNX.4.58.0509110940220.4912@g5.osdl.org>
	<20050911.112408.19208990.davem@davemloft.net>
	<Pine.LNX.4.58.0509111151520.3242@g5.osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Sun, 11 Sep 2005 11:52:59 -0700 (PDT)

> On Sun, 11 Sep 2005, David S. Miller wrote:
> > 
> > The Apple firmware actually is the same kind of FORTH firmware the
> > SUN cards use too.  Apple bought the FORTH firmware technology from
> > Sun so they could use it in their machines.
> 
> I think what Christoph was thinking of is when you insert a _regular_ PCI 
> card, ie no apple firmware stuff. Now, what OF will do about such a thing, 
> I don't know, but I assume it's possible.

Even the PCI SunGEM cards have the FORTH firmware stuff in their PCI
ROMs.  The FORTH firmware on the Sun or MAC machine, at boot time,
looks for the FORTH signature in the PCI ROMs of all the devices in
the machine, and executes whatever matches it finds.  The SunGEM PCI
card variants have this firmware, just like the motherboard variants
do.

I don't think a SunGEM chipset card or motherboard implementation ever
existed without the necessary FORTH firmware in the PCI ROM.  And,
certainly, no SunGEM was ever made with accompanying x86 style
firmware in the PCI ROM.

Hmmm... actually, I think I have a dual-function PCI card somewhere
that has a SunGEM and a Qlogic scsi controller.  If I can dig it up
I'll stick it into one of my x86 boxes and play with your patch :-)
