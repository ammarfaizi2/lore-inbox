Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268650AbUIXJyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268650AbUIXJyD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 05:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268652AbUIXJyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 05:54:03 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:17025 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S268650AbUIXJyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 05:54:00 -0400
Date: Fri, 24 Sep 2004 11:53:48 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] matroxfb big-endian update (was Re: [PATCH] ppc64: Fix __raw_* IO accessors)
Message-ID: <20040924095348.GA30132@vana.vc.cvut.cz>
References: <523c1bpghm.fsf@topspin.com> <Pine.LNX.4.58.0409211237510.25656@ppc970.osdl.org> <52mzzjnuq7.fsf@topspin.com> <Pine.LNX.4.58.0409211510150.25656@ppc970.osdl.org> <1095816897.21231.32.camel@gaston> <20040922185851.GA11017@vana.vc.cvut.cz> <1095900539.6359.46.camel@gaston> <20040923152530.GA9377@vana.vc.cvut.cz> <20040923202601.GA6586@vana.vc.cvut.cz> <1096007137.4009.38.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096007137.4009.38.camel@gaston>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 04:25:37PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2004-09-24 at 06:26, Petr Vandrovec wrote:
> > Hi Andrew & Linus,
> > 
> > This change disconnects matroxfb accelerator endianess from processor endianess, plus
> > ports big-endian accessors from __raw_xxx to xxx + appropriate byte swaps.
> 
> Applied to current bk, make oldconfig (FB_MATROX_BIG_ENDIAN_ACCEL is not set),
> works like a charm on the ppc POWER3 I have here, haven't had a chance to
> test X though.

Thanks. 

XFree 3.x did not touch BE mode bit and accessed MMIO directly with pointer 
dereference (expecting firmware to put card into BE mode?), while XFree 4.x (if
I understand code properly) does not touch BE bit on primary device
(while it clears it on secondary devices) while expecting hardware to be
in LE mode...

So I'm either confused, or XF3 needs BE_ACCEL set while XF4 needs BE_ACCEL
disabled.  Does anybody actually use matroxfb with XFree server on PPC (or any
other BE machine) at all?
							Petr Vandrovec

P.S.: Trimmed down CC list a bit. 
