Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSGVB7j>; Sun, 21 Jul 2002 21:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315491AbSGVB7j>; Sun, 21 Jul 2002 21:59:39 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:7322 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315485AbSGVB7i>;
	Sun, 21 Jul 2002 21:59:38 -0400
Date: Mon, 22 Jul 2002 11:43:01 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: glynis@butterfly.hjsoft.com
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: still having smp/snat problems (Re: Linux 2.4.19-rc3)
Message-Id: <20020722114301.2dfcf1b8.rusty@rustcorp.com.au>
In-Reply-To: <20020720041700.GA8172@butterfly.hjsoft.com>
References: <Pine.LNX.4.44.0207192119380.28216-100000@freak.distro.conectiva>
	<20020720041700.GA8172@butterfly.hjsoft.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jul 2002 00:17:01 -0400
glynis@butterfly.hjsoft.com wrote:

> On Fri, Jul 19, 2002 at 09:20:49PM -0300, Marcelo Tosatti wrote:
> > <rusty@rustcorp.com.au> (02/07/17 1.630)
> > 	[PATCH] The real netfilter conntrack SMP overrun fix
> 
> assuming this should have fixed this:
> LIST_DELETE: ip_conntrack_core.c:165
> `&ct->tuplehash[IP_CT_DIR_REPLY]'(dd8f2e90) not in &ip_conntrack_hash
> [hash_conntrack(&ct->tuplehash[IP_CT_DIR_REPLY].tuple)].

Nope, that's the mysterious half-deleted bug.

> Gnu C                  gcc (GCC) 3.1.1 20020703 (Debian prerelease) Copyright (C) 2002 Free Software Foundation, Inc. This is free software; see the source for copying conditions. There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

And it's always associated with a wierd compiler version like this.

1) Does this happen reliably enough for you to decide whether something
   fixes it?
2) If so, please try dropping compiler versions.

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
