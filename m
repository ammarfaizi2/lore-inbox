Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267630AbUHPOGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267630AbUHPOGY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 10:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267643AbUHPOGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 10:06:24 -0400
Received: from nevyn.them.org ([66.93.172.17]:15011 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S267630AbUHPOGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 10:06:19 -0400
Date: Mon, 16 Aug 2004 10:06:10 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, Willy Tarreau <willy@w.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matthew Wilcox <willy@debian.org>
Subject: Re: Linux v2.6.8 - Oops on NFSv3
Message-ID: <20040816140610.GA24688@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Christoph Hellwig <hch@infradead.org>,
	Willy Tarreau <willy@w.ods.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Matthew Wilcox <willy@debian.org>
References: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org> <20040814101039.GA27163@alpha.home.local> <Pine.LNX.4.58.0408140336170.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408140344110.1839@ppc970.osdl.org> <20040814115548.A19527@infradead.org> <Pine.LNX.4.58.0408140404050.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408140404050.1839@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 04:05:56AM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 14 Aug 2004, Christoph Hellwig wrote:
> > 
> > Cane we make this 2.6.9 to avoid breaking all kinds of scripts expecting
> > three-digit kernel versions?
> 
> Well, we've been discussing the 2.6.x.y format for a while, so I see this 
> as an opportunity to actually do it... Will it break automated scripts? 
> Maybe. But on the other hand, we'll never even find out unless we try it 
> some time.

This will break glibc's OS version checks.  It won't show up as a problem
now, since it's mostly used to ignore versions of libraries which are
too new for the running kernel, and 2.6.8.1 is as new as it gets.  But
that code is going to think the version is humongously greater than
2.6.8 and 2.6.9.

See Uli's response:
  http://sources.redhat.com/ml/libc-alpha/2003-11/msg00025.html

-- 
Daniel Jacobowitz
