Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbVLSDaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbVLSDaN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 22:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbVLSDaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 22:30:13 -0500
Received: from gate.crashing.org ([63.228.1.57]:36320 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751279AbVLSDaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 22:30:12 -0500
Subject: Re: USB rejecting sleep
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0512182206520.2301-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0512182206520.2301-100000@netrider.rowland.org>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 14:24:37 +1100
Message-Id: <1134962678.6162.4.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-18 at 22:11 -0500, Alan Stern wrote:

> I disagree with the idea of disconnecting the device.  The right thing to 
> do is what David wanted all along: unbind the driver.  This would require 
> only a small change to the driver core.
> 
> It's too late for me to work on this now, but maybe tomorrow I'll have to 
> a chance to write something.

Why not also disconnect the device ? That will guarantee that when
coming back from sleep, the driver will re-discover a fresh new device
that has properly been reset no ? Instead of a device potentially
crashed because it didn't handle the suspend/resume transition
properly...

Ben.


