Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbTI1XII (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 19:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbTI1XII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 19:08:08 -0400
Received: from mail013.syd.optusnet.com.au ([211.29.132.67]:27365 "EHLO
	mail013.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262761AbTI1XIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 19:08:06 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16247.27068.359462.789349@wombat.chubb.wattle.id.au>
Date: Mon, 29 Sep 2003 09:07:40 +1000
To: Jes Sorensen <jes@trained-monkey.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Frank v Waveren <fvw@var.cx>,
       Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: Re: How do I access ioports from userspace?
In-Reply-To: <m3vfrg0vxp.fsf@trained-monkey.org>
References: <20030925160351.E26493@one-eyed-alien.net>
	<20030926052636.GA15006@var.cx>
	<1064561225.28616.15.camel@gaston>
	<20030926073407.GA15797@var.cx>
	<1064562042.28617.23.camel@gaston>
	<m3vfrg0vxp.fsf@trained-monkey.org>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jes" == Jes Sorensen <jes@trained-monkey.org> writes:

>>>>> "Ben" == Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
Ben> On Fri, 2003-09-26 at 09:34, Frank v Waveren wrote:
>>> in[bwl]/out[bwl] are available on a lot more than just x86. Mind
>>> you, the mechanisms are subtly different. Then again, if you're
>>> using direct hardware access you're not going for portability
>>> anyway.

Ben> Are they from userland ? I doubt it...

Jes> Actually yes on some architectures, ia64 emulates it the ia32
Jes> API. That said, it's certainly not something one should be
Jes> encouraged to do, using MMIO is a far better approach.

They're available at least in i386, alpha, ia64.
However  they allow access only to the first 64k of IO address space.
So you may not be able to access you device if it's in the wrong PCI
slot... 

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.
