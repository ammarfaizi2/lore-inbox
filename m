Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbVLZD6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbVLZD6q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 22:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbVLZD6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 22:58:46 -0500
Received: from mx1.rowland.org ([192.131.102.7]:55813 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1750985AbVLZD6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 22:58:45 -0500
Date: Sun, 25 Dec 2005 22:58:41 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Lee Revell <rlrevell@joe-job.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] CONFIG_USB_BANDWIDTH broken
In-Reply-To: <1135561680.8293.6.camel@mindpipe>
Message-ID: <Pine.LNX.4.44L0.0512252253350.15623-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Dec 2005, Lee Revell wrote:

> CONFIG_USB_BANDWIDTH breaks USB audio.  This has been a problem for at
> least 6 months.
> 
> Typical bug report:
> 
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1642
> 
> (search bug tracker for CONFIG_USB_BANDWIDTH to see many more)
> 
> Is anyone working on fixing this?

The bug reports don't mention which USB host controller driver was being 
used.

	With ohci-hcd, bandwidth enforcement works okay.

	With ehci-hcd, there are problems involved with scheduling
	periodic transfers to a full-speed device connected through
	a high-speed hub.  These problems are slowly being fixed.

	With uhci-hcd, bandwidth enforcement has never worked.  New
	changes to the driver (accepted just a few days ago) will
	permit this to be fixed eventually.  It might take a few months
	(plus the time required for the changes to be added to the
	official distribution kernel).

Alan Stern

