Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbUK3X6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUK3X6R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbUK3Xzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:55:35 -0500
Received: from canuck.infradead.org ([205.233.218.70]:5130 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262464AbUK3XwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:52:10 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>, Alexandre Oliva <aoliva@redhat.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <matthew@wil.cx>, dhowells <dhowells@redhat.com>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
In-Reply-To: <Pine.LNX.4.58.0411301452180.22796@ppc970.osdl.org>
References: <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
	 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
	 <1101828924.26071.172.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.58.0411300751570.22796@ppc970.osdl.org>
	 <1101832116.26071.236.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.58.0411300846190.22796@ppc970.osdl.org>
	 <1101837135.26071.380.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.58.0411301020160.22796@ppc970.osdl.org>
	 <20041130224851.GH8040@waste.org>
	 <Pine.LNX.4.58.0411301452180.22796@ppc970.osdl.org>
Content-Type: text/plain
Date: Tue, 30 Nov 2004 23:51:37 +0000
Message-Id: <1101858697.4574.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-30 at 14:55 -0800, Linus Torvalds wrote:
> 
> On Tue, 30 Nov 2004, Matt Mackall wrote:
> > 
> > So we follow dhowell's plan with the following additions:
> 
> No.
> 
> We do _not_ move stuff over that is questionable.
> 
> I thought that was clear by now. The rules are:
>  - we only move things that _have_ to move
>  - we don't break existing programs, and no "but they are broken already" 
>    is not an excuse.
>  - we only move things where that _particular_ move can be shown to be 
>    beneficial.
> 
> No whole-sale moves. No "let's break things that I think are broken". No 
> "let's change things because we can".
> 
> Well-defined moves. Both in content _and_ in reason.

Fine. And yes, we do it piecemeal with each part being given individual
consideration.

I'd like to aim for a conclusion where everything which userspace needs
is in the new directories and nothing is required from the private
directories any more. But let's start with the really important parts
which really _are_ crying out to be fixed.

-- 
dwmw2

