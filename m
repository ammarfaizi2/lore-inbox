Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbVIJSHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVIJSHn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 14:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbVIJSHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 14:07:40 -0400
Received: from ppp-62-11-72-160.dialup.tiscali.it ([62.11.72.160]:32424 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932173AbVIJSEa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 14:04:30 -0400
Message-Id: <20050910174628.104571000@zion.home.lan>
References: <20050910174452.907256000@zion.home.lan>
Date: Sat, 10 Sep 2005 19:44:55 +0200
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, Sam Ravnborg <sam@ravnborg.org>,
       Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: user-mode-linux-devel@lists.sourceforge.net
Subject: [patch 3/7] x86_64 linker script cleanups for debug sections
Content-Disposition: inline; filename=x86-64-link-script-cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new macros for x86_64 too.

Note that the current scripts includes different definitions; more exactly,
it only contains part of the DWARF2 sections and the .comment one from
Stabs. Shouldn't be a problem, anyway.

Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/x86_64/kernel/vmlinux.lds.S |   17 ++---------------
 1 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/x86_64/kernel/vmlinux.lds.S b/arch/x86_64/kernel/vmlinux.lds.S
--- a/arch/x86_64/kernel/vmlinux.lds.S
+++ b/arch/x86_64/kernel/vmlinux.lds.S
@@ -194,20 +194,7 @@ SECTIONS
 #endif
 	}
 
-  /* DWARF 2 */
-  .debug_info     0 : { *(.debug_info) }
-  .debug_abbrev   0 : { *(.debug_abbrev) }
-  .debug_line     0 : { *(.debug_line) }
-  .debug_frame    0 : { *(.debug_frame) }
-  .debug_str      0 : { *(.debug_str) }
-  .debug_loc      0 : { *(.debug_loc) }
-  .debug_macinfo  0 : { *(.debug_macinfo) }
-  /* SGI/MIPS DWARF 2 extensions */
-  .debug_weaknames 0 : { *(.debug_weaknames) }
-  .debug_funcnames 0 : { *(.debug_funcnames) }
-  .debug_typenames 0 : { *(.debug_typenames) }
-  .debug_varnames  0 : { *(.debug_varnames) }
+  STABS_DEBUG
 
-
-  .comment 0 : { *(.comment) }
+  DWARF_DEBUG
 }

--
