Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbUKMXx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbUKMXx6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 18:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbUKMXx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 18:53:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:42686 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261214AbUKMXwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 18:52:53 -0500
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: adaplas@pol.net
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linus Torvalds <torvalds@osdl.org>, Guido Guenther <agx@sigxcpu.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200411140529.48977.adaplas@hotpop.com>
References: <200411080521.iA85LbG6025914@hera.kernel.org>
	 <200411132000.31465.adaplas@hotpop.com>
	 <Pine.LNX.4.58.0411130959280.4100@ppc970.osdl.org>
	 <200411140529.48977.adaplas@hotpop.com>
Content-Type: text/plain
Date: Sun, 14 Nov 2004 10:52:00 +1100
Message-Id: <1100389920.20511.133.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-11-14 at 05:29 +0800, Antonino A. Daplas wrote:
> On Sunday 14 November 2004 02:00, Linus Torvalds wrote:
> > On Sat, 13 Nov 2004, Antonino A. Daplas wrote:
> > > Why not use in_be* and out_be* for __raw_read and raw_write?
> >
> > Please don't start using some stupid magic ppc-specific macros for a
> > driver that has no reason to be PPC-specific. It then only causes bugs
> > that show on one platform and not another.
> 
> I'm not. I'm just wondering that if the other approach was taken (keep the
> hardware in little endian mode), then the write/read* macros, which are just
> wrappers for in_le*/out_le*, would have been used. Would it help fix (or
> cover up) bugs that are in PPC but not x86? 

If you switch the HW to LE, I'm afraid you'll lockup when VT switching
back & forth with X ...

Ben.


