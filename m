Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161010AbWBAKsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbWBAKsZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 05:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161014AbWBAKsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 05:48:25 -0500
Received: from ns1.suse.de ([195.135.220.2]:55970 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161010AbWBAKsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 05:48:23 -0500
From: Andi Kleen <ak@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [patch 14/44] generic hweight{64,32,16,8}()
Date: Wed, 1 Feb 2006 11:24:27 +0100
User-Agent: KMail/1.8.2
Cc: Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
       Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       dev-etrax@axis.com, David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Chris Zankel <chris@zankel.net>
References: <20060201090224.536581000@localhost.localdomain> <200602011006.09596.ak@suse.de> <43E07EB2.4020409@tls.msk.ru>
In-Reply-To: <43E07EB2.4020409@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602011124.29423.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 February 2006 10:26, Michael Tokarev wrote:
> Andi Kleen wrote:
> > On Wednesday 01 February 2006 10:02, Akinobu Mita wrote:
> > 
> >>+static inline unsigned int hweight32(unsigned int w)
> []
> > How large are these functions on x86? Maybe it would be better to not inline them,
> > but put it into some C file out of line.
> 
> hweight8	47 bytes
> hweight16	76 bytes
> hweight32	97 bytes
> hweight64	56 bytes (NOT inlining hweight32)
> hweight64	197 bytes (inlining hweight32)
> 
> Those are when compiled as separate non-inlined functions,
> with pushl %ebp and ret.

This would argue for moving them out of line.

-Andi
