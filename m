Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262748AbUCOUnv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 15:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbUCOUnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 15:43:51 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:39878 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S262748AbUCOUns
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 15:43:48 -0500
Date: Mon, 15 Mar 2004 13:43:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: cieciwa@alpha.zarz.agh.edu.pl, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [SPARC64][PPC] strange error ..
Message-ID: <20040315204346.GB13167@smtp.west.cox.net>
References: <Pine.LNX.4.58L.0403151437360.16193@alpha.zarz.agh.edu.pl> <Pine.LNX.4.58L.0403151939460.17732@alpha.zarz.agh.edu.pl> <20040315190026.GG4342@smtp.west.cox.net> <20040315123953.3b6b863f.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315123953.3b6b863f.davem@redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 12:39:53PM -0800, David S. Miller wrote:

> On Mon, 15 Mar 2004 12:00:26 -0700
> Tom Rini <trini@kernel.crashing.org> wrote:
> 
> > That leaves the more general problem of <asm/unistd.h> uses 'asmlinkage'
> > on platforms where either (or both) of the following can be true:
> > - 'asmlinkage' is a meaningless term, and shouldn't be used.
> > - <asm/unistd.h> doesn't include <linux/linkage.h> so it's possible
> >   another file down the line breaks.
> 
> I think the best fix is to include linux/linkage.h in asm/unistd.h as
> you seem to be suggesting, and therefore that is the change I will
> push off to Linus to fix this on sparc32 and sparc64.

Erm, if I read include/asm-sparc{,64}/linkage.h right, 'asmlinkage' ends
up being defined to ''.  So why not just remove 'asmlinkage' from the
offending line in unistd.h ?

-- 
Tom Rini
http://gate.crashing.org/~trini/
