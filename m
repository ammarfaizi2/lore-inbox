Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbUDSV45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUDSV45 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 17:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbUDSV45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 17:56:57 -0400
Received: from mailgate.Cadence.COM ([158.140.2.1]:16027 "EHLO
	mailgate.Cadence.COM") by vger.kernel.org with ESMTP
	id S261932AbUDSV4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 17:56:50 -0400
Subject: Re: [BUG] e1000 fails on 2.4.26+bk with CONFIG_SMP=y
From: Chris Croswhite <csc@cadence.com>
Reply-To: csc@cadence.com
To: joe.korty@ccur.com
Cc: Willy Tarreau <w@w.ods.org>, cramerj@intel.com, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040419214247.GA5273@tsunami.ccur.com>
References: <20040416224422.GA19095@tsunami.ccur.com>
	 <20040417072455.GD596@alpha.home.local>
	 <20040419165425.GA3988@tsunami.ccur.com>
	 <20040419193930.GA28340@alpha.home.local>
	 <20040419214247.GA5273@tsunami.ccur.com>
Content-Type: text/plain
Organization: Cadence Design Systems, Inc
Message-Id: <1082412219.5804.241.camel@d158140025182.Cadence.COM>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 19 Apr 2004 15:03:39 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, using the dual 85540 board w/e1000 works fine on a quad SMP w/APIC
support.

However, if I try to bond, I get immediate detonation.


On Mon, 2004-04-19 at 14:42, Joe Korty wrote:
> On Mon, Apr 19, 2004 at 09:39:30PM +0200, Willy Tarreau wrote:
> > On Mon, Apr 19, 2004 at 12:54:25PM -0400, Joe Korty wrote:
> >> 
> >> Uniprocessor 2.4.26 works fine.
> >> Uniprocessor 2.4.26 + local apic works fine.
> >> Uniprocessor 2.4.26 + local apic + io apic fails.
> > 
> > interesting. Unfortunately, I didn't have time to try on the machine I told
> > you about last day. But right here, I have a dual athlon communicating
> > with an alpha, both with e1000 (544) in 2.4.26. Since there's a PCI
> > bridge on your quad, I wonder if the IOAPIC doesn't trigger an interrupt
> > routing problem with bridges. Are all the ports unusable or do some of
> > them work reliably in APIC mode ?
> 
> I just verified that the Quad Ethernet board works with 2.6.5 SMP, so it
> is unlikely to be a bridge or other hardware problem.
> 
> For 2.4.26, the Dell 650 has an Intel 82545EM Gigabit Ethernet Controller
> soldered in, which also uses the e1000 driver, and that works fine, so
> we know the 2.4.26 e1000 driver works with some of these Intel chips.
> 
> When the Quad board works, it negotiates down to 10 MBits/sec Half Duplex.
> Not sure yet if this is what it is supposed to be doing in our environment.
> 
> Regards,
> Joe
> 
> PS: do you CC'ed Intel guys have some insights or data for us?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

