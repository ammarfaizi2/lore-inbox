Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266240AbUHBDsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266240AbUHBDsd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 23:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266243AbUHBDsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 23:48:33 -0400
Received: from ozlabs.org ([203.10.76.45]:65508 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266240AbUHBDsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 23:48:31 -0400
Date: Mon, 2 Aug 2004 13:40:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       trivial@rustcorp.com.au, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: [TRIVIAL, PPC64] Remove #include processor.h from div64.S
Message-ID: <20040802034008.GB32216@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, trivial@rustcorp.com.au,
	linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply.

This patch removes a redundant #include of processor.h from
arch/ppc64/boot/div64.S.  I came across this because, at least with
the binutils versions I have currently installed, the 32-bit assembler
used for the bootstrap code objects to the // comments that recently
went into processor.h.

Signed-off-by: David Gibson <dwg@au.ibm.com>

Index: working-2.6/arch/ppc64/boot/div64.S
===================================================================
--- working-2.6.orig/arch/ppc64/boot/div64.S	2004-05-20 12:57:52.000000000 +1000
+++ working-2.6/arch/ppc64/boot/div64.S	2004-08-02 13:35:55.133943736 +1000
@@ -14,7 +14,6 @@
  * 2 of the License, or (at your option) any later version.
  */
 #include <asm/ppc_asm.h>
-#include <asm/processor.h>
 
 	.globl __div64_32
 __div64_32:


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
