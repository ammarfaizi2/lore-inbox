Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbVHTOzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVHTOzm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 10:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbVHTOzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 10:55:42 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:61713 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932264AbVHTOzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 10:55:41 -0400
Date: Sat, 20 Aug 2005 16:30:19 +0200
From: Willy Tarreau <willy@w.ods.org>
To: linux-kernel@vger.kernel.org
Cc: marcelo.tosatti@cyclades.com
Subject: Linux-2.4.31-hf4
Message-ID: <20050820143019.GA14526@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

After having accumulated a few weeks delay, the fourth hotfix for kernel
2.4.31 is finally out. It was also the right time to release it now that
the isofs and zlib stories came to an end.

Because of the ZISOFS security fix, users of older -hf or plain 2.4.X
should upgrade either to latest -hf or to 2.4.32-pre3. Other fixes are
less important.

As usual, I've also updated 2.4.29 and 2.4.30. So all 3 Kernels 2.4.29-hf14,
2.4.30-hf7 and 2.4.31-hf4 are available as individual, full, and incremental
patches here:

    http://linux.exosec.net/kernel/2.4/2.4-hf/

The changelog is appended to this mail. I've built 2.4.31-hf4 with all
modules, and nothing more yet, but Grant Coady will soon report the
full build and run test here :

    http://bugsplatter.mine.nu/test/linux-2.4/  (warning! URL changed)

Regards,
Willy

--

Changelog From 2.4.31-hf3 to 2.4.31-hf4
---------------------------------------
'+' = added ; '-' = removed

- 2.4.31-zlib-security-bugs-1                                    (Tim Yamin)
+ 2.4.31-zlib-security-bugs-2                     (Tim Yamin, Sergey Vlasov)

  Reverted the Z_OK to Z_DATA_ERROR changes in inftrees.c (& PPC).

+ 2.4.31-zisofs-check-deflatebound-1                        (Linus Torvalds)

  [PATCH] PATCH: Fix outstanding gzip/zlib security issues
  Add fakey 'deflateBound()' function to the in-kernel zlib routines.
  It's not the real deflateBound() in newer zlib libraries, partly because
  the upcoming usage of it won't have the "stream" available, so we can't
  have the same interfaces anyway. Problem noted by Tim Yamin.

+ 2.4.31-nat-fix-memory-corruption-1                       (Patrick McHardy)

  [NETFILTER]: Fix potential memory corruption in NAT code (aka memory NAT)

+ 2.4.31-isofs-option-parse-fix-1               (Horms + Andrey J.Melnikoff)

  Fix isofs option parser. If iocharset, map or session are matched,
  then none of the if or else if clauses under sbsector will match
  (that is none of these clauses match iocharset, map or session),
  and thus the else clause will be hit, and the function will return
  1 without parsing any furhter options. Also fix gcc-3.4 warnings.

+ 2.4.31-netfilter-tcp-unclean-1.diff                      (Patrick McHardy)

  [NETFILTER]: Ignore PSH on SYN/ACK in ipt_unclean

+ 2.4.31-redblacktree-missing-returns-1              (deep-blue@t-online.de)

  [PATCH] fix RedBlackTree rb_next/rb_prev functions. I have found a
  bug in the source of rbtree.c file in /lib. In Kernel 2.6 it's ok,
  but 2.4.31 has this error. We try to use it with the jffs2 source
  code and only with this fix it works fine.

+ 2.4.31-alpha-cabriolet-needs-ns87312-1                       (Bill Dupree)

  [PATCH] Fix Alpha AXP Cabriolet build. Alpha AXP Cabriolet build
  fails with unresolved reference to ns87312_enable_ide().

-- END --

