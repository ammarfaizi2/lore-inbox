Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbULAAsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbULAAsd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbULAAeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:34:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:65504 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261207AbULAATe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:19:34 -0500
Date: Tue, 30 Nov 2004 16:18:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Alexandre Oliva <aoliva@redhat.com>, dhowells <dhowells@redhat.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <matthew@wil.cx>, hch@infradead.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <Pine.LNX.4.58.0411301605500.22796@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0411301612370.22796@ppc970.osdl.org>
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
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Nov 2004, Linus Torvalds wrote:
> 
> Even atomic.h. I could well imagine that somebody includes atomic.h just 
> to get the thread-safe updates for some architectures. For example, 
> asm-alpha/atomic.h does it right, and I would not be at all surprised if 
> somebody had noticed.

In fact, this is not entirely theoretical. I know people _have_ noticed, 
because I've gotten queries from some projects that wanted to copy the 
definitions for their alpha port. I only got those queries because my name 
is on the file, and those people wanted to actually copy them, not just 
include the header file. I don't know _how_ many people decided to just 
do the #include.

There are probably more people familiar with the kernel source tree than 
with GLIB which is probably the preferred way to do those things these 
days. And a few years ago that choice wasn't even there. 

		Linus
