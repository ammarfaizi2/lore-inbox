Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWJHIBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWJHIBs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 04:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWJHIBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 04:01:48 -0400
Received: from www.osadl.org ([213.239.205.134]:49589 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750890AbWJHIBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 04:01:47 -0400
Subject: Re: + clocksource-increase-initcall-priority.patch added to -mm
	tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: akpm@osdl.org
Cc: dwalker@mvista.com, johnstul@us.ibm.com, mingo@elte.hu,
       zippel@linux-m68k.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200610070153.k971ren4020838@shell0.pdx.osdl.net>
References: <200610070153.k971ren4020838@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 10:06:52 +0200
Message-Id: <1160294812.22911.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 18:53 -0700, akpm@osdl.org wrote:
> Since it's likely that this interface would get used during bootup I moved all
> the clocksource registration into the postcore initcall.  This also eliminated
> some clocksource shuffling during bootup.

We had the init call in postcore already. John moved it to module init
to eliminate trouble with unsynced / unstable TSCs, IIRC.

John, can you please comment on this.

	tglx
 


