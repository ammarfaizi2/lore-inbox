Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbULAAnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbULAAnn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbULAAkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:40:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:3972 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261194AbULAAhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:37:43 -0500
Date: Tue, 30 Nov 2004 16:37:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Alexandre Oliva <aoliva@redhat.com>, dhowells <dhowells@redhat.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <matthew@wil.cx>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <1101860688.4574.50.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0411301636050.22796@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org> 
 <19865.1101395592@redhat.com>  <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
  <1101406661.8191.9390.camel@hades.cambridge.redhat.com> 
 <20041127032403.GB10536@kroah.com>  <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
  <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> 
 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br>  <8219.1101828816@redhat.com>
  <Pine.LNX.4.58.0411300744120.22796@ppc970.osdl.org> 
 <ormzwzrrmy.fsf@livre.redhat.lsd.ic.unicamp.br> 
 <Pine.LNX.4.58.0411301249590.22796@ppc970.osdl.org> 
 <orekibrpmn.fsf@livre.redhat.lsd.ic.unicamp.br> 
 <Pine.LNX.4.58.0411301423030.22796@ppc970.osdl.org> 
 <1101854061.4574.4.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0411301447570.22796@ppc970.osdl.org> 
 <1101858657.4574.33.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0411301605500.22796@ppc970.osdl.org>
 <1101860688.4574.50.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Dec 2004, David Woodhouse wrote:
> 
> The concept isn't at all hard to understand. But no patch is 'obviously
> correct' if you want to protect against the _slightest_ possibility that
> people might be abusing something you're taking away. 

I really disagree. That's kind of my point. We _can_ make sure that there 
is abzolutely zero semantic content change.

People both inside and outside the kernel who use the old <linux/xxx.h>
headers will get exactly what they got before if we do it right.

> Some people might define __KERNEL__ on purpose when compiling something
> in userspace, to get something that would otherwise be hidden from them.
> Would you consider that sacrosanct too?

Why _do_ you want to break things? Do the cleanup. Don't do the breakage.

		Linus
