Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbVDRTky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVDRTky (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 15:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVDRTky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 15:40:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60123 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262183AbVDRTkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 15:40:46 -0400
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
From: Arjan van de Ven <arjan@infradead.org>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: Roland Dreier <roland@topspin.com>, Troy Benjegerdes <hozer@hozed.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <4263DF70.2060702@ammasso.com>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	 <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com>
	 <4263DBBF.9040801@ammasso.com>
	 <1113840973.6274.84.camel@laptopd505.fenrus.org>
	 <4263DF70.2060702@ammasso.com>
Content-Type: text/plain
Date: Mon, 18 Apr 2005 21:40:40 +0200
Message-Id: <1113853240.6274.99.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
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

On Mon, 2005-04-18 at 11:25 -0500, Timur Tabi wrote:
> Arjan van de Ven wrote:
> 
> > this is a myth; linux is free to move the page about in physical memory
> > even if it's mlock()ed!!
> 
> Then Linux has a very odd definition of the word "locked".
> 
> > And even then, the user can munlock the memory from another thread etc
> > etc. Not a good idea.
> 
> Well, that's okay, because then the app is doing something stupid, so we don't worry about 
> that.

you should since that physical page can be reused, say by a root
process, and you'd be majorly screwed


