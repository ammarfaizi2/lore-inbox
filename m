Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVCCAxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVCCAxR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 19:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVCCAuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 19:50:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2502 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261340AbVCCA15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 19:27:57 -0500
Date: Wed, 2 Mar 2005 19:27:33 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303002733.GH10124@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 04:00:46PM -0800, Linus Torvalds wrote:

 > I would not keep regular driver updates from a 2.6.<even> thing. 

Then the notion of it being stable is bogus, given how many regressions
the last few kernels have brought in drivers.  Moving from 2.6.9 -> 2.6.10
broke ALSA, USB, parport, firewire, and countless other little bits and
pieces that users tend to notice.

The reason that things like 4-level page tables worked out so well
was that it was tested in -mm for however long, so by the time it got
to your tree, the silly bugs had already been shaken out.

Compare this to random-driver-update.  -mm testing is a valuable
proving ground, but its no panacea to stability. There's no guarantee
that someone with $affected_device even tried a -mm kernel.

For it to truly be a stable kernel, the only patches I'd expect to
drivers would be ones fixing blindingly obvious bugs. No cleanups.
No new functionality. I'd even question new hardware support if it
wasn't just a PCI ID addition.

		Dave

