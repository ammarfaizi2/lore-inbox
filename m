Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272303AbTHEVOY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 17:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272361AbTHEVOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 17:14:24 -0400
Received: from colin2.muc.de ([193.149.48.15]:37903 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S272303AbTHEVOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 17:14:20 -0400
Date: 5 Aug 2003 23:14:16 +0200
Date: Tue, 5 Aug 2003 23:14:16 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export touch_nmi_watchdog
Message-ID: <20030805211416.GD31598@colin2.muc.de>
References: <20030805203137.E30256@devserv.devel.redhat.com> <Pine.LNX.4.44.0308051402300.2835-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308051402300.2835-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Otherwise this will just keep on expanding. 

It does expand on i386 exactly because the watchdog is disabled by default.

Looks like a mistake to me. It should be on because having usable backtraces
on a deadlock/hang is useful enough that it outweights any other possible
disadvantages. That's especially true for kernels out there at user's boxes,
not just special debugging kernels run by developers.

[if there should be any hardware where it doesn't work it should be blacklisted
there]

-Andi

