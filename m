Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVH2HtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVH2HtP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 03:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVH2HtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 03:49:15 -0400
Received: from fachschaft.cup.uni-muenchen.de ([141.84.250.61]:59567 "EHLO
	fachschaft.cup.uni-muenchen.de") by vger.kernel.org with ESMTP
	id S1751131AbVH2HtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 03:49:14 -0400
Date: Mon, 29 Aug 2005 09:53:57 +0200 (CEST)
From: Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Dominik Wezel <dio@qwasartech.com>, linux-kernel@vger.kernel.org
Subject: Re: USB EHCI Problem with Low Speed Devices on kernel 2.6.11+
In-Reply-To: <431245E2.5010308@superbug.demon.co.uk>
Message-ID: <Pine.LNX.4.58.0508290952550.27451@fachschaft.cup.uni-muenchen.de>
References: <43106DEF.3040206@qwasartech.com> <431245E2.5010308@superbug.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Aug 2005, James Courtier-Dutton wrote:

> Dominik Wezel wrote:
> > Problem
> > =======
> > When turning on the laptop and during POST and GrUB loading, all ports on
> > the hub are enabled.  During the USB initialization phase, when the hub is
> > detected, shortly all ports become disabled, then turn on again (uhci_hcd
> > detects the lo-speed ports).  Upon initialization of ehci_hcd however, the
> > ports are disconnected again (for good):
> > 
> 
> Use uhci_hcd or ehci_hcd, but never both at the same time.
> ehci_hcd will work with all lo-speed ports, so uhci_hcd is then no needed.

What? UHCI is stand alone. EHCI will work only with high speed devices
(that includes low and full speed on a high speed hub, but not directly 
connected devices)

	Regards
		Oliver

