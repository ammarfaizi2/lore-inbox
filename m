Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWDXTxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWDXTxe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 15:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWDXTxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 15:53:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18584 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751190AbWDXTxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 15:53:33 -0400
Subject: Re: better leve triggered IRQ management needed
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: alan@redhat.com, Stephen Hemminger <shemminger@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604241203130.3701@g5.osdl.org>
References: <20060424114105.113eecac@localhost.localdomain>
	 <Pine.LNX.4.64.0604241156340.3701@g5.osdl.org>
	 <Pine.LNX.4.64.0604241203130.3701@g5.osdl.org>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 21:53:22 +0200
Message-Id: <1145908402.3116.63.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 12:08 -0700, Linus Torvalds wrote:
> 
> On Mon, 24 Apr 2006, Linus Torvalds wrote:
> > 
> > You can get an edge by having your driver make sure that it clears the 
> > interrupt source at some point where it requires an edge.
> 
> Btw, this is why we do end up saying that having _two_ devices share 
> an edge-triggered setup really is something we cannot necessarily 
> fix. That said, it is better to limp along and work as well as you can 
> than to just throw up your hands.

we now have that neat polling thing Alan did for interrupts (but which
is optional). To limp along better the kernel could auto-enable that for
any such shared interrupt automatically as a "safe fallback"...
(or heck, if things are this broken, you probably want it for all
interrupts at that point just to be sure)

