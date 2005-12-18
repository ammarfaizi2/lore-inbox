Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbVLRFeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbVLRFeA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 00:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965082AbVLRFeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 00:34:00 -0500
Received: from lame.durables.org ([64.81.244.120]:32641 "EHLO
	calliope.durables.org") by vger.kernel.org with ESMTP
	id S965081AbVLRFeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 00:34:00 -0500
Subject: Re: [PATCH 03/13]  [RFC] ipath copy routines
From: Robert Walsh <rjwalsh@pathscale.com>
To: Andrew Morton <akpm@osdl.org>
Cc: rolandd@cisco.com, linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051217191932.af2b422c.akpm@osdl.org>
References: <200512161548.HbgfRzF2TysjsR2G@cisco.com>
	 <200512161548.lRw6KI369ooIXS9o@cisco.com>
	 <20051217123833.1aa430ab.akpm@osdl.org>
	 <1134859243.20575.84.camel@phosphene.durables.org>
	 <20051217191932.af2b422c.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 21:33:51 -0800
Message-Id: <1134884031.20575.126.camel@phosphene.durables.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Any chance we could get these moved into the x86_64 arch directory,
> > then?
> 
> That would make sense.  Give it a non-ipath-related name and require that
> all architectures which wish to run this driver must implement that
> (documented) function.
> 
> And, in Kconfig, make sure that architectures which don't implement that
> library function do not attempt to build this driver.  To avoid breaking
> `make allmodconfig'.

Sounds good.  I'll get something together next week.

> >  We have to do double-word copies, or our chip gets unhappy.
> 
> In what form is this chip available?  As a standard PCI/PCIX card which
> people will want to plug into power4/ia64/x86 machines?  Or is it in some
> way exclusively tied to x86_64?

It's a HyperTransport card, not PCI/PCIe/PCIX.  It plugs into the HTX
slot on a suitably-equipped motherboard.  On some machines, it's
available on the motherboard itself (e.g. the Linux Networx LS/X.)

Regards,
 Robert.

-- 
Robert Walsh                                 Email: rjwalsh@pathscale.com
PathScale, Inc.                              Phone: +1 650 934 8117
2071 Stierlin Court, Suite 200                 Fax: +1 650 428 1969
Mountain View, CA 94043.


