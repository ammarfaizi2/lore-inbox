Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUBBVZn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 16:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265816AbUBBVZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 16:25:43 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:37009 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S265768AbUBBVZl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 16:25:41 -0500
Date: Mon, 2 Feb 2004 22:25:43 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Compile Regression in 2.4.25-pre8][PATCH 37/42]
Message-ID: <20040202212542.GA17839@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan> <20040202200344.GK6785@dreamland.darkstar.lan> <Pine.GSO.4.58.0402022207240.19699@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0402022207240.19699@waterleaf.sonytel.be>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Mon, Feb 02, 2004 at 10:08:48PM +0100, Geert Uytterhoeven ha scritto: 
> On Mon, 2 Feb 2004, Kronos wrote:
> > siimage.c:65: warning: control reaches end of non-void function
> >
> > The last statement before the end is BUG(), but I added a return to
> > silence the warning.
> >
> > diff -Nru -X dontdiff linux-2.4-vanilla/drivers/ide/pci/siimage.c linux-2.4/drivers/ide/pci/siimage.c
> > --- linux-2.4-vanilla/drivers/ide/pci/siimage.c	Tue Nov 11 17:51:38 2003
> > +++ linux-2.4/drivers/ide/pci/siimage.c	Sat Jan 31 19:07:56 2004
> > @@ -62,6 +62,9 @@
> >  			return 0;
> >  	}
> >  	BUG();
> > +
> > +	/* gcc will complain */
> > +	return 0;
> >  }
> 
> What about adding `attribute ((noreturn))' to the declaration of BUG() instead?

BUG() is a macro, it won't work.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
#include <stdio.h> 
int main(void) {printf("\t\t\b\b\b\b\b\b");
printf("\t\t\b\b\b\b\b\b");return 0;}
