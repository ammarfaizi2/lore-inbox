Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268776AbUJKKyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268776AbUJKKyy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 06:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268775AbUJKKyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 06:54:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:29629 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268776AbUJKKyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 06:54:51 -0400
Subject: Re: Totally broken PCI PM calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, David Brownell <david-b@pacbell.net>
In-Reply-To: <20041011101824.GC26677@atrey.karlin.mff.cuni.cz>
References: <1097455528.25489.9.camel@gaston>
	 <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org>
	 <16746.299.189583.506818@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0410102115410.3897@ppc970.osdl.org>
	 <20041011101824.GC26677@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Message-Id: <1097492066.3241.1.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 11 Oct 2004 20:54:26 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 20:18, Pavel Machek wrote:
> Hi!
> 
> > > Maybe the real problem is that we are trying to use the device suspend
> > > functions for suspend-to-disk, when we don't really want to change the
> > > device's power state at all.
> > 
> > An acceptable solution is certainly to instead of passing down "go to D3",
> > just not do anything at all. HOWEVER, I doubt that is actually all that 
> > good a solution either: devices quite possibly do want to save state 
> > and/or set wake-on-events. 
> 
> And DMA needs to be stopped, or it is "bye bye data" situation.

This is true for pretty much any PM state

> Does sparse now have typechecking on enums? Solution that was in -mm
> was basically "put enums there so drivers can't be confused" + "signal
> global state out-of-band in global variable". It was not too nice, but
> it certainly was working.
> 								Pavel
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

