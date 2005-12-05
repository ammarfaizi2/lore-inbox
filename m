Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbVLEVGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbVLEVGJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 16:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbVLEVGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 16:06:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21416 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751470AbVLEVGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 16:06:08 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87y82z5kep.fsf@mid.deneb.enyo.de>
References: <20051203135608.GJ31395@stusta.de>
	 <1133620264.2171.14.camel@localhost.localdomain>
	 <20051203193538.GM31395@stusta.de> <1133639835.16836.24.camel@mindpipe>
	 <20051203225815.GH25722@merlin.emma.line.org>
	 <87y82z5kep.fsf@mid.deneb.enyo.de>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 22:06:04 +0100
Message-Id: <1133816764.9356.72.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-05 at 22:00 +0100, Florian Weimer wrote:
> * Matthias Andree:
> 
> > The point that just escaped you as the motivation for this thread was
> > the availability of security (or other critical) fixes for older
> > kernels. It would all be fine if, say, the fix for CVE-2004-2492 were
> > available for those who find 2.6.8 works for them (the fix went into
> > 2.6.14 BTW), and the concern is the development model isn't fit to
> > accomodate needs like this.
> 
> Well, if there's a CVE name, the proper patch isn't *that* far away
> (someone has already done a bit of work to isolate the fix).  The real
> issue seems to be how to make sure that CVE names are assigned during
> the kernel development process (and not just as an afterthought by the
> security folks).

security@kernel.org works that way already in a way. Of course it'd be
nice to add a cve name while coding the security hole into the kernel,
but nobody is that clearvoyant ;) The hardest part is actually knowing
which versions are affected, especially when the code no longer quite is
the same, the locking rules got cleaned up in later versions (which
means the older kernel was a mess, so you're always looking at more
messy code than the "new" kernel). For some stuff this is easy. For
other stuff it for sure isn't, especially if you want to keep api/abi
compatibility, or at least low impact. Some security fixes just are
invasive. Those are rare, maybe 2 or 3 times a year or so. But they do
exist... unfortunate as it is. The irony is that doing a "hacky" less
invasive risk actually may introduce more risk to stability than doing
the full invasive fix. Nasty trade-offs there....
 

