Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWJHPZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWJHPZg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 11:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWJHPZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 11:25:36 -0400
Received: from www.osadl.org ([213.239.205.134]:3515 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751221AbWJHPZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 11:25:35 -0400
Subject: Re: + clocksource-increase-initcall-priority.patch added to -mm
	tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, johnstul@us.ibm.com, mingo@elte.hu, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160319033.3693.19.camel@c-67-180-230-165.hsd1.ca.comcast.net>
References: <200610070153.k971ren4020838@shell0.pdx.osdl.net>
	 <1160294812.22911.8.camel@localhost.localdomain>
	 <1160302797.22911.37.camel@localhost.localdomain>
	 <1160319033.3693.19.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 16:53:54 +0200
Message-Id: <1160319234.5686.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 07:50 -0700, Daniel Walker wrote:
> On Sun, 2006-10-08 at 12:19 +0200, Thomas Gleixner wrote:
> > On Sun, 2006-10-08 at 10:06 +0200, Thomas Gleixner wrote:
> > > On Fri, 2006-10-06 at 18:53 -0700, akpm@osdl.org wrote:
> > > > Since it's likely that this interface would get used during bootup I moved all
> > > > the clocksource registration into the postcore initcall.  This also eliminated
> > > > some clocksource shuffling during bootup.
> > > 
> > > We had the init call in postcore already. John moved it to module init
> > > to eliminate trouble with unsynced / unstable TSCs, IIRC.
> > > 
> > > John, can you please comment on this.
> > 
> > It also breaks pmtimer.
> 
> OGAWA reported this already. It breaks the case when there is a verified
> read needed, instead of the fast read. I'll fix it.

I'd like to know, why we need to move that and you did not explain _why_
it is likely that it is used during bootup.

	tglx


