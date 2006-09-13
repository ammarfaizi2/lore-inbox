Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWIMSqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWIMSqN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 14:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWIMSqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 14:46:13 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2830 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751102AbWIMSqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 14:46:12 -0400
Date: Wed, 13 Sep 2006 19:45:58 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Howells <dhowells@redhat.com>, Matthew Wilcox <matthew@wil.cx>,
       Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/6] Implement a general log2 facility in the kernel
Message-ID: <20060913184558.GB15563@flint.arm.linux.org.uk>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	David Howells <dhowells@redhat.com>,
	Matthew Wilcox <matthew@wil.cx>, Adrian Bunk <bunk@stusta.de>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	linux-arch@vger.kernel.org
References: <20060913163806.GA15563@flint.arm.linux.org.uk> <20060913130253.32022.69230.stgit@warthog.cambridge.redhat.com> <20060913130300.32022.69743.stgit@warthog.cambridge.redhat.com> <20060913161734.GE3564@stusta.de> <20060913163136.GA2585@parisc-linux.org> <4143.1158166615@warthog.cambridge.redhat.com> <Pine.LNX.4.62.0609132038350.27940@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0609132038350.27940@pademelon.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 08:38:59PM +0200, Geert Uytterhoeven wrote:
> On Wed, 13 Sep 2006, David Howells wrote:
> > Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > 
> > > Therefore, re-using "log2()" is about as bad as re-using the "strcmp()"
> > > name to implement a function which copies strings.
> > 
> > I should probably use ilog2() then which would at least be consistent with the
> > powerpc arch.
> > 
> > > t.c:2: warning: conflicting types for built-in function 'log2'
> 
> And apparently gcc < 4.0 doesn't give the warning.

Eh?  That's gcc 3.4.3 producing that warning.  It probably depends on
the target configuration.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
