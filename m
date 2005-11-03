Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030432AbVKCSyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030432AbVKCSyN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 13:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030437AbVKCSyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 13:54:12 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:48772 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030432AbVKCSyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 13:54:11 -0500
Date: Thu, 3 Nov 2005 13:54:09 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
cc: "David S. Miller" <davem@davemloft.net>, <gregkh@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: post-2.6.14 USB change breaks sparc64 boot
In-Reply-To: <Pine.LNX.4.55.0511031738390.24109@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.44L0.0511031352480.5056-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2005, Maciej W. Rozycki wrote:

> On Thu, 3 Nov 2005, David S. Miller wrote:
> 
> > Perhaps pci_fixup_final would be a more appropriate time to run this
> > USB host controller fixup?  One downside to this is that such calls
> > would not be invoked for hot-plugged USB host controller devices.
> 
>  This might actually want to be split to disable legacy stuff as soon as
> possible to prevent a flood of interrupts, sending SMIs and what not else.  
> That just requires poking at the PCI config space.  Whatever's the rest
> could be done later.  I guess hot-plugged USB host controllers are not
> configured for legacy support, so the early bits should not matter for
> them.

See this email thread:

http://marc.theaimsgroup.com/?l=linux-kernel&m=113081793516723&w=2

Alan Stern

