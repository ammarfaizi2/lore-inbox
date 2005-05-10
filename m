Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVEJNkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVEJNkX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 09:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVEJNkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 09:40:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27029 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261650AbVEJNkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 09:40:06 -0400
Subject: Re: [suse-amd64] False "lost ticks" on dual-Opteron system (=>
	timer twice as fast)
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Bernd Paysan <bernd.paysan@gmx.de>, suse-amd64@suse.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050510132153.GJ25612@wotan.suse.de>
References: <200505081445.26663.bernd.paysan@gmx.de>
	 <200505101355.00341.bernd.paysan@gmx.de>
	 <20050510130709.GI25612@wotan.suse.de>
	 <200505101515.56177.bernd.paysan@gmx.de>
	 <20050510132153.GJ25612@wotan.suse.de>
Content-Type: text/plain
Date: Tue, 10 May 2005 15:39:49 +0200
Message-Id: <1115732389.6008.28.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
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

On Tue, 2005-05-10 at 15:21 +0200, Andi Kleen wrote:
> On Tue, May 10, 2005 at 03:15:44PM +0200, Bernd Paysan wrote:
> > On Tuesday 10 May 2005 15:07, Andi Kleen wrote:
> > > That could be irqbalance doing its thing. Does it go away when
> > > you stop it?
> > 
> > Yes, it seems to go away.
> 
> Ok, it is fine then. A bit unexpected, but fine.

irqbalance nowadays rotates the timer interrupt every 10 seconds after
some people complained that having it always on the same cpu penalized
their HPC apps unbalanced. (they glued those tasks to each cpu). It's
not a big deal (the irq rate isn't that high) and it does make things
slightly more fair in the HPC case.


