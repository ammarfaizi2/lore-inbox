Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289331AbSAOArb>; Mon, 14 Jan 2002 19:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289329AbSAOArR>; Mon, 14 Jan 2002 19:47:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26385 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289328AbSAOArI>; Mon, 14 Jan 2002 19:47:08 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Date: 14 Jan 2002 16:46:50 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1vu5q$1uu$1@cesium.transmeta.com>
In-Reply-To: <20020114125228.B14747@thyrsus.com> <20020114223042.ENDG28486.femail48.sdc1.sfba.home.com@there> <20020114173423.A23081@thyrsus.com> <20020115080218.7709cef7.bruce@ask.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020115080218.7709cef7.bruce@ask.ne.jp>
By author:    Bruce Harada <bruce@ask.ne.jp>
In newsgroup: linux.dev.kernel
>
> On Mon, 14 Jan 2002 17:34:23 -0500
> "Eric S. Raymond" <esr@thyrsus.com> wrote:
> 
> > Therefore I try to stay focused on Aunt Tillie even though I know
> > that you are objectively correct and her class of user is likely
> > not to build kernels regularly for some years yet.
> 
> Change that last line to read "her class of user will never build kernels ever,
> and would be aggressively disinterested in the possibility of doing so", and
> you might be closer to the truth.
> 
> Aunt Tillie just DOESN'T CARE, OK? She can talk to her vendor if she gets
> worried about whether her kernel supports the Flangelistic2000 SuperDoodad.
> 

I would make this an even stronger statement:

We (yes, we) should make sure Aunt Tillie doesn't ever have to build a
kernel, ever.  If we have designed our kernels so that:

a) A distributor needs more than a handful of kernels (UP, SMP,
   SMP+PAE, perhaps CMOV or not) on their install CD, or;

b) It's not possible to add a driver without rebuilding the kernel, or;

c) It's not possible to autodetect the module set needed AT RUNTIME;

then we have screwed up.  Kernel compile autoconfiguration is a red
herring in that respect; I would argue if anything it hides the real
issue.  We're currently crappy at both (b) and (c) -- a monolithic
kernel does (c) a lot better, and that is quite frankly unacceptable.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
