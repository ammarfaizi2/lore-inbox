Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbTAJKNC>; Fri, 10 Jan 2003 05:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbTAJKNC>; Fri, 10 Jan 2003 05:13:02 -0500
Received: from dp.samba.org ([66.70.73.150]:24004 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264797AbTAJKM7>;
	Fri, 10 Jan 2003 05:12:59 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: Miles Bader <miles@gnu.org>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] Make `obsolete params' work correctly if MODULE_SYMBOL_PREFIX is non-empty 
In-reply-to: Your message of "Fri, 10 Jan 2003 01:52:03 -0800."
             <20030110015203.A16268@twiddle.net> 
Date: Fri, 10 Jan 2003 21:20:31 +1100
Message-Id: <20030110102144.4BE3C2C113@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030110015203.A16268@twiddle.net> you write:
> On Wed, Jan 08, 2003 at 10:56:51PM +1100, Rusty Russell wrote:
> > +		char sym_name[strlen(obsparm[i].name) + 2];
> 
> Are you really intending to use variable sized allocation
> on the kernel stack?

Yep.  Maximum length of obsolete parameter name in current kernel:
seq_default_timer_resolution (28 chars).

It's far more likely that someone will hit the unchecked kmalloc
allocations in arch/alpha/kernel/modules.c 8)

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
