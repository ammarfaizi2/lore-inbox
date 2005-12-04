Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbVLDIIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbVLDIIE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 03:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVLDIIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 03:08:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:62408 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750870AbVLDIIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 03:08:02 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Greg KH <greg@kroah.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051203225105.GO31395@stusta.de>
References: <20051203135608.GJ31395@stusta.de>
	 <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com>
	 <20051203201945.GA4182@kroah.com>  <20051203225105.GO31395@stusta.de>
Content-Type: text/plain
Date: Sun, 04 Dec 2005 09:07:56 +0100
Message-Id: <1133683677.5188.17.camel@laptopd505.fenrus.org>
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


> What's wrong with offering an unified branch with few regressions for 
> both users and distributions? It's not that every distribution will use 
> it, but as soon as one or two distributions are using it the amount of 
> extra work for maintaining the branch should become pretty low.

the problem is simple: distributions will NOT use it. They can't, they
need the newer HW support and the new features. The only difference is
that you basically added just another distro branch. If you knew how
many people it takes a distro to run such an old tree you'd be scared.
(you need to include the QA people as well in this)

And distros hardly add hw support (the only hw support the enterprise
distros add is contained to like 5 or 10 drivers of "enterprise" stuff,
well testable and often validated by the vendor of the hw; and even then
there are regressions regularly)... for your branch you target a
different audience that does want a lot broader new HW support.

And then there's the bugfixes.. those tend to have regressions too,
especially if you move them to a different context than they originally
came from.

I'm not saying that you couldn't or shouldn't do this, I'm just saying
that I think it'll be a LOT more work than you think, and that the gain
is relatively minor. Especially since the main branch needs to sort the
compatibility item ANYWAY.


