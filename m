Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272555AbTHEVQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 17:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272846AbTHEVQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 17:16:25 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:16148 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S272555AbTHEVQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 17:16:03 -0400
Date: Tue, 5 Aug 2003 21:15:54 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Andi Kleen <ak@colin2.muc.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export touch_nmi_watchdog
Message-ID: <20030805211554.B603@devserv.devel.redhat.com>
References: <20030805203137.E30256@devserv.devel.redhat.com> <Pine.LNX.4.44.0308051402300.2835-100000@home.osdl.org> <20030805211416.GD31598@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030805211416.GD31598@colin2.muc.de>; from ak@colin2.muc.de on Tue, Aug 05, 2003 at 11:14:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 11:14:16PM +0200, Andi Kleen wrote:
> > Otherwise this will just keep on expanding. 
> 
> It does expand on i386 exactly because the watchdog is disabled by default.
> 
> Looks like a mistake to me. It should be on because having usable backtraces
> on a deadlock/hang is useful enough that it outweights any other possible
> disadvantages. That's especially true for kernels out there at user's boxes,
> not just special debugging kernels run by developers.
> 
> [if there should be any hardware where it doesn't work it should be blacklisted
> there]

the reason it's off is that certain IBM bioses corrupt the eax register on
NMI's when they collide with smm stuff... You'd be surprised how
tolerant x86 is against such corruptions... but not 100%  :)
