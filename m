Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264850AbTF2WEG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 18:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbTF2WEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 18:04:06 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:29322 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S264850AbTF2WD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 18:03:57 -0400
Date: Mon, 30 Jun 2003 00:18:14 +0200
From: David Weinehall <tao@acc.umu.se>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix in-kernel genksyms for parisc symbols
Message-ID: <20030629221814.GQ17986@khan.acc.umu.se>
References: <20030625061924.3D1272C28B@lists.samba.org> <Pine.LNX.4.44.0306252221320.10554-100000@chaos.tp1.ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306252221320.10554-100000@chaos.tp1.ruhr-uni-bochum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 10:22:09PM +0200, Kai Germaschewski wrote:
> On Wed, 25 Jun 2003, Rusty Russell wrote:
> 
> > In message <1056410864.1826.57.camel@mulgrave> you write:
> > > The problem is that the parisc libgcc.a library contains symbols that
> > > look like $$mulI and the like, but genksyms doesn't think $ is legal for
> > > a function symbol, so they all get dropped from the output.  This means
> > > that inserting almost any module on parisc taints the kernel because
> > > these symbols have no version.
> > > 
> > > The fix (attached below) was to allow $ in an identifier in lex.l (and
> > > obviously to update the _shipped files as well, but my flex/bison seem
> > > to be rather different from the one they were generated with, so I'll
> > > leave that to whomever has the correct versions).
> > 
> > Looks fine, but my flex is different, too.  Kai?
> 
> I merged it, will submit.

Could you divulge what version of flex you use, to simplify future
changes?


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
