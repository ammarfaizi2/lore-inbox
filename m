Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbVL3D4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbVL3D4g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 22:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbVL3D4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 22:56:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56529 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750886AbVL3D4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 22:56:36 -0500
Date: Thu, 29 Dec 2005 22:56:07 -0500
From: Dave Jones <davej@redhat.com>
To: Mark Lord <lkml@rtr.ca>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051230035607.GD20371@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Mark Lord <lkml@rtr.ca>,
	Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>, arjan@infradead.org,
	linux-kernel@vger.kernel.org, mpm@selenic.com
References: <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <43B4ADD0.4040906@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B4ADD0.4040906@rtr.ca>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 10:47:28PM -0500, Mark Lord wrote:
 > >If we change some /proc file thing, breakage is often totally
 > >unintentional, and complaining is the right thing - people might not even
 > >have realized it broke.
 > 
 > Okay, I'm complaining:  /proc/cpuinfo is no longer correct
 > for my Pentium-M notebook, as ov 2.6.15-rc7.  Now it reports
 > a cpu speed of approx 800Mhz for a 2.0Mhz Pentium-M.

It's reporting the 'current running speed'. You have speedstep-centrino
loaded, (and probably a governor changing the speed down when idle).

I don't see how this can be construed as breakage btw.
Which application breaks due to this changing ?

		Dave

