Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262529AbVAJUpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbVAJUpB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbVAJUo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:44:57 -0500
Received: from waste.org ([216.27.176.166]:22200 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262529AbVAJUoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:44:23 -0500
Date: Mon, 10 Jan 2005 12:43:06 -0800
From: Matt Mackall <mpm@selenic.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Frank van Maarseveen <frankvm@frankvm.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@osdl.org>, Linas Vepstas <linas@austin.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: [PATCH] kernel/printk.c  lockless access
Message-ID: <20050110204306.GE2995@waste.org>
References: <20050106195812.GL22274@austin.ibm.com> <20050106161241.11a8d07c.akpm@osdl.org> <20050107002648.GD14239@krispykreme.ozlabs.ibm.com> <41DDD6FA.2050403@osdl.org> <1105062162.24896.311.camel@localhost.localdomain> <20050109104425.GA9524@janus> <1105278075.12028.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105278075.12028.29.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2005 at 11:00:48PM +0000, Alan Cox wrote:
> On Sul, 2005-01-09 at 10:44, Frank van Maarseveen wrote:
> > What about UDP (or just eth) broadcasting the oops and catching it
> > on another system? That would be useful if one has a lot of systems
> > (I have about 40) and makes it possible to immediately alert someone
> > without the need for ping games.
> 
> netdump and kgdb both can do this. The 2.6.10-tiny1 has some nice kgdb
> patches that include using the polling network debug interfaces.

Netconsole can sends oopses over UDP right now in mainline (since
2.6.3 or so?). And my kgdb over ethernet bits have been in -mm for
quite some time as well. 

(Though testing of -tiny is still appreciated of course.)

-- 
Mathematics is the supreme nostalgia of our time.
