Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWAQX2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWAQX2M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWAQX2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:28:12 -0500
Received: from [151.97.230.9] ([151.97.230.9]:55474 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932226AbWAQX2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:28:10 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH] uml: remove leftover from patch revertal
Date: Wed, 18 Jan 2006 00:26:27 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060117232626.11417.66832.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

I added this line to share this file with UML, but now it's no longer shared so
remove this useless leftover.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/asm-i386/futex.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-i386/futex.h b/include/asm-i386/futex.h
index e7a271d..44b9db8 100644
--- a/include/asm-i386/futex.h
+++ b/include/asm-i386/futex.h
@@ -61,7 +61,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	if (op == FUTEX_OP_SET)
 		__futex_atomic_op1("xchgl %0, %2", ret, oldval, uaddr, oparg);
 	else {
-#if !defined(CONFIG_X86_BSWAP) && !defined(CONFIG_UML)
+#ifndef CONFIG_X86_BSWAP
 		if (boot_cpu_data.x86 == 3)
 			ret = -ENOSYS;
 		else

