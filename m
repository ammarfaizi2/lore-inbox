Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVAIUdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVAIUdl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 15:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVAIUdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 15:33:39 -0500
Received: from canuck.infradead.org ([205.233.218.70]:19462 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261754AbVAIUd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 15:33:26 -0500
Subject: Re: removing bcopy... because it's half broken
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Richard Henderson <rth@twiddle.net>
In-Reply-To: <Pine.LNX.4.58.0501091213000.2339@ppc970.osdl.org>
References: <20050109192305.GA7476@infradead.org>
	 <Pine.LNX.4.58.0501091213000.2339@ppc970.osdl.org>
Content-Type: text/plain
Date: Sun, 09 Jan 2005 21:33:19 +0100
Message-Id: <1105302799.4173.58.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-09 at 12:19 -0800, Linus Torvalds wrote:
> 
> On Sun, 9 Jan 2005, Arjan van de Ven wrote:
> >
> > Instead of fixing this inconsistency, I decided to remove it entirely,
> > explicit memcpy() and memmove() are prefered anyway (welcome to the 1990's)
> > and nothing in the kernel is using these functions, so this saves code size
> > as well for everyone.
> 

> Gcc _used_ to have a target-specific "do I use bcopy or memcpy" setting,
> and I just don't know if that is still true. I also don't know if it
> affected any other platforms than alpha (I would assume that it matched
> "target has BSD heritage", and that would likely mean HP-UX too)

actually I think that is called -ffreestanding, and 
ChangeSet 1.2088, 2005/01/04 21:29:33-08:00, bunk@stusta.de
added that to the compiler flags in your tree ....



