Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290740AbSBLCxS>; Mon, 11 Feb 2002 21:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290743AbSBLCxI>; Mon, 11 Feb 2002 21:53:08 -0500
Received: from pizda.ninka.net ([216.101.162.242]:31367 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290740AbSBLCwt>;
	Mon, 11 Feb 2002 21:52:49 -0500
Date: Mon, 11 Feb 2002 18:51:00 -0800 (PST)
Message-Id: <20020211.185100.68039940.davem@redhat.com>
To: davidm@hpl.hp.com
Cc: anton@samba.org, linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: thread_info implementation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15464.33256.837784.657759@napali.hpl.hp.com>
In-Reply-To: <15464.32354.452126.182563@napali.hpl.hp.com>
	<20020211.183603.111204707.davem@redhat.com>
	<15464.33256.837784.657759@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@hpl.hp.com>
   Date: Mon, 11 Feb 2002 18:46:00 -0800
   
   OK, so back to square one: why am I supposed to do all this work for
   something that will likely slow things slightly down and, at best,
   doesn't hurt performance?  The old set up works great and as far as
   I'm concerned, is not broken.

It keeps your platform the same, and it does help other platforms.
It is the nature of any abstraction change we make in the kernel
that platforms have to deal with.

So at least we're to the point where you could be convinced that
there are no down sides to the change?  Let's go over your list:

1) massive locore assembly changes

   ummm no, just put current_thread_info into your thread register

2) pointer dereference causes performance problems

   ummm no, not really, go test it for yourself if you don't
   believe me

This only leaves "I don't want to do the conversion because it has
no benefit to ia64."  Well, it doesn't hurt your platform either,
so just cope :-)
