Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbUCOU5I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 15:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbUCOU4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 15:56:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:9687 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262751AbUCOU4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 15:56:45 -0500
Date: Mon, 15 Mar 2004 12:54:17 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: davem@redhat.com, cieciwa@alpha.zarz.agh.edu.pl,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [SPARC64][PPC] strange error ..
Message-Id: <20040315125417.3839f8fa.rddunlap@osdl.org>
In-Reply-To: <20040315204346.GB13167@smtp.west.cox.net>
References: <Pine.LNX.4.58L.0403151437360.16193@alpha.zarz.agh.edu.pl>
	<Pine.LNX.4.58L.0403151939460.17732@alpha.zarz.agh.edu.pl>
	<20040315190026.GG4342@smtp.west.cox.net>
	<20040315123953.3b6b863f.davem@redhat.com>
	<20040315204346.GB13167@smtp.west.cox.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2004 13:43:46 -0700 Tom Rini wrote:

| On Mon, Mar 15, 2004 at 12:39:53PM -0800, David S. Miller wrote:
| 
| > On Mon, 15 Mar 2004 12:00:26 -0700
| > Tom Rini <trini@kernel.crashing.org> wrote:
| > 
| > > That leaves the more general problem of <asm/unistd.h> uses 'asmlinkage'
| > > on platforms where either (or both) of the following can be true:
| > > - 'asmlinkage' is a meaningless term, and shouldn't be used.
| > > - <asm/unistd.h> doesn't include <linux/linkage.h> so it's possible
| > >   another file down the line breaks.
| > 
| > I think the best fix is to include linux/linkage.h in asm/unistd.h as
| > you seem to be suggesting, and therefore that is the change I will
| > push off to Linus to fix this on sparc32 and sparc64.
| 
| Erm, if I read include/asm-sparc{,64}/linkage.h right, 'asmlinkage' ends
| up being defined to ''.  So why not just remove 'asmlinkage' from the
| offending line in unistd.h ?

For future-proofing:  so that it will be like all other $arch/unistd.h,
so that when someone changes the meaning of it, it will just work...?

--
~Randy
