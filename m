Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265940AbUBPWSv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 17:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbUBPWSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 17:18:50 -0500
Received: from gate.crashing.org ([63.228.1.57]:32161 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265940AbUBPWSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:18:45 -0500
Subject: Re: 2.6.3-rc3 radeonfb: Problems with new (and old) driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Eger <eger@theboonies.us>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402161410430.30742@home.osdl.org>
References: <Pine.LNX.4.50L0.0402160411260.2959-100000@rosencrantz.theboonies.us>
	 <1076904084.12300.189.camel@gaston>
	 <Pine.LNX.4.58.0402160947080.30742@home.osdl.org>
	 <1076968236.3648.42.camel@gaston>
	 <Pine.LNX.4.58.0402161410430.30742@home.osdl.org>
Content-Type: text/plain
Message-Id: <1076969892.3649.66.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 17 Feb 2004 09:18:12 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-17 at 09:13, Linus Torvalds wrote:
> On Tue, 17 Feb 2004, Benjamin Herrenschmidt wrote:
> > 
> > Do we want to pay the cost (in time) of a full mode set + engine reset
> > on each unblank ? I could limit myself to restoring the accel engine,
> > that faster, but with X also not always restoring the console mode
> > properly, I'd have preferred re-setting the whole mode... 
> 
> Well, on blanking, we do actually already pass in a parameter that says
> "this is not a full blank, it's just a move to graphics mode". It would
> make 100% sense to add the _same_ parameter to the unblank code.
> 
> That would just make the code more logical, and it should fix your 
> concerns, no?

Yes, I was looking into this at the moment. Who else but fbcon and
vgacon will need fixing ? I suppose all the xxxxcon in
drivers/video/console, do you "see" any other ?

Ben.


