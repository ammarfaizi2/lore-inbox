Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752060AbWISUct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbWISUct (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 16:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbWISUct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 16:32:49 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:28431 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1752060AbWISUcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 16:32:48 -0400
Date: Tue, 19 Sep 2006 16:32:47 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: Jiri Kosina <jikos@jikos.cz>, Andrew Morton <akpm@osdl.org>,
       <dbrownell@users.sourceforge.net>, <weissg@vienna.at>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [PATCH] USB: consolidate error values from
 EHCI, UHCI and OHCI _suspend()
In-Reply-To: <200609190913.12563.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0609191630470.4631-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006, David Brownell wrote:

> Eventually we want hcd->state to vanish, but until it does it sure seems
> like a problem if usbcore can't rely on all HCDs to treat it the same.

uhci-hcd sets hcd->state wherever needed by usbcore, just as the other 
HCDs do.  (At least that was my intention -- if I missed setting it 
somewhere then the driver should be fixed.)

But uhci-hcd never reads hcd->state or tests its value.  I think that's 
what Jiri meant.

Alan Stern

