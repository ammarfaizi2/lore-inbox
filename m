Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280305AbRKNH5j>; Wed, 14 Nov 2001 02:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280306AbRKNH53>; Wed, 14 Nov 2001 02:57:29 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:24024 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S280305AbRKNH5S>;
	Wed, 14 Nov 2001 02:57:18 -0500
Date: Wed, 14 Nov 2001 08:57:14 +0100
From: David Weinehall <tao@acc.umu.se>
To: Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reformat mtrr.c to conform to CodingStyle
Message-ID: <20011114085714.V17761@khan.acc.umu.se>
In-Reply-To: <20011112232539.A14409@redhat.com> <20011113121022.L1778@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011113121022.L1778@lynx.no>; from adilger@turbolabs.com on Tue, Nov 13, 2001 at 12:10:22PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2001 at 12:10:22PM -0700, Andreas Dilger wrote:
> On Nov 12, 2001  23:25 -0500, Benjamin LaHaise wrote:
> > Please incorporate this patch to make mtrr.c conform to the standards set 
> > forth in Documentation/CodingStyle which make it much more appealing to 
> > the eyes.
> >
> >  /*  Put the processor into a state where MTRRs can be safely set  */
> > -static void set_mtrr_prepare (struct set_mtrr_context *ctxt)
> > +static void
> > +set_mtrr_prepare(struct set_mtrr_context *ctxt)
> >  {
> 
> Is that actually CodingStyle?  Don't see it much in the kernel code...
> The much more common (AFAICS) style to split long function definitions is
> 
> static void foo_long_function(struct long_struct name *foo, struct bar *bar,
>                               int val, long *err)
> 
> The only reason (AFAICS) for putting the return type on a separate
> line is the (ancient) ansi2knr script, which just throws the return
> types away for pre-ANSI compilers.  Given that the kernel code doesn't
> even conform to ANSI-C, there is no hope in hell of it compiling with
> a pre-ANSI compiler.

grep:ing for the function-name using ^fname is a common use. Easily
solvable anyway, but...

I don't think Lindent does everything 100% correct; at least its
formatting of switch/case does look a little fishy:


	switch (option) {
	case 1: 
		/* blaha */


That feels kind of odd compared to the rest of the codingstyle.

Comments?!


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
