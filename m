Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbTI1Rhs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 13:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbTI1Rhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 13:37:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:673 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262635AbTI1Rhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 13:37:47 -0400
Date: Sun, 28 Sep 2003 10:37:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Bernardo Innocenti <bernie@develer.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test6
In-Reply-To: <Pine.LNX.4.44.0309281213240.4929-100000@callisto>
Message-ID: <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 28 Sep 2003, Geert Uytterhoeven wrote:
> 
> On Sat, 27 Sep 2003, Linus Torvalds wrote:
> > Bernardo Innocenti:
> >   o GCC 3.3.x/3.4 compatiblity fix in include/linux/init.h
> 
> This change breaks 2.95 for some source files, because <linux/init.h> doesn't
> include <linux/compiler.h>. Do you want to have the missing include added to
> <linux/init.h>, or to the individual source files that need it?

Interesting. I'm pretty sure I did a "make allyesconfig" just before the
test6 release, so apparently x86 includes it indirectly through some path, 
and so it only shows up on m68k and arm?

This, btw, is a pretty common thing. I wonder what we could do to make 
sure that different architectures wouldn't have so different include file 
structures. It's happened _way_ too often.

Any ideas?

		Linus

