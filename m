Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266408AbTBPLlE>; Sun, 16 Feb 2003 06:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266431AbTBPLlE>; Sun, 16 Feb 2003 06:41:04 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:11978 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266408AbTBPLlD>; Sun, 16 Feb 2003 06:41:03 -0500
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make jiffies wrap 5 min after boot
References: <Pine.LNX.4.33L2.0302040935230.6174-100000@dragon.pdx.osdl.net>
	<Pine.LNX.4.33.0302160232120.7975-100000@gans.physik3.uni-rostock.de>
	<20030216020808.GF9833@krispykreme>
	<20030216024317.GM29983@holomorphy.com>
	<1045377459.2175.0.camel@phantasy>
	<20030216071659.GB6417@actcom.co.il>
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 16 Feb 2003 12:50:34 +0100
In-Reply-To: <20030216071659.GB6417@actcom.co.il>
Message-ID: <871y281m2d.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (broccoli)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <mulix@mulix.org> writes:

> On Sun, Feb 16, 2003 at 01:37:40AM -0500, Robert Love wrote:
> > On Sat, 2003-02-15 at 21:43, William Lee Irwin III wrote:
> > 
> > > Can I get a vote for ~0UL instead of -1UL?
> > 
> > OK, I bite.  What is the difference?  Aren't both equivalent?
> 
> I have no idea if that's what wli meant, but -1UL is only "all ones"
> in a 2's complement binary representation. 

No. Wraparound of unsigned types is well-defined. -1UL must be the
largest possible unsigned long value, which must consist of only 1
bits (except for possible padding bits).

Of course, no machines with ones-complement (or padding bits, or
integer trap representations, or any of the other ISO braindamages)
exist, so this is mostly irrelevant anyway.

-- 
	Falk
