Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWJHKOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWJHKOw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 06:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWJHKOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 06:14:52 -0400
Received: from www.osadl.org ([213.239.205.134]:28343 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751039AbWJHKOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 06:14:51 -0400
Subject: Re: + clocksource-increase-initcall-priority.patch added to -mm
	tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: akpm@osdl.org
Cc: dwalker@mvista.com, johnstul@us.ibm.com, mingo@elte.hu,
       zippel@linux-m68k.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160294812.22911.8.camel@localhost.localdomain>
References: <200610070153.k971ren4020838@shell0.pdx.osdl.net>
	 <1160294812.22911.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 12:19:57 +0200
Message-Id: <1160302797.22911.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 10:06 +0200, Thomas Gleixner wrote:
> On Fri, 2006-10-06 at 18:53 -0700, akpm@osdl.org wrote:
> > Since it's likely that this interface would get used during bootup I moved all
> > the clocksource registration into the postcore initcall.  This also eliminated
> > some clocksource shuffling during bootup.
> 
> We had the init call in postcore already. John moved it to module init
> to eliminate trouble with unsynced / unstable TSCs, IIRC.
> 
> John, can you please comment on this.

It also breaks pmtimer.

	tglx


