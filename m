Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261804AbTCQReH>; Mon, 17 Mar 2003 12:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261812AbTCQRdT>; Mon, 17 Mar 2003 12:33:19 -0500
Received: from dp.samba.org ([66.70.73.150]:32219 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261804AbTCQRdL>;
	Mon, 17 Mar 2003 12:33:11 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Subject: Re: 2.5 modprobe doesn't handle alias chains? 
Cc: linux-kernel@vger.kernel.org
In-reply-to: Your message of "Tue, 04 Mar 2003 00:35:40 BST."
             <200303032335.h23NZetq012628@harpo.it.uu.se> 
Date: Mon, 17 Mar 2003 07:58:15 +1100
Message-Id: <20030317174406.8353D2C0FC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200303032335.h23NZetq012628@harpo.it.uu.se> you write:
> Rusty,
> 
> In converting my 2.5 build to make the serial driver a module,
> I discovered that alias chains in modprobe.conf apparently
> don't work. This is with module-init-tools-0.9.9.
> 
> I had 'alias char-major-4 serial' and 'alias char-major-5 serial'
> in modprobe.conf, since that's what's built into 2.4 modutils, and
> then I added 'alias serial 8250'. This did not work: opening /dev/ttyS0
> resulted in modprobe complaining 'FATAL: Module serial not found'.
> 
> Is this a bug or a design limitation?

Well, it's a documented feature, see modprobe.conf(5).  You can use
install commands instead if you really want recursion, or do as you
did and simply resolve the alias by hand.

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
