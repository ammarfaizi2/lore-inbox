Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbTH1Isl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 04:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263856AbTH1IsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 04:48:15 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:48772 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263610AbTH1IkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 04:40:24 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0308271628060.4140-100000@cherise>
References: <Pine.LNX.4.44.0308271628060.4140-100000@cherise>
Message-Id: <1062059940.1293.120.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 28 Aug 2003 10:39:00 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: PCI PM & compatibility
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-28 at 01:29, Patrick Mochel wrote:

> I don't understand. We suspend the children before we suspend the device, 
> so as long as all the children go done, so will the parent device.

Forget it... It had crap in mind. Anyway, my point was actually the
opposite than what I wrote :( I was really to make sure that if a
device is "held" up by pm_users beeing non-NULL, it's _parents_
(and not it's children, sorry about the confusion), are also held
non-suspended... I think I'll sleep a bit and then just go look at
the code ;)

Ben.

