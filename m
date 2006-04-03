Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751527AbWDCOgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbWDCOgZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 10:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbWDCOgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 10:36:25 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:40861 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751524AbWDCOgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 10:36:24 -0400
Date: Mon, 3 Apr 2006 10:36:23 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Joshua Kwan <joshk@triplehelix.org>
cc: linux-kernel@vger.kernel.org, <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Problems with USB setup with Linux 2.6.16
In-Reply-To: <44309821.1090600@triplehelix.org>
Message-ID: <Pine.LNX.4.44L0.0604031034360.5494-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Apr 2006, Joshua Kwan wrote:

> On 04/02/2006 07:09 PM, Alan Stern wrote:
> > If you were to continue looking farther down in the log, you would find
> > that ehci-hcd sees all those devices.  Those that can run at high speed
> > continue using the EHCI controller.  For those that can't, the switch is 
> > reset and they get reconnected to their UHCI controller.
> 
> That makes sense - that is indeed what happens when it DOES work (i.e.
> with 2.6.15), but the fact is that they don't come back in 2.6.16. I
> will try building ehci-hcd in and see what happens.

If the devices don't come back, it's an indication that some driver has 
hung.  A stack trace (Alt-SysRq-T) should help identify which driver is in 
trouble.

Alan Stern

