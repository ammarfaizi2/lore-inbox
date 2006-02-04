Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946165AbWBDLPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946165AbWBDLPg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 06:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946167AbWBDLPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 06:15:36 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:39183 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1946165AbWBDLPf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 06:15:35 -0500
Date: Sat, 4 Feb 2006 11:15:21 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: Bad interaction between uhci_hcd and de2104x
Message-ID: <20060204111521.GB18806@deprecation.cyrius.com>
References: <20060204005014.GA13351@deprecation.cyrius.com> <Pine.LNX.4.44L0.0602032227200.10200-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0602032227200.10200-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Stern <stern@rowland.harvard.edu> [2006-02-03 22:30]:
> > When I unload de2104x and uhci_hcd and load only de2104x again
> > then Ethernet works.  Similarly, when I completely blacklist the
> > uhci_hcd module the de2104x driver works without any problems.
> 
> And presumably, if you blacklist the de2104x driver then your USB
> controller works without any problems.
...
> For some reason, the de2104x driver isn't listed as a handler for
> IRQ 10.  That's probably the cause of the problem.  Did you have any
> full- or low-speed USB devices plugged in at the time this occurred?
> If you didn't then the UHCI hardware would not have generated any
> interrupt requests.

No, I don't think I ever used USB on this machine.  I did some more
tests based on what you said and have the following data points:
 - Having a USB device (USB stick) plugged in when booting doesn't
   make a difference.
 - When I load the de2104x driver _before_ uhci_hcd, both USB and
   Ethernet work fine.
 - Both modules load fine.  USB also works.  The problem only occurs
   when I actually try to use the Ethernet device (i.e. run DHCP).
   Then I get that traceback, and USB also stops working.

-- 
Martin Michlmayr
http://www.cyrius.com/
