Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262750AbSJaO3Z>; Thu, 31 Oct 2002 09:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262782AbSJaO3Y>; Thu, 31 Oct 2002 09:29:24 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:59781 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262750AbSJaO3X>; Thu, 31 Oct 2002 09:29:23 -0500
Subject: Re: What's left over.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Russell King <rmk@arm.linux.org.uk>,
       Peter Chubb <peter@chubb.wattle.id.au>, tridge@samba.org, tytso@mit.edu
In-Reply-To: <3DC13D81.4050008@pobox.com>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
	<20021031030143.401DA2C150@lists.samba.org>
	<20021031101558.GB7487@fib011235813.fsnet.co.uk> 
	<3DC13D81.4050008@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 31 Oct 2002 14:55:22 +0000
Message-Id: <1036076122.8852.68.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-31 at 14:26, Jeff Garzik wrote:
> Yeah, historically we have avoided things like this.
> kcalloc gets proposed every year or so too.

I would like to see both of these in because tons of kernel fixing that
has been done through audits has been about


	get_user(a, ...)
	kmalloc(a * sizeof(b), ..)

We end up with loads of ugly  > MAXINT/sizeof(foo) if checks in the code
that ought to be in one place


