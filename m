Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVDDXpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVDDXpR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 19:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVDDXpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 19:45:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:13498 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261505AbVDDXo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 19:44:29 -0400
Subject: Re: iomapping a big endian area
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       "David S. Miller" <davem@davemloft.net>, matthew@wil.cx,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <42514D9C.2070003@osdl.org>
References: <1112475134.5786.29.camel@mulgrave>
	 <20050403013757.GB24234@parcelfarce.linux.theplanet.co.uk>
	 <20050402183805.20a0cf49.davem@davemloft.net>
	 <20050403031000.GC24234@parcelfarce.linux.theplanet.co.uk>
	 <1112499639.5786.34.camel@mulgrave>
	 <20050402200858.37347bec.davem@davemloft.net>
	 <1112502477.5786.38.camel@mulgrave>  <1112601039.26086.49.camel@gaston>
	 <1112623143.5813.5.camel@mulgrave>  <42514D9C.2070003@osdl.org>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 09:41:03 +1000
Message-Id: <1112658063.26085.106.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Well ... it's like this. Native means "pass through without swapping"
> > and has an easy implementation on both BE and LE platforms.  Logically
> > io{read,write}{16,32}be would have to do byte swaps on LE platforms.
> > Being lazy, I'm opposed to doing the work if there's no actual use for
> > it, so can you provide an example of a BE bus (or device) used on a LE
> > platform that would actually benefit from this abstraction?
> 
> I would probably spell "native" as "noswap".
> "native" just doesn't convey enough specific meaning...

But that implies that the driver has to know that the bus and the device
and the CPU are on the same byte endian etc.... that is rather specific,
and if they all know, then they can also just use the correct "be" or
"le" ... I really see no point in "native" abstraction.

Ben.


