Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264891AbTLZHII (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 02:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264920AbTLZHII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 02:08:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11531 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264891AbTLZHIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 02:08:05 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: GCC 3.4 Heads-up
Date: 25 Dec 2003 23:07:35 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bsgmnn$5ef$1@cesium.transmeta.com>
References: <1072403207.17036.37.camel@clubneon.clubneon.com> <bsgav5$4qh$1@cesium.transmeta.com> <Pine.LNX.4.58.0312252021540.14874@home.osdl.org> <20031226005840.A30827@hexapodia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20031226005840.A30827@hexapodia.org>
By author:    Andy Isaacson <adi@hexapodia.org>
In newsgroup: linux.dev.kernel
>
> On Thu, Dec 25, 2003 at 08:34:33PM -0800, Linus Torvalds wrote:
> > The cast/conditional expression as lvalue are _particularly_ ugly 
> > extensions, since there is absolutely zero point to them. They are very 
> > much against what C is all about, and writing something like this:
> > 
> > 	a ? b : c = d;
> > 
> > is something that only a high-level language person could have come up 
> > with. The _real_ way to do this in C is to just do
> > 
> > 	*(a ? &b : &c) = d;
> > 
> > which is portable C, does the same thing, and has no strange semantics.
> 
> But doesn't the first one potentially let the compiler avoid spilling to
> memory, if b and c are both in registers?
> 
> Not that I'm fond of gccisms, but this one at least seems to have a
> potential value.  And I'm sure I came up with an instance of it making
> my head ache, a while back, but I can't come up with a bad example now.
> Care to elaborate on your "strange semantics"?
> 

A decent compiler should be able to avoid spills in either case.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
