Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVC1FrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVC1FrD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 00:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVC1FrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 00:47:02 -0500
Received: from fire.osdl.org ([65.172.181.4]:20707 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261185AbVC1Fqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 00:46:43 -0500
Date: Sun, 27 Mar 2005 21:39:07 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: ak@suse.de
Subject: [PATCH] x86_64/lib: find_first_zero_bit not extern
Message-Id: <20050327213907.3d0a5842.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Exported function was marked inline:
arch/x86_64/lib/bitops.c:18: warning: `find_first_zero_bit' declared inline afte
r being called

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 arch/x86_64/lib/bitops.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./arch/x86_64/lib/bitops.c~x8664_lib_bitops ./arch/x86_64/lib/bitops.c
--- ./arch/x86_64/lib/bitops.c~x8664_lib_bitops	2005-03-01 23:37:49.000000000 -0800
+++ ./arch/x86_64/lib/bitops.c	2005-03-27 20:42:59.000000000 -0800
@@ -14,7 +14,7 @@
  * Returns the bit-number of the first zero bit, not the number of the byte
  * containing a bit.
  */
-inline long find_first_zero_bit(const unsigned long * addr, unsigned long size)
+long find_first_zero_bit(const unsigned long * addr, unsigned long size)
 {
 	long d0, d1, d2;
 	long res;


---
