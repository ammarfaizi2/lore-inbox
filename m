Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWHNQ0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWHNQ0z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWHNQ0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:26:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62926 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751492AbWHNQ0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:26:54 -0400
Date: Mon, 14 Aug 2006 12:26:38 -0400
From: Dave Jones <davej@redhat.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Thomas Koeller <thomas@koeller.dyndns.org>, wim@iguana.be,
       linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
       linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-ID: <20060814162638.GC15569@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Randy.Dunlap" <rdunlap@xenotime.net>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Koeller <thomas@koeller.dyndns.org>, wim@iguana.be,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
References: <200608102319.13679.thomas@koeller.dyndns.org> <20060811205639.GK26930@redhat.com> <200608120149.23380.thomas@koeller.dyndns.org> <20060814141445.GA10763@nineveh.rivenstone.net> <20060814153033.GA25215@mars.ravnborg.org> <20060814092124.84f7ff3e.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060814092124.84f7ff3e.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 09:21:24AM -0700, Randy.Dunlap wrote:
 > On Mon, 14 Aug 2006 17:30:33 +0200 Sam Ravnborg wrote:
 > 
 > > On Mon, Aug 14, 2006 at 10:14:45AM -0400, Joseph Fannin wrote:
 > > > On Sat, Aug 12, 2006 at 01:49:23AM +0200, Thomas Koeller wrote:
 > > > > On Friday 11 August 2006 22:56, Dave Jones wrote:
 > > > > > On Thu, Aug 10, 2006 at 11:19:13PM +0200,
 > > > > > thomas@koeller.dyndns.org wrote:
 > > > > >  > +
 > > > > >  > +#include <linux/config.h>
 > > > > >
 > > > > > not needed.
 > > > >
 > > > > It is, otherwise I do not get CONFIG_WATCHDOG_NOWAYOUT.
 > > Yes you do - try it.
 > > make V=1 tells you that -include include/linux/autoconf.h pulls in
 > > the CONFIG_ definitions.
 > 
 > Sure, autoconf.h is included, but I think his point is that
 > CONFIG_WATCHDOG_NOWAYOUT may not be defined there at all,
 > as in my 2.6.18-rc4 autoconf.h file, since my .config file says:
 > # CONFIG_WATCHDOG_NOWAYOUT is not set

As Wim pointed out, linux/watchdog.h has this magick..

#ifdef CONFIG_WATCHDOG_NOWAYOUT
#define WATCHDOG_NOWAYOUT   1
#else
#define WATCHDOG_NOWAYOUT   0
#endif

Which takes some of the ugly out of the drivers :-)

		Dave

-- 
http://www.codemonkey.org.uk
