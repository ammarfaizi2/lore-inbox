Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVCCJSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVCCJSb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 04:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVCCJSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 04:18:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56756 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261709AbVCCJOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 04:14:31 -0500
Subject: Re: RFD: Kernel release numbering
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 10:14:22 +0100
Message-Id: <1109841262.6298.87.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Comments?

the problem is that this doesn't tackle some of the fundamentals...

yes you have a step in between for extra stabilisation. However during
that phase, the buildup of patch backlogs will keep going on, and the
next "unstable" release is all the more so, because of all the enormous
backlogs. Result the stabilisation takes longer. Which means the buildup
next time is even bigger. And that may well be a cycle you can't get out
of. Oh and most people will just start skipping the odd releases as
well. Making this even worse.

An alternative would be to instead of doing the alternating scheme, do
higher frequency releases but with less new features per release. (like
we had in early 2.6 days). Say 3 weeks of devel, 3 weeks of -rc and then
release. Do it time driven so that stuff that gets found to be broken
during -rc gets punted back (to -mm or so) for trying in a later
release. (even when it was added before -rc; if the bug is found before
-rc starts it has a chance for a fix, if it's during -rc it means "back
out for next release"). This sounds harsh but as long as the "next
chance" isn't that far in the future (three weeks at most before it is
back) it shouldn't be a big deal. 



