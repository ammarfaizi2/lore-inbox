Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWDXUns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWDXUns (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWDXUnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:43:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37524 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751239AbWDXUnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:43:47 -0400
Subject: Re: better leve triggered IRQ management needed
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060424201646.GA23517@devserv.devel.redhat.com>
References: <20060424114105.113eecac@localhost.localdomain>
	 <Pine.LNX.4.64.0604241156340.3701@g5.osdl.org>
	 <Pine.LNX.4.64.0604241203130.3701@g5.osdl.org>
	 <1145908402.3116.63.camel@laptopd505.fenrus.org>
	 <20060424201646.GA23517@devserv.devel.redhat.com>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 22:43:36 +0200
Message-Id: <1145911417.3116.69.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 16:16 -0400, Alan Cox wrote:
> On Mon, Apr 24, 2006 at 09:53:22PM +0200, Arjan van de Ven wrote:
> > we now have that neat polling thing Alan did for interrupts (but which
> > is optional). To limp along better the kernel could auto-enable that for
> > any such shared interrupt automatically as a "safe fallback"...
> > (or heck, if things are this broken, you probably want it for all
> > interrupts at that point just to be sure)
> 
> That is really something drivers should handle themselves if they are doing
> shared edge trigger.

but the issue is .. drivers don't know. They didn't *want* edge trigger
in the first place generally

>  For one the kernel core has no idea the right polling
> time

well... the corner case (as rmk described) is full starvation; even
polling once per second is better than not polling at tall there.,..

