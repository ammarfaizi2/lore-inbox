Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267411AbTACFLU>; Fri, 3 Jan 2003 00:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267412AbTACFLU>; Fri, 3 Jan 2003 00:11:20 -0500
Received: from dp.samba.org ([66.70.73.150]:15782 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267411AbTACFLT>;
	Fri, 3 Jan 2003 00:11:19 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] Module licence and EXPORT_SYMBOL_GPL 
In-reply-to: Your message of "Thu, 02 Jan 2003 20:28:31 -0800."
             <Pine.LNX.4.44.0301022025200.1700-100000@home.transmeta.com> 
Date: Fri, 03 Jan 2003 16:19:13 +1100
Message-Id: <20030103051949.2D7FB2C052@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0301022025200.1700-100000@home.transmeta.com> you wri
te:
> 
> On Fri, 3 Jan 2003, Rusty Russell wrote:
> > 
> > Linus, your options:
> > 1) Drop the patch and leave well enough alone.
> > 2) Just keep the module licence taint check.
> > 3) Say OK to the whole thing (once I've tested it against latest bk).
> 
> Hmm.. Can you make the "module_is_gpl()" thing a load-time check, and 
> instead of carrying the license string along at run-time, you just carry 
> the "I'm GPL-ok'd" bit along. 

Just call it ".init.license" instead of ".license" and you're done:
it's never used at runtime (well, setting the mod->license field to
NULL after init to make sure noone abuses it might make sense).

I'll test it now...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
