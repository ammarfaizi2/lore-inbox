Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbTEMViI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTEMViI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:38:08 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:56845 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261998AbTEMVhU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:37:20 -0400
Date: Tue, 13 May 2003 23:48:30 +0200
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, Paul Fulghum <paulkf@microgate.com>,
       Andrew Morton <akpm@digeo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd@arndb.de>, johannes@erdfelt.com
Subject: Re: 2.5.69 Interrupt Latency
Message-ID: <20030513214830.GA685@hh.idb.hist.no>
References: <20030513181120.GA10790@kroah.com> <Pine.LNX.4.44L0.0305131719260.673-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0305131719260.673-100000@ida.rowland.org>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 05:35:47PM -0400, Alan Stern wrote:
> My take is that wakeup_hc() is getting called whenever some stray signal
> causes the device to generate an interrupt, and then a little while later
> the stall timer routine calls suspend_hc() since nothing is active.  The
> interrupts are probably indistinguishable from what you would get if a new
> device really had just been attached to the bus.
>
Could this also happen if the USB interrupt is shared?
The other device interrupts, and the kernel calls into
usb interrupt routine just in case USB has some data too?

Helge Hafting
