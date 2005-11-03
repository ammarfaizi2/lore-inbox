Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030392AbVKCRqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbVKCRqQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 12:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbVKCRqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 12:46:16 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:1546 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id S1030392AbVKCRqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 12:46:15 -0500
Date: Thu, 3 Nov 2005 17:46:20 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: gregkh@suse.de, stern@rowland.harvard.edu, linux-kernel@vger.kernel.org
Subject: Re: post-2.6.14 USB change breaks sparc64 boot
In-Reply-To: <20051103.093328.74747521.davem@davemloft.net>
Message-ID: <Pine.LNX.4.55.0511031738390.24109@blysk.ds.pg.gda.pl>
References: <20051103.093328.74747521.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2005, David S. Miller wrote:

> Perhaps pci_fixup_final would be a more appropriate time to run this
> USB host controller fixup?  One downside to this is that such calls
> would not be invoked for hot-plugged USB host controller devices.

 This might actually want to be split to disable legacy stuff as soon as
possible to prevent a flood of interrupts, sending SMIs and what not else.  
That just requires poking at the PCI config space.  Whatever's the rest
could be done later.  I guess hot-plugged USB host controllers are not
configured for legacy support, so the early bits should not matter for
them.

  Maciej
