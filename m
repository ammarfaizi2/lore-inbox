Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVCAQbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVCAQbH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 11:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVCAQbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 11:31:07 -0500
Received: from styx.suse.cz ([82.119.242.94]:12164 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261960AbVCAQbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 11:31:06 -0500
Date: Tue, 1 Mar 2005 17:33:22 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       vojtech@suse.de
Subject: Re: Breakage from patch: Only root should be able to set the N_MOUSE line discipline.
Message-ID: <20050301163322.GA11034@ucw.cz>
References: <200502030209.j1329xTG013818@hera.kernel.org> <1109416402.2584.5.camel@localhost.localdomain> <20050301114718.GA5375@ucw.cz> <Pine.LNX.4.58.0503010814580.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503010814580.25732@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 08:17:47AM -0800, Linus Torvalds wrote:

> On Tue, 1 Mar 2005, Vojtech Pavlik wrote:
> >  
> > A nonprivileged user could inject mouse movement and/or keystrokes
> > (using the sunkbd driver) into the input subsystem, taking over the
> > console/X, where another user is logged in.
> > 
> > Simply using a slightly modified inputattach on a PTY will do the trick.
> 
> Might an alternative be to just make writes to N_MOUSE require privileges?
> 
> Ie "reading is ok, and changing to N_MOUSE is ok, but tryign to write a 
> mouse packet is not"? The check should be easy enough to add to the 
> ldisc.write thing?
 
No, since you wouldn't write anything to the device, the writes would
happen on the other end of the pty.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
