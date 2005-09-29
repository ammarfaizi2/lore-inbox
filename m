Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbVI2UCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbVI2UCu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 16:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbVI2UCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 16:02:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48079 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030197AbVI2UCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 16:02:49 -0400
Date: Thu, 29 Sep 2005 12:57:05 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Willy Tarreau <willy@w.ods.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
In-Reply-To: <1127979848.2918.7.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0509291247040.3308@g5.osdl.org>
References: <43384E28.8030207@adaptec.com> <4339BFE9.1060604@pobox.com> 
 <4339CCD6.5010409@adaptec.com> <4339F9A8.2030709@pobox.com> 
 <433AFEB2.7090003@adaptec.com> <433B0457.7020509@pobox.com> 
 <433B14E1.6080201@adaptec.com> <433B217F.4060509@pobox.com> 
 <20050929040403.GE18716@alpha.home.local> <1127979848.2918.7.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Sep 2005, Arjan van de Ven wrote:
> 
> a spec describes how the hw works... how we do the sw piece is up to
> us ;)

How we do the SW is indeed up to us, but I want to step in on your first 
point.

Again.

A "spec" is close to useless. I have _never_ seen a spec that was both big 
enough to be useful _and_ accurate.

And I have seen _lots_ of total crap work that was based on specs. It's 
_the_ single worst way to write software, because it by definition means 
that the software was written to match theory, not reality.

So there's two MAJOR reasons to avoid specs:

 - they're dangerously wrong. Reality is different, and anybody who thinks 
   specs matter over reality should get out of kernel programming NOW. 
   When reality and specs clash, the spec has zero meaning. Zilch. Nada.
   None.

   It's like real science: if you have a theory that doesn't match 
   experiments, it doesn't matter _how_ much you like that theory. It's
   wrong. You can use it as an approximation, but you MUST keep in mind 
   that it's an approximation.

 - specs have an inevitably tendency to try to introduce abstractions
   levels and wording and documentation policies that make sense for a 
   written spec. Trying to implement actual code off the spec leads to the 
   code looking and working like CRAP. 

   The classic example of this is the OSI network model protocols. Classic 
   spec-design, which had absolutely _zero_ relevance for the real world. 
   We still talk about the seven layers model, because it's a convenient 
   model for _discussion_, but that has absolutely zero to do with any 
   real-life software engineering. In other words, it's a way to _talk_ 
   about things, not to implement them.

   And that's important. Specs are a basis for _talking_about_ things. But 
   they are _not_ a basis for implementing software.

So please don't bother talking about specs. Real standards grow up 
_despite_ specs, not thanks to them.

		Linus
