Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbUK3XSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUK3XSM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbUK3XOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:14:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:19625 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262425AbUK3XM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:12:57 -0500
Date: Tue, 30 Nov 2004 15:12:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alexandre Oliva <aoliva@redhat.com>
cc: Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <or4qj7rllv.fsf@livre.redhat.lsd.ic.unicamp.br>
Message-ID: <Pine.LNX.4.58.0411301505580.22796@ppc970.osdl.org>
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
 <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com>
 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
 <oract0thnj.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411291458040.22796@ppc970.osdl.org>
 <oris7nrq0h.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411301413260.22796@ppc970.osdl.org>
 <or4qj7rllv.fsf@livre.redhat.lsd.ic.unicamp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Nov 2004, Alexandre Oliva wrote:

> On Nov 30, 2004, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > On Tue, 30 Nov 2004, Alexandre Oliva wrote:
> 
> >> Then maybe this is the fundamental problem.  As long as the kernel
> >> doesn't recognize that an ABI is a contract, rather than an
> >> imposition, kernel developers won't care.
> 
> > That's a silly analogy. Worse, it's a very flawed analogy.
> 
> > If you want to use a legal analogy, the ABI is not a contract, it's a
> > public _license_.
> 
> I didn't mean to use a legal analogy.  I meant contract in the
> software engineering sense.  Sorry if that wasn't clear.

Then your definition of a "contract" is flawed or your world-view has 
nothing to do with reality.

An ABI is not a contract. It's somebody exposing a certain set of 
features. It does _not_ mean that the party that gets exposed has any say 
wrt the features. At most he can hope that the exported set doesn't 
shrink or change semantically, but let's face it, even that does happen.

The Linux kernel has been very very good about this exposure, in the sense 
that we try very very hard not to break it. I think that's a good thing. 
But that in no way makes anything a "contract".

It's the same thing with CPU vendors. You as a programmer, didn't get to 
dictate what the CPU vendor implemented. You take it or leave it, and at 
most you can make suggestions about things that might make the CPU vendor 
sell more chips. The ISA is not a "contract" - it's just an interface that 
was handed down to you. You didn't get to negotiate, you got to say "yes" 
or "no".

		Linus
