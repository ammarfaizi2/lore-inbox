Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317345AbSHLHFn>; Mon, 12 Aug 2002 03:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317421AbSHLHFm>; Mon, 12 Aug 2002 03:05:42 -0400
Received: from dp.samba.org ([66.70.73.150]:15067 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S317345AbSHLHFl>;
	Mon, 12 Aug 2002 03:05:41 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, marcelo@conectiva.com.br, davej@suse.de
Subject: Trivial Patch Policy (trivial@rustcorp.com.au)
Date: Mon, 12 Aug 2002 17:07:05 +1000
Message-Id: <20020812020958.93C7B2C07A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	I've been collecting trivial patches for a few months now, and
it's time to solidify some rules:

1) Trivial patches must qualify for one of the following to be
   accepted:
	a) Spelling fixes (useful for grep, and sets a good example)
	b) Warning fixes (cluttering with useless warnings is bad)
	c) Compilation fixes (only if they are actually correct)
	d) Runtime fixes (only if they actually fix things)
	e) Removing use of deprecated functions/macros (eg. check_region).
	f) Contact detail and documentation fixes
	g) Non-portable code replaced by portable code
	   (even in arch-specific, since people copy, as long as it's trivial)
	h) Any fix by the author/maintainer of the file.
	   (ie. patch monkey in re-transmission mode)

   They must also be "trivial" by my definition of trivial.  Best
   patches contain enough context for me to judge without opening the
   file (diff -C<nn> -u is your friend).

   NOTE: This means I'll only take whitespace/indentation fixes from
   the author or maintainer.

2) The patch will not be forwarded to anyone until a new kernel has
   been released after I receive the patch, *unless* noone else is
   sent the patch.  So if you cc: the trivial patch monkey, it'll only
   be forwarded from there if it doesn't make the next kernel.

3) The first time the patch is forwarded, it will be sent to the
   author and/or maintainer.  If they say they've included it in their
   tree, no more forwards will occur (modulo some timeout eventually).
   If they NAK it, the patch will be closed.  Otherwise, the patch
   will be sent directly to Linus or Marcelo on future forwards (the
   maintainer will still be cc'd).

Hopefully this will be a good compromise between coordinating with
maintainers who want control of their files, and stopping trivial
patches from slipping through the cracks.

Cheers!
Rusty, aka the Trivial Patch Monkey.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
