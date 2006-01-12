Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161250AbWALUjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161250AbWALUjM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 15:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161251AbWALUjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 15:39:12 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:50071 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1161250AbWALUjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 15:39:10 -0500
Date: Thu, 12 Jan 2006 20:37:51 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Ulrich Mueller <ulm@kph.uni-mainz.de>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       Brice Goglin <Brice.Goglin@ens-lyon.org>, Andrew Morton <akpm@osdl.org>,
       Alan Hourihane <alanh@tungstengraphics.com>
Subject: Re: 2.6.15-mm2
In-Reply-To: <17350.39878.474574.712791@a1i15.kph.uni-mainz.de>
Message-ID: <Pine.LNX.4.58.0601122036430.32194@skynet>
References: <20060107052221.61d0b600.akpm@osdl.org> <43C0172E.7040607@ens-lyon.org>
 <20060107210413.GL9402@redhat.com> <43C03214.5080201@ens-lyon.org>
 <43C55148.4010706@ens-lyon.org> <20060111202957.GA3688@redhat.com>
 <u3bjtogq0@a1i15.kph.uni-mainz.de> <20060112171137.GA19827@redhat.com>
 <17350.39878.474574.712791@a1i15.kph.uni-mainz.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> > Another one that advertises no AGP capabilities.
> > In this situation you shouldn't *need* agpgart.  If it's PCI[E],
> > radeon will use pcigart.
>
> Problem is that i915 depends on DRM && AGP && AGP_INTEL.
> And at the end of i{810,830,915}_dma.c there is the comment:
> "All Intel graphics chipsets are treated as AGP, even if they are
> really PCI-e."
>

I've cc'ed Alan Hourihane, but from memory the Intel on-board graphics
chips don't advertise the AGP bit on the graphics controllers but work
using AGP...

I've got an PCIE chipset with Radeon on it, and in that case I could get
away without agpgart...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

