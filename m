Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbVI3HF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbVI3HF1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 03:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVI3HF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 03:05:27 -0400
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:63246
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S932567AbVI3HF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 03:05:26 -0400
Date: Thu, 29 Sep 2005 23:52:06 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Arjan van de Ven <arjan@infradead.org>, Willy Tarreau <willy@w.ods.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
In-Reply-To: <Pine.LNX.4.58.0509291247040.3308@g5.osdl.org>
Message-ID: <Pine.LNX.4.10.10509292345300.27623-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

I have to tip my hat to you sir.

As much as I wanted to believe and tried to make it happen ... ATA/IDE was
forced to design many exception case events.  Regardless how hard I an
others tried to invoke/create a driver to mimic the "SPEC", the hardware
people broke most of the rules and each chipset was littered with
exception cases.

It has been 7 years since you and I started butting heads, and in the end
both of us were right.  A driver could be written to follow the standard
exactly, and it would never work (alone, as-is) because the hardware was
not paying attention the rules book.

Hope you can kick back and laugh about the history, too!

Have a great Day!

Andre Hedrick
LAD Storage Consulting Group

On Thu, 29 Sep 2005, Linus Torvalds wrote:

> 
> 
> On Thu, 29 Sep 2005, Arjan van de Ven wrote:
> > 
> > a spec describes how the hw works... how we do the sw piece is up to
> > us ;)
> 
> How we do the SW is indeed up to us, but I want to step in on your first 
> point.
> 
> Again.
> 
> A "spec" is close to useless. I have _never_ seen a spec that was both big 
> enough to be useful _and_ accurate.
> 
> And I have seen _lots_ of total crap work that was based on specs. It's 
> _the_ single worst way to write software, because it by definition means 
> that the software was written to match theory, not reality.
> 
> So there's two MAJOR reasons to avoid specs:
> 
>  - they're dangerously wrong. Reality is different, and anybody who thinks 
>    specs matter over reality should get out of kernel programming NOW. 
>    When reality and specs clash, the spec has zero meaning. Zilch. Nada.
>    None.
> 
>    It's like real science: if you have a theory that doesn't match 
>    experiments, it doesn't matter _how_ much you like that theory. It's
>    wrong. You can use it as an approximation, but you MUST keep in mind 
>    that it's an approximation.
> 
>  - specs have an inevitably tendency to try to introduce abstractions
>    levels and wording and documentation policies that make sense for a 
>    written spec. Trying to implement actual code off the spec leads to the 
>    code looking and working like CRAP. 
> 
>    The classic example of this is the OSI network model protocols. Classic 
>    spec-design, which had absolutely _zero_ relevance for the real world. 
>    We still talk about the seven layers model, because it's a convenient 
>    model for _discussion_, but that has absolutely zero to do with any 
>    real-life software engineering. In other words, it's a way to _talk_ 
>    about things, not to implement them.
> 
>    And that's important. Specs are a basis for _talking_about_ things. But 
>    they are _not_ a basis for implementing software.
> 
> So please don't bother talking about specs. Real standards grow up 
> _despite_ specs, not thanks to them.
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

