Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267254AbUHIU1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267254AbUHIU1G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267212AbUHIUZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:25:16 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:41438 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S267198AbUHIUUf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:20:35 -0400
Date: Mon, 9 Aug 2004 13:20:32 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Bob Deblier <bob.deblier@telenet.be>
cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: AES assembler optimizations
In-Reply-To: <1092067328.4332.40.camel@orion>
Message-ID: <Pine.LNX.4.58.0408091314300.25286@twinlark.arctic.org>
References: <2riR3-7U5-3@gated-at.bofh.it>  <m3d620v11e.fsf@averell.firstfloor.org>
 <1092067328.4332.40.camel@orion>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2004, Bob Deblier wrote:

> On Mon, 2004-08-09 at 16:28, Andi Kleen wrote:
> > Bob Deblier <bob.deblier@telenet.be> writes:
> >
> > > Just picked up on KernelTrap that there were some problems with
> > > optimized AES code; if you wish, I can provide my own LGPL licensed (or
> > > I can relicense them for you under GPL), as included in the BeeCrypt
> > > Cryptography Library.
> > >
> > > I have generic i586 code and SSE-optimized code available in GNU
> > > assembler format. Latest version is always available on SourceForge
> > > (http://sourceforge.net/cvs/?group_id=8924).
> >
> > Would be interesting.  Do you have any benchmarks for your code?
>
> BeeCrypt contains benchmarks in the 'tests' subdirectory. Running of
> 'make bench' will execute them. Benchmarks results below for repeatedly
> looping over the same 16K block, produced by 'benchbc', without any
> tweaks (YMMV):
>
> P4 2400, with MMX:
> ECB encrypted 738304 KB in 10.00 seconds = 73823.02 KB/s

the gladman code achieves ~88MB/s for p4 northwood 2.4GHz... without using
mmx.

it looks like your mmx code is 1-2% faster on p-m compared to the gladman
code though -- nice, just a half hour ago i posted wondering if anyone had
taken advantage of the 1 cycle mmx on the p2/p3/p-m processors for doing
the AES XOR steps... and that's what your code does.

unfortunately i don't think that pays off compared to the gladman code on
other x86 processors.

-dean
