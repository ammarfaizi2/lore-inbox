Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVAMR0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVAMR0Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVAMRYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:24:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:11697 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261234AbVAMRTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:19:43 -0500
Date: Thu, 13 Jan 2005 09:19:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
In-Reply-To: <1105635662.6031.35.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org>
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> 
 <20050112185133.GA10687@kroah.com>  <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
  <20050112161227.GF32024@logos.cnet>  <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
  <20050112205350.GM24518@redhat.com>  <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
  <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com>
  <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>  <20050113082320.GB18685@infradead.org>
  <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org>
 <1105635662.6031.35.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jan 2005, Arjan van de Ven wrote:
> 
> I think you are somewhat misguided on these: the randomisation done in
> FC does NOT prohibit prelink for working, with the exception of special
> PIE binaries. Does this destroy the randomisation? No: prelink *itself*
> randomizes the addresses when creating it's prelink database

There was a kernel-based randomization patch floating around at some 
point, though. I think it's part of PaX. That's the one I hated. 

Although I haven't seen it in a long time, so you may well be right that 
that one too is fine. 

My point was really more about the generic issue of me being two-faced: 
I'll encourage people to do things that I don't actually like myself in 
the standard kernel. 

I just think that forking at some levels is _good_. I like the fact that 
different vendors have different objectives, and that there are things 
like Immunix and PaX etc around. Of course, the problem that sometimes 
results in is the very fact that because I encourage others to have 
special patches, they en dup not even trying to feed back _parts_ of them.

In this case I really believe that was the case. There are fixes in PaX
that make sense for the standard kernel. But because not _all_ of PaX
makes sense for the standard kernel, and because I will _not_ take their
patch whole-sale, they apparently believe (incorrectly) that I wouldn't
even take the non-intrusive fixes, and haven't really even tried to feed
them back.

(Yes, Brad Spengler has talked to me about PaX, but never sent me 
individual patches, for example. People seem to expect me to take all or 
nothing - and there's a _lot_ of pretty extreme people out there that 
expect everybody else to be as extreme as they are..)

		Linus
