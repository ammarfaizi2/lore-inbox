Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbUJYOJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbUJYOJO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 10:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbUJYOJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 10:09:14 -0400
Received: from aun.it.uu.se ([130.238.12.36]:16256 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261813AbUJYOJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:09:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16765.2298.953135.524930@alkaid.it.uu.se>
Date: Mon, 25 Oct 2004 16:08:58 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "mobil@wodkahexe.de" <mobil@wodkahexe.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4 No local APIC present or hardware disabled
In-Reply-To: <Pine.LNX.4.58L.0410241615350.14448@blysk.ds.pg.gda.pl>
References: <20041012195448.2eaabcea.mobil@wodkahexe.de>
	<Pine.LNX.4.58L.0410132311190.17462@blysk.ds.pg.gda.pl>
	<16750.23132.41441.649851@alkaid.it.uu.se>
	<Pine.LNX.4.58L.0410142225160.25607@blysk.ds.pg.gda.pl>
	<16751.54873.668167.981073@alkaid.it.uu.se>
	<Pine.LNX.4.58L.0410241615350.14448@blysk.ds.pg.gda.pl>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki writes:
 > > I agree with Alan that accusing the BIOS of being buggy is unwarranted.
 > 
 >  I disagree.  If the firmware performs any actions on hardware without
 > asking the OS for permission, it *must* be prepared for it to be in any
 > possible state and handle it correctly, including any transitional states
 > (as it does respect spinlocks).  Otherwise it's buggy.

But in this case the BIOS explicitly disabled the local APIC. It may
have a legitimate reason for doing so (e.g. old #SMM code), so if the
Linux kernel overrides that disablement and things break, it really is
the kernel's fault not the BIOS'.

 > patch-2.6.9-lapic-7

I'm Ok with this patch.

/Mikael
