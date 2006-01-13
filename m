Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWAMQuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWAMQuX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 11:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWAMQuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 11:50:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60366 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751247AbWAMQuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 11:50:22 -0500
Date: Fri, 13 Jan 2006 11:49:43 -0500
From: Dave Jones <davej@redhat.com>
To: Alan Hourihane <alanh@tungstengraphics.com>
Cc: Dave Airlie <airlied@gmail.com>, Dave Airlie <airlied@linux.ie>,
       Ulrich Mueller <ulm@kph.uni-mainz.de>, linux-kernel@vger.kernel.org,
       Brice Goglin <Brice.Goglin@ens-lyon.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-mm2
Message-ID: <20060113164943.GA26957@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Hourihane <alanh@tungstengraphics.com>,
	Dave Airlie <airlied@gmail.com>, Dave Airlie <airlied@linux.ie>,
	Ulrich Mueller <ulm@kph.uni-mainz.de>, linux-kernel@vger.kernel.org,
	Brice Goglin <Brice.Goglin@ens-lyon.org>,
	Andrew Morton <akpm@osdl.org>
References: <43C03214.5080201@ens-lyon.org> <43C55148.4010706@ens-lyon.org> <20060111202957.GA3688@redhat.com> <u3bjtogq0@a1i15.kph.uni-mainz.de> <20060112171137.GA19827@redhat.com> <17350.39878.474574.712791@a1i15.kph.uni-mainz.de> <Pine.LNX.4.58.0601122036430.32194@skynet> <1137099813.9711.32.camel@jetpack.demon.co.uk> <21d7e9970601121402u2d05a073kc677f94b278181c0@mail.gmail.com> <1137141125.9634.0.camel@jetpack.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137141125.9634.0.camel@jetpack.demon.co.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 08:32:05AM +0000, Alan Hourihane wrote:
 > On Fri, 2006-01-13 at 09:02 +1100, Dave Airlie wrote:
 > > > >
 > > > > I've cc'ed Alan Hourihane, but from memory the Intel on-board graphics
 > > > > chips don't advertise the AGP bit on the graphics controllers but work
 > > > > using AGP...
 > > > >
 > > > > I've got an PCIE chipset with Radeon on it, and in that case I could get
 > > > > away without agpgart...
 > > >
 > > > Dave,
 > > >
 > > > You're probably reading too much into that last statement.
 > > >
 > > > I've never seen a pure PCI-e chipset from Intel (i.e. the ones without
 > > > integrated graphics) so that may not be true, but the ones with
 > > > integrated graphics are always treated as AGP based.
 > > >
 > > 
 > > I'll show you one at xdevconf if I can get there, it has just a PCI-E
 > > root bridge no graphics controller, we still init AGP on it but I
 > > don't think there is any need, however for all the integrated
 > > graphics, even if they don't advertise AGP they do use it which is
 > > DaveJ's problem that he was trying not to load AGP if the AGP was
 > > being advertised..
 > 
 > O.k. I didn't see the original thread to this. But yes, all integrated
 > graphics based Intel chipsets are AGP regardless if the chip doesn't
 > advertise it correctly.

FWIW, I've dropped that change from agpgart.git. It caused more problems
than it was worth.

		Dave

