Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270370AbTGMTt1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 15:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270374AbTGMTt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 15:49:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44215 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270370AbTGMTtX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 15:49:23 -0400
Date: Sun, 13 Jul 2003 21:04:09 +0100
From: Matthew Wilcox <willy@debian.org>
To: Bernardo Innocenti <bernie@develer.com>
Cc: Richard Henderson <rth@twiddle.net>, Matthew Wilcox <willy@debian.org>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: do_div vs sector_t
Message-ID: <20030713200409.GA23808@parcelfarce.linux.theplanet.co.uk>
References: <20030711223359.GP20424@parcelfarce.linux.theplanet.co.uk> <20030713172622.GA13824@twiddle.net> <200307132114.35887.bernie@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307132114.35887.bernie@develer.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 09:14:35PM +0200, Bernardo Innocenti wrote:
> On Sunday 13 July 2003 19:26, Richard Henderson wrote:
> > On Fri, Jul 11, 2003 at 11:33:59PM +0100, Matthew Wilcox wrote:
> > > Better ideas?
> >
> >           if (likely(((n) >> 31 >> 1) == 0)) {
> 
> Do we still need to fix this? I've already posted a patch to disallow
> calling do_div() with any divisor that doesn't look like an unsigned
> 64bit interger.

No, I think the combination of sector_div() and your patch makes everything
happy-happy.  Thanks!

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
