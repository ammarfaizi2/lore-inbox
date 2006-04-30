Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWD3OSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWD3OSe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 10:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWD3OS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 10:18:26 -0400
Received: from host199-105.pool8255.interbusiness.it ([82.55.105.199]:23192
	"EHLO zion.home.lan") by vger.kernel.org with ESMTP
	id S1751134AbWD3OSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 10:18:01 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 0/7] Uml fixes for 2.6.17
Date: Sun, 30 Apr 2006 16:15:12 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060430141512.9060.39338.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes one "regression" in the 2.6.17 cycle (the mismerge of a
patch broke some code), makes UML compile & run with GCC hardened and fixes
some regressions of the compile infrastructure - special CFLAGS settings for
some files, needed in some configurations (say with profiling enabled) weren't
applied due to bad interactions with Kbuild. Finally, we make UML compatible
with Debian settings for uml_utilities (which conform to the FHS).

>From stg series:

+ uml-diagnose-64-bit-broken-padding    | uml: fix patch mismerge
+ uml-PATH-for-uml_net.patch            | uml: search from uml_net in a more
	reasonable PATH
+ uml-copy_user-inatomic-v2.patch       | uml: make copy_*_user atomic
+ uml-makefile-nicer                    | uml: use Kbuild tracking for all
	files and fix compilation output
+ uml-compile-nopic-clone-stub          | uml: fix compilation and execution
	with hardened GCC
+ uml-fix-unprofile-kbuild-interaction  | uml: cleanup unprofile expression
	and build infrastructure
+ uml-export-stack-protector-symbols    | uml: export symbols added by GCC
	hardened

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
