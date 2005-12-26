Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbVLZEMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbVLZEMi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 23:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbVLZEMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 23:12:38 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:11184 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750992AbVLZEMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 23:12:37 -0500
Subject: Re: [linux-usb-devel] CONFIG_USB_BANDWIDTH broken
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.44L0.0512252253350.15623-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0512252253350.15623-100000@netrider.rowland.org>
Content-Type: text/plain
Date: Sun, 25 Dec 2005 23:17:17 -0500
Message-Id: <1135570637.8293.26.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-25 at 22:58 -0500, Alan Stern wrote:
> On Sun, 25 Dec 2005, Lee Revell wrote:
> 
> > CONFIG_USB_BANDWIDTH breaks USB audio.  This has been a problem for at
> > least 6 months.
> > 
> > Typical bug report:
> > 
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1642
> > 
> > (search bug tracker for CONFIG_USB_BANDWIDTH to see many more)
> > 
> > Is anyone working on fixing this?
> 
> The bug reports don't mention which USB host controller driver was being 
> used.
> 
> 	With ohci-hcd, bandwidth enforcement works okay.
> 
> 	With ehci-hcd, there are problems involved with scheduling
> 	periodic transfers to a full-speed device connected through
> 	a high-speed hub.  These problems are slowly being fixed.
> 
> 	With uhci-hcd, bandwidth enforcement has never worked.  New
> 	changes to the driver (accepted just a few days ago) will
> 	permit this to be fixed eventually.  It might take a few months
> 	(plus the time required for the changes to be added to the
> 	official distribution kernel).

Thanks, I'll try to get this info from the users.

So the solution for now is to educate users not to use it (and
especially, distros not to enable it).

Lee

