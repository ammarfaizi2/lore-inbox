Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266038AbTAUGwL>; Tue, 21 Jan 2003 01:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266041AbTAUGwL>; Tue, 21 Jan 2003 01:52:11 -0500
Received: from dp.samba.org ([66.70.73.150]:30409 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266020AbTAUGwI>;
	Tue, 21 Jan 2003 01:52:08 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: size in /proc/modules 
In-reply-to: Your message of "Mon, 20 Jan 2003 14:27:03 -0000."
             <20030120142703.GA58326@compsoc.man.ac.uk> 
Date: Tue, 21 Jan 2003 17:44:21 +1100
Message-Id: <20030121070114.A6A3D2C282@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030120142703.GA58326@compsoc.man.ac.uk> you write:
> 
> /proc/modules size field includes init_size in 2.5. Why ?
> 
> The removal of sensible values in /proc/ksyms means that oprofile can no
> longer attribute module samples reliably. The only information we have
> is module_core address, and size == core_size+init_size. Since init code
> is removed in sys_init_module, this will overestimate, and can lead to
> overlapping with the start of another module, afaics.
> 
> In 2.4, we had size(.text), which could underestimate (think
> .text.exit), but that is not a big problem.
> 
> Rusty, does this fall under another one of your "corner cases" ? (what I
> would call "flaky code" ...)
> 
> Or I have I just missed something obvious ?

Yes, line 1328 of kernel/module.c, by the sound of it 8)

I was thinking of you when I added this, actually.

Hope that helps!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
