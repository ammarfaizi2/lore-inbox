Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265920AbUFVU6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265920AbUFVU6h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266001AbUFVUta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:49:30 -0400
Received: from aun.it.uu.se ([130.238.12.36]:22493 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266021AbUFVUlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 16:41:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16600.39256.669322.177553@alkaid.it.uu.se>
Date: Tue, 22 Jun 2004 22:40:56 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6.7-mm1] perfctr ppc32 update
In-Reply-To: <1087935661.1855.10.camel@gaston>
References: <200406212014.i5LKElHD019224@alkaid.it.uu.se>
	<1087928274.1881.4.camel@gaston>
	<16600.37372.473221.988885@alkaid.it.uu.se>
	<1087935661.1855.10.camel@gaston>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt writes:
 > On Tue, 2004-06-22 at 15:09, Mikael Pettersson wrote:
 > > Benjamin Herrenschmidt writes:
 > >  > Hrm... your code will not work with externally clocked timebases
 > >  > (like the G5) and I'm not sure you get the core freq. right with
 > >  > CPU that can do clock slewing or machines that can switch the
 > >  > core/bus ratio (laptops).
 > > 
 > > Do you mean the PLL_CFG code that's been in -mm for the last couple
 > > of weeks, or just the recently posted update? The update replaced
 > > in-kernel /proc/cpuinfo parsing (gross) with OF queries taken straight
 > > from the pmac code in arch/ppc/platform/.
 > > 
 > > I'm ignoring 970/G5 until IBM releases the damn documentation.
 > 
 > Well, the G5 can have it's own tb but can also be externally clocked and
 > that's how Apple does. I'm not sure about all G4 models.

So what you're saying is that PLL_CFG may not reflect the true
relationship between the TB frequency and the core frequency?

That shouldn't be a problem as long as there's _some_ in-kernel
interface for finding that out. If querying OF isn't the correct
approach, then what is?

/Mikael
