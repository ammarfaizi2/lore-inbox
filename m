Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbUKMW7C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbUKMW7C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 17:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbUKMW7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 17:59:01 -0500
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:17850 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S261185AbUKMW67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 17:58:59 -0500
Date: Sat, 13 Nov 2004 23:54:00 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
Message-ID: <20041113225400.GA12939@bogon.ms20.nix>
References: <200411080521.iA85LbG6025914@hera.kernel.org> <200411132000.31465.adaplas@hotpop.com> <Pine.LNX.4.58.0411130959280.4100@ppc970.osdl.org> <200411140529.48977.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411140529.48977.adaplas@hotpop.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2004 at 05:29:46AM +0800, Antonino A. Daplas wrote:
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
XFree86 switches the card to big endian mode anyway. Running rivafb in
little endian might cause us great deals of pain for little gain.
Cheers,
 -- Guido
