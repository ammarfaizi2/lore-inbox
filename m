Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030450AbVKCTYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030450AbVKCTYi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 14:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbVKCTYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 14:24:38 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:42254 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S932472AbVKCTYh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 14:24:37 -0500
Date: Thu, 3 Nov 2005 19:24:44 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "David S. Miller" <davem@davemloft.net>, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: post-2.6.14 USB change breaks sparc64 boot
In-Reply-To: <Pine.LNX.4.44L0.0511031352480.5056-100000@iolanthe.rowland.org>
Message-ID: <Pine.LNX.4.55.0511031913500.24109@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.44L0.0511031352480.5056-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2005, Alan Stern wrote:

> >  This might actually want to be split to disable legacy stuff as soon as
> > possible to prevent a flood of interrupts, sending SMIs and what not else.  
> > That just requires poking at the PCI config space.  Whatever's the rest
> > could be done later.  I guess hot-plugged USB host controllers are not
> > configured for legacy support, so the early bits should not matter for
> > them.
> 
> See this email thread:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113081793516723&w=2

 Hmm, how does this relate to my suggestion?  Apart from me having to note
that I have a MIPS-based system with an UHCI -- so these HCs are not
completely limited to Intel-based systems.  Though, unsurprisingly, it
doesn't use any of the legacy crap.  SMI from the south bridge is routed
to somewhere IIRC; probably an ordinary interrupt (and happily ignored).

  Maciej
