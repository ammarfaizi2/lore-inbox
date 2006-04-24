Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWDXUQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWDXUQy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWDXUQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:16:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64215 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751120AbWDXUQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:16:53 -0400
Date: Mon, 24 Apr 2006 16:16:46 -0400
From: Alan Cox <alan@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, alan@redhat.com,
       Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: better leve triggered IRQ management needed
Message-ID: <20060424201646.GA23517@devserv.devel.redhat.com>
References: <20060424114105.113eecac@localhost.localdomain> <Pine.LNX.4.64.0604241156340.3701@g5.osdl.org> <Pine.LNX.4.64.0604241203130.3701@g5.osdl.org> <1145908402.3116.63.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145908402.3116.63.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 09:53:22PM +0200, Arjan van de Ven wrote:
> we now have that neat polling thing Alan did for interrupts (but which
> is optional). To limp along better the kernel could auto-enable that for
> any such shared interrupt automatically as a "safe fallback"...
> (or heck, if things are this broken, you probably want it for all
> interrupts at that point just to be sure)

That is really something drivers should handle themselves if they are doing
shared edge trigger. For one the kernel core has no idea the right polling
time and for two its often possible to pull dirty tricks to avoid the race.

Alan

