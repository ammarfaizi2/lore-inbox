Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbVJCLHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVJCLHv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 07:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVJCLHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 07:07:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51081 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932227AbVJCLHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 07:07:50 -0400
Subject: Re: [RFC][PATCH] SPI subsystem
From: Arjan van de Ven <arjan@infradead.org>
To: Mark Underwood <basicmark@yahoo.com>
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       dpervushin@ru.mvista.com
In-Reply-To: <20051003105748.213.qmail@web33014.mail.mud.yahoo.com>
References: <20051003105748.213.qmail@web33014.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Mon, 03 Oct 2005 13:07:36 +0200
Message-Id: <1128337656.17024.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-03 at 11:57 +0100, Mark Underwood wrote:

> > > > > Hmm, using local variables for messages, so DMA adapter drivers have
> > > > > to check if this is non-kmalloc'ed space (how?)
> > > > 
> > > > They can't check that.  It turns out that most current Linuxes
> > > > have no issues DMAing a few bytes from the stack.
> > >
> > > Will the DMA remapping calls work with data from the stack?
> > 
> > On "most current Linuxes" yes.  All I know about, in fact.
> > But it's not guaranteed.
> 
> OK. Thanks

please NEVER EVER do dma from or to a stack variable. It's not allowed
on all architectures and it is really really bad practice in general
anyway. 

