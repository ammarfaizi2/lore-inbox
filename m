Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161271AbWALVDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161271AbWALVDX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 16:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161272AbWALVDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 16:03:22 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:26123 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S1161271AbWALVDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 16:03:21 -0500
Subject: Re: 2.6.15-mm2
From: Alan Hourihane <alanh@tungstengraphics.com>
To: Dave Airlie <airlied@linux.ie>
Cc: Ulrich Mueller <ulm@kph.uni-mainz.de>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org, Brice Goglin <Brice.Goglin@ens-lyon.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0601122036430.32194@skynet>
References: <20060107052221.61d0b600.akpm@osdl.org>
	 <43C0172E.7040607@ens-lyon.org> <20060107210413.GL9402@redhat.com>
	 <43C03214.5080201@ens-lyon.org> <43C55148.4010706@ens-lyon.org>
	 <20060111202957.GA3688@redhat.com> <u3bjtogq0@a1i15.kph.uni-mainz.de>
	 <20060112171137.GA19827@redhat.com>
	 <17350.39878.474574.712791@a1i15.kph.uni-mainz.de>
	 <Pine.LNX.4.58.0601122036430.32194@skynet>
Content-Type: text/plain
Organization: Tungsten Graphics, Inc.
Date: Thu, 12 Jan 2006 21:03:32 +0000
Message-Id: <1137099813.9711.32.camel@jetpack.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 20:37 +0000, Dave Airlie wrote:
> >
> > > Another one that advertises no AGP capabilities.
> > > In this situation you shouldn't *need* agpgart.  If it's PCI[E],
> > > radeon will use pcigart.
> >
> > Problem is that i915 depends on DRM && AGP && AGP_INTEL.
> > And at the end of i{810,830,915}_dma.c there is the comment:
> > "All Intel graphics chipsets are treated as AGP, even if they are
> > really PCI-e."
> >
> 
> I've cc'ed Alan Hourihane, but from memory the Intel on-board graphics
> chips don't advertise the AGP bit on the graphics controllers but work
> using AGP...
> 
> I've got an PCIE chipset with Radeon on it, and in that case I could get
> away without agpgart...

Dave,

You're probably reading too much into that last statement.

I've never seen a pure PCI-e chipset from Intel (i.e. the ones without
integrated graphics) so that may not be true, but the ones with
integrated graphics are always treated as AGP based. 

Alan.

