Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbUKMVzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbUKMVzm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 16:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbUKMVzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 16:55:42 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:34013 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261170AbUKMVzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 16:55:39 -0500
Subject: Re: [PATCH] Correctly flush 8250 buffers, notify ldisc of line
	status changes.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041113181024.A15735@flint.arm.linux.org.uk>
References: <1099659997.20469.71.camel@localhost.localdomain>
	 <20041109012212.463009c7.akpm@osdl.org>
	 <1099998437.6081.68.camel@localhost.localdomain>
	 <1099998926.15462.21.camel@localhost.localdomain>
	 <20041109132810.A15570@flint.arm.linux.org.uk>
	 <1100006241.15742.6.camel@localhost.localdomain>
	 <20041109144723.C15570@flint.arm.linux.org.uk>
	 <1100011669.16043.28.camel@localhost.localdomain>
	 <20041113181024.A15735@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100379126.28330.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 13 Nov 2004 20:52:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-11-13 at 18:10, Russell King wrote:
> On Tue, Nov 09, 2004 at 02:47:51PM +0000, Alan Cox wrote:
> > I'm working on it. It would be helpful if the drivers/serial code would
> > use helpers and not dig in places it shouldnt so that the transition can
> > be cleaner.
> 
> Ok - I've just applied your patch to 8250 and expanded it to cover the
> other ARM serial drivers.  Should be merged with Linus' tree tomorrow.

Thanks. I'll add a couple more helpers soon for the drivers/char code
that
copies or DMAs blocks of characters

