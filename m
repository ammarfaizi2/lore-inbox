Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbULJV1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbULJV1b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 16:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbULJVZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 16:25:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:63142 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261787AbULJVZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 16:25:19 -0500
Subject: Re: [PATCH] Don't touch BARs of host bridges
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: "Maciej W. Rozycki" <macro@mips.com>, Greg KH <greg@kroah.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Chris Dearman <chris@mips.com>
In-Reply-To: <Pine.LNX.4.58L.0412100448490.30913@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.61.0412092349560.6535@perivale.mips.com>
	 <1102653999.22763.22.camel@gaston>
	 <Pine.LNX.4.58L.0412100448490.30913@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Date: Sat, 11 Dec 2004 08:25:04 +1100
Message-Id: <1102713904.5237.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-10 at 13:11 +0000, Maciej W. Rozycki wrote:

>  Well, some of these bridges may be used for peripheral devices (option
> cards) built around a CPU, typically after reprogramming the class code to
> something corresponding to their actual function.  Why should the address
> decoder circuitry suddenly change in this case?

To stay in the PCI spec ? :) They would need at least a way to "lock"
the BARs.

>  Also even in the "host mode" another device may wish to examine what
> resources have been reserved by the host bridge (unlikely, I admit, but 
> in principle why not?).

Very unlikely.

> > was well :) So I agree, that would be useful to skip them. I'm not sure
> > about PCI_CLASS_NOT_DEFINED tho ...
> 
>  These are pre-2.0 PCI devices -- from before the detailed classification
> was agreed upon.  AFAIK, just a couple of them exist -- I can name:  
> Intel's 82424 and 82425 families of i486 host bridges, their 82375 family
> of PCI-EISA bridges and their 82378/9 family of PCI-ISA bridges (also used
> in a few DEC Alpha systems).  There are probably a handful of other chips,
> all of them about ten years old.  Our i386 and ppc resource managers skip
> over them as well and I suppose this is a safe default.  If any of them
> needs BAR setup (none of these Intel ones), it can be added explicitly by
> means of its vendor:device ID.

Ok.

Ben.


