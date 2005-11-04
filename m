Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbVKDXUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbVKDXUR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbVKDXUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:20:17 -0500
Received: from gate.crashing.org ([63.228.1.57]:18130 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750953AbVKDXUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:20:15 -0500
Subject: Re: Parallel ATA with libata status with the patches I'm working on
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       bzolnier@gmail.com
In-Reply-To: <20051104231048.GD12026@flint.arm.linux.org.uk>
References: <1131029686.18848.48.camel@localhost.localdomain>
	 <20051103144830.GF28038@flint.arm.linux.org.uk>
	 <58cb370e0511030702hb06a5f3qc2dfe465ee1d784c@mail.gmail.com>
	 <m3oe51zc2e.fsf@defiant.localdomain>
	 <58cb370e0511031329h7532259y6d3624fbf2d93f88@mail.gmail.com>
	 <1131058464.18848.94.camel@localhost.localdomain>
	 <20051104013054.GF3469@ime.usp.br>
	 <1131111667.26925.31.camel@localhost.localdomain>
	 <20051104231048.GD12026@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Sat, 05 Nov 2005 10:19:03 +1100
Message-Id: <1131146343.29195.34.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-04 at 23:10 +0000, Russell King wrote:
> On Fri, Nov 04, 2005 at 01:41:06PM +0000, Alan Cox wrote:
> > While writing the new sl82c05 driver I noticed a real nasty lurking in
> > the old code. According to the errata docs you have to reset the DMA
> > engine every transfer to work around chip errata. It also says that this
> > resets any other ATA transfer in progress.
> > 
> > If both channels are in use there is no locking between the channels to
> > stop a reset on one channel as DMA begins making a mess of the other
> > channel. Looks like serialize should be set on the driver ?
> 
> Possibly, though benh needs to comment.  (I think benh has the only
> hardware which has the possibility of both channels - the NetWinder
> only has one channel with one disk.)

I don't have this hw anymore, it was a design I worked on for my
previous employer, years ago, I don't have access to it anymore and the
company doesn't exist anymore.

Ben.


