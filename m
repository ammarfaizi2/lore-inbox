Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbUK3Q5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbUK3Q5C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 11:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUK3QzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:55:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:60080 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262187AbUK3Qxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:53:50 -0500
Date: Tue, 30 Nov 2004 08:53:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Alexandre Oliva <aoliva@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <1101832116.26071.236.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.58.0411300846190.22796@ppc970.osdl.org>
References: <19865.1101395592@redhat.com>  <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
  <1101406661.8191.9390.camel@hades.cambridge.redhat.com> 
 <20041127032403.GB10536@kroah.com>  <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
  <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> 
 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br> 
 <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org> 
 <1101828924.26071.172.camel@hades.cambridge.redhat.com> 
 <Pine.LNX.4.58.0411300751570.22796@ppc970.osdl.org>
 <1101832116.26071.236.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Nov 2004, David Woodhouse wrote:
> 
> > Same thing here. The __KERNEL__ approach says "whatever you want, boss".  
> > It doesn't get in the way. Maybe it doesn't actively _help_ you either,
> > but you never have to fight any structure it imposes on you.
> 
> Having to think before adding something that's user visible is a
> _benefit_ not a disadvantage.

I've said this at least three times: if you can point to a _specific_ 
thing you want to move, go wild. I think the big waste in this discussion 
has been that there have _not_ been specific suggestions, just total 
sound-bites like "wouldn't it be great to move things to 'include/kapi'".

If you have a specific thing in mind, say instead something like

	"Wouldn't it be great if we moved all the tty layer IOCTL numbers 
	 into 'tty-ioctl-nr.h', and made the old header file just include 
	 that header file, so that new libc users can get them from just 
	 that header? And btw, here's the patch."

then I might listen. Notice how the only really constructive thing to come 
out of this flame-fest has been a patch by Al that looked perfectly 
reasonable, but that got totally drowned out by the arguing?

Note that even _if_ you have a specific thing in mind, I want to see that 
somebody would say "yes, we'd use that organization". I would not be 
surprised at all if glibc people said that they can't really use any 
re-organization anyway, since they need to support old kernel setups too.

See? Changes that aren't specific enough, or don't actually help things is
what I'm against.

		Linus
