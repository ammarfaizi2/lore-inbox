Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263428AbUKZWNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263428AbUKZWNc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 17:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbUKZWMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 17:12:39 -0500
Received: from gate.crashing.org ([63.228.1.57]:6874 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263388AbUKZWIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 17:08:21 -0500
Subject: Re: [linux-usb-devel] [PATCH] Ohci-hcd: fix endless loop
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Colin Leroy <colin@colino.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <200411260838.10508.david-b@pacbell.net>
References: <20041125191726.5ca95299@jack.colino.net>
	 <200411260838.10508.david-b@pacbell.net>
Content-Type: text/plain
Date: Sat, 27 Nov 2004 09:07:49 +1100
Message-Id: <1101506869.28109.26.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If you got the "IRQ INTR_SF lossage" diagnostic, there's clearly
> some problem with IRQ handling after the resume ... is the iBook
> firmware (or hardware) doing wierd stuff so that the normal PCI
> IRQ calls stopped working?

The iBook hardware isn't doing anything special, the controller is just
coming back out of the blue. If it's the NEC one, it's just a normal NEC
EHCI+OHCI coming out of D3cold, if it's the KeyLargo Apple one, it comes
from some special state which  is similar to D2.

Ben.


