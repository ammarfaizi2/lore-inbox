Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVFGWlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVFGWlt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 18:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbVFGWlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 18:41:49 -0400
Received: from fmr20.intel.com ([134.134.136.19]:63963 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262023AbVFGWld convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 18:41:33 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers - take 2
Date: Tue, 7 Jun 2005 15:40:48 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502408D8D13F@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers - take 2
Thread-Index: AcVrnoZ9Izc1KbcYTBa4St+p/3sh5gAEuxdQ
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Greg KH" <gregkh@suse.de>, "Jeff Garzik" <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, <roland@topspin.com>
Cc: <linux-pci@atrey.karlin.mff.cuni.cz>, <linux-kernel@vger.kernel.org>,
       <ak@suse.de>, "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 07 Jun 2005 22:40:49.0883 (UTC) FILETIME=[F41CAAB0:01C56BB1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 07, 2005 1:21 PM Greg KH wrote:
> However, now that I've messed around with the MSI-X logic in the IB
> driver, I'm thinking that this whole thing is just pointless, and I
> should just drop it and we should stick with the current way of
enabling
> MSI only if the driver wants it.  If you look at the logic in the
mthca
> driver you'll see what I mean.
>
>So, anyone else think this is a good idea?  Votes for me to just drop
it
>and go back to hacking on the driver core instead?

I vote "no change".

> Oh, and in looking at the drivers/pci/msi.c file, it could use some
> cleanups to make it smaller and a bit less complex.  I've also seen
some
> complaints that it is very arch specific (x86 based).  But as no other
> arches seem to want to support MSI, I don't really see any need to
split
> it up.  Any comments about this?

Agree.

Thanks,
Long

